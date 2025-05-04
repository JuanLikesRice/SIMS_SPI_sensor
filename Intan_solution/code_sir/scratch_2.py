import numpy as np

def read_binary_save_file(filename):
    with open(filename, 'rb') as f:
        byte_data = np.frombuffer(f.read(), dtype=np.uint8)

    # Convert to uint16 (little-endian assumed)
    data_uint16 = byte_data.view(np.uint16).byteswap()

    # Convert to float64
    data = data_uint16.astype(np.float64)
    i   = 1
    A_i = i*32+1
    B_i = A_i+3
    C_i = B_i+8
    D_i = C_i+1
    E_i = D_i+1
    print(A_i, B_i, C_i, D_i,E_i)

    # Reshape according to 46 signals (as in MATLAB)
    print(data.size % E_i)
    assert data.size % E_i == 0, "File does not contain full data frames."
    data = data.reshape((E_i, -1), order='F')  # Fortran-style to match MATLAB column-major

    # Split data into named arrays
    timestamp      = data[0, :]

    amplifier_data = data[1:A_i, :]         # 32 channels
    # amplifier_data = data[1:33, :]         # 32 channels

    auxiliary_data = data[A_i:B_i, :]        # 3 channels
    boardADC_data  = data[B_i:C_i, :]         # 8 channels
    TTLin = data[C_i, :]
    TTLout = data[D_i, :]

    return {
        'timestamp': timestamp,
        'amplifier_data': amplifier_data,
        'auxiliary_data': auxiliary_data,
        'boardADC_data': boardADC_data,
        'TTLin': TTLin,
        'TTLout': TTLout
    }

# Example usage:
data = read_binary_save_file('binary_save_file.dat')
print("Timestamps shape:", data['timestamp'].shape)
print("Amplifier data shape:", data['amplifier_data'].shape)


print(data['amplifier_data'][0, :])  # Print first channel data



import numpy as np
import matplotlib.pyplot as plt

def plot_amplifier_data_o(data, channel_index):
    i = channel_index

    # Extract the amplifier data for the specified channel
    y = data['amplifier_data'][i, :]

    # Select odd-indexed elements (indices 1, 3, 5, ...)
    y_odd = y[1::2]
    x_odd = np.arange(1, len(y), 2)

    # Define the starting point for plotting
    a = 1000

    # print(f"EVEN Last emement of C {i} is {y_even[-1]}")
    print(f"ODD  Last emement of C {i} is {y_odd[-1]}")

    # Plotting
    plt.figure(figsize=(10, 4))
    plt.plot(x_odd[a:], y_odd[a:], marker='o', linestyle='-')
    plt.title(f'Plot of Odd-Indexed Elements - Channel {i}')
    plt.xlabel('Index')
    plt.ylabel('Value')
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(f"channel_plot_{i}_odd.png")
    plt.close()


def plot_amplifier_data(data, channel_index):

    i = channel_index
    import matplotlib.pyplot as plt


    import numpy as np
    import matplotlib.pyplot as plt

    # Example 1D NumPy array
    y = data['amplifier_data'][i, :]
    import numpy as np
    import matplotlib.pyplot as plt

    # ed elements (indices 0, 2, 4, ...)
    y_even = y[::2]
    print(f"EVEN Last emement of C {i} is {y_even[-1]}")
    x_even = np.arange(0, len(y), 2)

    # Plotting
    a = 1000
    plt.figure(figsize=(10, 4))
    plt.plot(x_even[a:], y_even[a:], marker='o', linestyle='-')
    plt.title('Plot of Even-Indexed Elements')
    plt.xlabel('Index')
    plt.ylabel('Value')
    plt.grid(True)
    plt.tight_layout()
    plt.savefig(f"channel_plot_{i}.png")

ak = 32
for b in range(0, ak +1):

    plot_amplifier_data(data,   b)
    plot_amplifier_data_o(data, b)





# plt.show()
# # Replace 'I' with the desired channel index (0-based)
# I = 0  # For the first channel
# # Assuming 'data' is the dictionary returned by read_binary_save_file
# plt.figure(figsize=(10, 4))
# plt.plot(data['timestamp'], data['amplifier_data'][I, :])
# plt.title(f'Amplifier Channel {I + 1}')
# plt.xlabel('Time (samples)')
# plt.ylabel('Amplitude')
# plt.grid(True)
# plt.tight_layout()
