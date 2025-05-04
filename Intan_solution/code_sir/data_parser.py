import matplotlib.pyplot as plt

file_path = "out_preparser.txt"
MAGIC_NUMBER = 0xd7a22aaa38132a53

def extract_bytes_from_words(words):
    """Extract bytes from 16-bit words in big-endian order"""
    bytes_out = []
    for w in words:
        high = (w >> 8) & 0xFF
        low = w & 0xFF
        bytes_out.extend([high, low])
    return bytes_out

def print_debug_header(header_words):
    header_bytes = extract_bytes_from_words(header_words)
    print(f"\nRaw header bytes (BE per word): {[f'{b:02x}' for b in header_bytes]}")
    
    reversed_bytes = header_bytes[::-1]
    print(f"Reordered header bytes: {[f'{b:02x}' for b in reversed_bytes]}")
    
    header_value = int.from_bytes(reversed_bytes, byteorder='big')
    print(f"Reconstructed header value: {header_value:#018x}")
    print(f"Expected magic number:     {MAGIC_NUMBER:#018x}")
    print(f"Match? {'✅' if header_value == MAGIC_NUMBER else '❌'}")

def read_sensor_file(filepath, num_data_streams=32):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    words = [int(line.strip(), 16) for line in lines]

    frames = []
    i = 0
    frame_size = 4 + 2 + num_data_streams * 2 + 2  # 4 bytes header, 2 bytes timestamp, 2 bytes per data stream

    while i + frame_size <= len(words):
        header_words = words[i:i+4]
        timestamp_words = words[i+4:i+6]
        data_words = words[i+6:i+6+num_data_streams*2]  # 2 16-bit values per stream
        filler_words = words[i+6+num_data_streams*2:i+6+num_data_streams*2+2]  # 2 filler words
        adc_words = words[i+6+num_data_streams*2+2:i+6+num_data_streams*2+10]  # 8 ADC results

        # Process header
        header_bytes = extract_bytes_from_words(header_words)[::-1]  # reverse whole thing
        header = int.from_bytes(header_bytes, byteorder='big')

        if header != MAGIC_NUMBER:
            i += 1
            continue

        # Process timestamp
        ts_bytes = extract_bytes_from_words(timestamp_words)[::-1]
        timestamp = int.from_bytes(ts_bytes, byteorder='big')

        # Process sensor data
        sensor_data = []
        for w in data_words:
            b = extract_bytes_from_words([w])[::-1]
            val = int.from_bytes(b, byteorder='big')
            sensor_data.append(val)

        # Process ADC values (just for reference)
        adc_data = []
        for w in adc_words:
            b = extract_bytes_from_words([w])[::-1]
            val = int.from_bytes(b, byteorder='big')
            adc_data.append(val)

        # Add this frame's data to the list
        frames.append({
            'timestamp': timestamp,
            'sensor_data': sensor_data,
            'adc_data': adc_data
        })

        i += frame_size

    return frames

# Read the sensor data from the file
frames = read_sensor_file('out_preparser.txt', num_data_streams=32)

# Plot the sensor data
timestamps = [f['timestamp'] for f in frames]

# We will plot the first 5 sensor data streams for visualization
for stream_index in range(5):
    sensor_stream = [f['sensor_data'][stream_index] for f in frames]
    plt.plot(timestamps, sensor_stream, label=f"Stream {stream_index+1}")

plt.xlabel("Timestamp")
plt.ylabel("Signal")
plt.title("Neural Sensor Data Streams")
plt.legend()
plt.show()
