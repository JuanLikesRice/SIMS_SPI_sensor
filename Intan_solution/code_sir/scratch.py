i = 0
m = 100000
with open('binary_save_file.dat', 'rb') as infile, open('output_file.txt', 'w') as outfile:
    while True:
        chunk = infile.read(2)  # 32bits to 4 bytes
        if not chunk:
            break
        if i > m :
            break
        i += 1

        outfile.write(chunk.hex()  + '\n')



# with open('binary_save_file.dat', 'rb') as infile, open('output_file.txt', 'w') as outfile:
#     while True:
#         chunk = infile.read(4)
#         if len(chunk) < 4:
#             break  # Stop if fewer than 4 bytes left

#         lower_16 = chunk[2:4]
#         outfile.write(lower_16[::-1].hex() + '\n')

