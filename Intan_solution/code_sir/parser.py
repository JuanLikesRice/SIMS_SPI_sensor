import matplotlib.pyplot as plt

MAGIC_NUMBER = 0xD7a22aaa38132a53

def parse_sensor_data(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    # Step 1: Strip lines, convert from hex, extract upper 16 bits
    
    words = [(int(line.strip(), 16) >> 16) & 0xFFFF for line in lines if line.strip()]
    print(words[:50])
    print(f"Number of words: {len(words)}")
    frames = []
    i = 0
    while i + 5 < len(words):
        if i < 100:
            print(i,words[i:i+4])
            
        # Reconstruct 64-bit header from 4 x 16-bit words (little endian)
        header_words = words[i:i+4]
        header = (
            (header_words[3] << 48) |
            (header_words[2] << 32) |
            (header_words[1] << 16) |
            (header_words[0])
        )

        if header != MAGIC_NUMBER:
            #print(f"Sync error at word index {i}: header 0x{header:016x} != MAGIC_NUMBER")
            i += 1
            continue

        # Timestamp is next 2 words (32-bit)
        timestamp = (words[i+5] << 16) | words[i+4]

        # The rest is sensor data — frame length depends on configuration
        # Assuming 512 words per frame (adjust as needed)
        frame_length = 516  # 4 header + 2 timestamp + 510 data
        if i + frame_length > len(words):
            break

        data = words[i+6:i+frame_length]
        frames.append((timestamp, data))
        i += frame_length
    print(f"Last timestamp: {timestamp}")
    return frames

# def plot_sensor_channel(frames, channel_index=0):
#     timestamps = [ts for ts, _ in frames]
#     channel_values = [data[channel_index] for _, data in frames if len(data) > channel_index]

#     plt.plot(timestamps, channel_values)
#     plt.xlabel('Timestamp')
#     plt.ylabel(f'Channel {channel_index + 1} Value')
#     plt.title(f'Sensor Data - Channel {channel_index + 1}')
#     plt.grid(True)
#     plt.show()

# # Example usage:
# frames = parse_sensor_data('out2.txt')
# plot_sensor_channel(frames, channel_index=10)  # Change index for different channels

def plot_all_channels_on_one_plot(frames, num_channels=35):
    plt.figure(figsize=(10, 6))  # Create a single figure to plot all channels

    # Loop over all channels
    for channel_index in range(num_channels):
        # Extract the channel data for all frames
        timestamps = [ts for ts, _ in frames]
        channel_values = [data[channel_index] for _, data in frames if len(data) > channel_index]

        # Plot each channel
        plt.plot(timestamps, channel_values, label=f'Channel {channel_index + 1}')

    # Labels and title
    plt.xlabel('Timestamp')
    plt.ylabel('Sensor Value')
    plt.title('Sensor Data - All Channels')

    # Set y-axis scale
    plt.yscale('linear')

    plt.legend()  # Show a legend to differentiate the channels
    plt.grid(True)
    plt.savefig("output.png", dpi=300)  # Save the plot as a PNG file

# Example usage:
frames = parse_sensor_data('output_emulator.txt')
print(f"Number of frames: {len(frames)}")
print(f"Number of words in first frame: {len(frames[0][1]) if frames else 0}")
# plot_all_channels_on_one_plot(frames, num_channels=35)
