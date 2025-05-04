import os
import sys
import time
import socket
import random
import ok


file_dir = os.path.dirname(os.path.realpath(__file__))
parent_dir = os.path.dirname(file_dir)
sys.path.append(parent_dir)
dev_info = ok.okTDeviceInfo()
print("------ PipeTest Application fot Python API ----------")
print("Front Panel API version: {}".format(ok.okCFrontPanel_GetAPIVersionString()))
dev = ok.okCFrontPanel()
error_code = dev.OpenBySerial("")
if error_code != 0:
    print('Could not open the device.')
    print(error_code)
    sys.exit(1)



def initialize_FPGA(dev: ok.okCFrontPanel, bit_file_path):
    dev.GetDeviceInfo(dev_info)
    print("Found device: {}".format(dev_info.productName))
    dev.LoadDefaultPLLConfiguration()
    print('Device firmware version: {}.{}'.format(dev_info.deviceMajorVersion, dev_info.deviceMinorVersion))
    print('Device serial number: {}'.format(dev_info.serialNumber))
    print('Device ID: {}'.format(dev_info.productID))
    print(f"loading {bit_file_path} as bit file")
    if (dev.ConfigureFPGA(bit_file_path) != ok.okCFrontPanel.NoError):
        print("Fpga configuration failed.")
        return False
    print("success configuration")
initialize_FPGA(dev, sys.argv[1])



ep00wirein_address =  0x00
ep01wirein_address =  0x01
ep02wirein_address =  0x02
ep03wirein_address =  0x03
ep04wirein_address =  0x04
ep05wirein_address =  0x05
ep06wirein_address =  0x06
ep07wirein_address =  0x07
ep08wirein_address =  0x08
ep09wirein_address =  0x09
ep0awirein_address =  0x0A
ep0bwirein_address =  0x0B
ep0cwirein_address =  0x0C
ep0dwirein_address =  0x0D
ep0ewirein_address =  0x0E
ep0fwirein_address =  0x0F
ep10wirein_address =  0x10
ep11wirein_address =  0x11
ep12wirein_address =  0x12
ep13wirein_address =  0x13
ep14wirein_address =  0x14
ep15wirein_address =  0x15
ep16wirein_address =  0x16
ep17wirein_address =  0x17
ep18wirein_address =  0x18
ep19wirein_address =  0x19
ep1awirein_address =  0x1A
ep1bwirein_address =  0x1B              
ep1cwirein_address =  0x1C
ep1dwirein_address =  0x1D
ep1ewirein_address =  0x1E
ep1fwirein_address =  0x1F

# Trigger in endpoints
ep40trigin_address =  0x40
ep41trigin_address =  0x41

# wire out endpoints
ep20wireout_address = 0x20
ep21wireout_address = 0x21
ep22wireout_address = 0x22
ep23wireout_address = 0x23
ep24wireout_address = 0x24
ep25wireout_address = 0x25

ep3dwireout_address = 0x3D
ep3ewireout_address = 0x3E
ep3fwireout_address = 0x3F
# ep22wireout_address = 0x16
# ep24wireout_address = 0x18
# epPipeOut_address   = 0xA0




# functions
def write_wr_in(dev,wr_addr,data,mask = 0xffffffff):
    dev.SetWireInValue(wr_addr, data,mask)
    dev.UpdateWireIns()  
def reset_sig(dev,ep_address):
    write_wr_in(dev,ep_address,0x00000001,mask=0x00000001)
    time.sleep(0.1)
    write_wr_in(dev,ep_address,0x00000000)
    time.sleep(0.1)
def write_length(dev,ep05wirein_address,length):
    write_wr_in(dev,ep05wirein_address,length)
    time.sleep(0.1)

def trigger_in(dev,ep41trigin_address,index):
    dev.ActivateTriggerIn(ep41trigin_address, index)

def trigger_spi(dev,ep41trigin_address):
    dev.ActivateTriggerIn(ep41trigin_address, 0)
    time.sleep(0.1)
def read_wire_out(dev,address):
    dev.UpdateWireOuts()
    ep20_val = dev.GetWireOutValue(address)
    return ep20_val
    # out_value = (ep20_val >> 8) & 0x7F  
    # out_debug = ep20_val & 0x7F
    # # print(f"Extracted ep{address}_val value: {ep20_val}")
    # # print(f"Extracted out value: {out_value}")
    # print(f"Extracted out_debug value: {out_debug}")
    # # return out_value, out_debug


def read_wire_out_print(dev, address, mode='dec'):
    dev.UpdateWireOuts()
    ep_val = dev.GetWireOutValue(address)
    if mode == 'hex':
        print(f"WireOut {hex(address)}: 0x{ep_val:04X}")
    else:  # default to decimal
        print(f"WireOut {hex(address)}: {ep_val}")
    return ep_val




set_of_32 = 2
length = 0x3F



# ep20wireout =    num_words_in_FIFO;
# ep21wireout =    { 16'b0, 12'b0, expander_ID_1, expander_detect, TTL_in_serial_exp, TTL_in_serial };
# ep22wireout =    { 16'b0, 15'b0, SPI_running };
# ep23wireout =    { 16'b0, TTL_in };
# ep24wireout =    { 16'b0, 14'b0, MMCM_prog_done, dataclk_locked };
# ep25wireout =    { 16'b0, 12'b0, board_mode };
# ep3ewireout =    { 16'b0, BOARD_ID };
# ep3fwireout =    { 16'b0, BOARD_VERSION };


def write_usb3_blocksize(dev,usb3_blocksize=0x00000000):
    write_wr_in(dev,ep1fwirein_address,usb3_blocksize)
    trigger_in(dev,ep40trigin_address,index=9)
def write_ddr_blocksize(dev,ddr_blocksize=0x00000000):
    write_wr_in(dev,ep1fwirein_address,ddr_blocksize)
    trigger_in(dev,ep40trigin_address,index=10)

def write_dataclk_MD(dev,Hex_00_M_D=0x00002A19):
    write_wr_in(dev,ep03wirein_address,Hex_00_M_D)
    trigger_in(dev,ep40trigin_address,index=0)      # MMCM_prog_trigger

def enable_streams(dev, enable_hex=0x00000000):
    write_wr_in(dev,ep14wirein_address,enable_hex) 

def write_DSP_settle_en(dev,Hex=0x00000000):
    write_wr_in(dev,ep1fwirein_address,Hex)
    trigger_in(dev,ep40trigin_address,index=6)  
    # trigger_in(dev,ep40trigin_address,index=7)      # MMCM_prog_trigger

def write_DAC_set_zero(dev):
    write_wr_in(dev,ep1fwirein_address,0x00000000)
    for i in range(32):
        trigger_in(dev,ep40trigin_address,index=i)  

def write_delay(dev,delay=0x00000001):
    write_wr_in(dev,ep04wirein_address,delay,mask=0x0000000f)

def write_max_time_samples(dev,time_step=0x00000100):
    write_wr_in(dev,ep01wirein_address,time_step)

def dac_stuff(dev):
    write_wr_in(dev,ep08wirein_address,0x00000000) 
    write_wr_in(dev,ep09wirein_address,0x00000000) 
    write_wr_in(dev,ep0awirein_address,0x00000000) 
    write_wr_in(dev,ep0bwirein_address,0x00000000) 
    write_wr_in(dev,ep0cwirein_address,0x00000000) 
    write_wr_in(    dev,ep15wirein_address,0x00000000) 
    write_wr_in(    dev,ep16wirein_address,0x00000000) 
    write_wr_in(    dev,ep17wirein_address,0x00000000) 
    write_wr_in(    dev,ep18wirein_address,0x00000000) 
    write_wr_in(    dev,ep19wirein_address,0x00000000) 
    write_wr_in(    dev,ep1awirein_address,0x00000000) 
    write_wr_in(    dev,ep1bwirein_address,0x00000000) 
    write_wr_in(    dev,ep1cwirein_address,0x00000000) 
    write_wr_in(    dev,ep1dwirein_address,0x00000000) 
    write_wr_in(    dev,ep1ewirein_address,0x00000000) 

# write_out wires status
# read_wire_out_print(dev, ep20wireout_address, mode='hex')
# read_wire_out_print(dev, ep21wireout_address, mode='hex')
# read_wire_out_print(dev, ep22wireout_address, mode='hex')
# read_wire_out_print(dev, ep23wireout_address, mode='hex')
# read_wire_out_print(dev, ep24wireout_address, mode='hex')
# read_wire_out_print(dev, ep25wireout_address, mode='hex')
# read_wire_out_print(dev, ep3ewireout_address, mode='hex')
# read_wire_out_print(dev, ep3ewireout_address, mode='dec')
read_wire_out_print(dev, ep3fwireout_address, mode='hex')
read_wire_out_print(dev, ep3fwireout_address, mode='dec')


print("FPGA is ready, starting INTAN configuration...")
#Trigger_in40 
reset_sig(              dev,    ep00wirein_address)
print("Reset done")
write_usb3_blocksize(   dev,    usb3_blocksize=0x00000000)
write_ddr_blocksize(    dev,    ddr_blocksize =0x00000000)   
write_dataclk_MD(       dev,    Hex_00_M_D    =0x00002A19) #

while (read_wire_out_print(dev, ep24wireout_address, mode='hex') != 0x00000003):
    print("Waiting for FPGA to be ready...")
    # time.sleep(0.5)

# DAC off, not used in this version
dac_stuff(dev)
enable_streams( dev, enable_hex=0x00000001)

write_DSP_settle_en(dev)
write_DAC_set_zero(dev)
write_delay(dev,delay=0x00000001)
write_max_time_samples(dev,time_step=0x00000100)



# read_wire_out_print(dev, ep3dwireout_address, mode='hex')
# # write_wr_in(dev,ep1fwirein_address,0x00000001 mask =0xffffffff)
# write_wr_in(dev,ep00wirein_address,0x00000001, mask=0x00000002)
# read_wire_out_print(dev, ep3dwireout_address, mode='hex')
# write_wr_in(dev,ep00wirein_address,0x00000001,mask=0x00000001)
# read_wire_out_print(dev, ep3dwireout_address, mode='hex')


# ep1ewirein

write_length(dev,   ep05wirein_address, length)
trigger_spi( dev,   ep41trigin_address)
print_out_in = read_wire_out(dev,  ep24wireout_address)

print(f"Print out in: {print_out_in}")
print("FPGA configured successfully.")

# Define the endpoint address for the Block-Throttled Pipe Out.
ep_addr = epPipeOut_address
num_bytes = 32*4*set_of_32   # 128 bytes

# Create a mutable data buffer.
data = bytearray(num_bytes)

# Read data from the Block-Throttled Pipe Out endpoint.
ret = dev.ReadFromBlockPipeOut(ep_addr, num_bytes, data)

if ret < 0:
    print("Error reading from Block Pipe Out. Error code:", ret,num_bytes,data)
else:
    # # Convert the 128 bytes into 32 32-bit words (assuming little-endian order).
    # words = []
    # for i in range(0, num_bytes, 4):
    #     word = data[i] | (data[i+1] << 8) | (data[i+2] << 16) | (data[i+3] << 24)
    #     words.append(word)
    # print("Received 32 words:")
    # print(words)

# Convert the 128 bytes into 32 tuples (index, data)
    pairs = []
    for i in range(0, num_bytes, 4):
        # Construct the 32-bit word from 4 bytes (little-endian)
        word = data[i] | (data[i+1] << 8) | (data[i+2] << 16) | (data[i+3] << 24)
        # Extract the first half (most significant 16 bits) as index
        index = (word >> 16) & 0xFFFF
        # Extract the second half (least significant 16 bits) as data
        value = word & 0xFFFF
        pairs.append((index, value))

    print("Received 32 (index, data) pairs:")
    for index, value in pairs:
        print(f"Index: {index}, Value: {value}")
    # print(pairs)






#/*
#Code below was never used, but was used to test the trigger in and out of the FPGA.
#
#*/







# 
# ep00wirein_address  = 0x00
# ep40trigin_address  = 0x00
# ep41trigin_address  = 0x01
# ep40trigin_address_i  = 0x40
# ep41trigin_address_i  = 0x41

# ep20wireout_address = 0x20
# ep21wireout_address = 0x3e

# value_to_send       = 0x00
# dev.SetWireInValue(ep00wirein_address, value_to_send)
# dev.UpdateWireIns()  
# time.sleep(0.5)

# def reset(dev):
#     command = 0x80
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     command = 0x00
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 



# def write(dev):
#     command = 0x0107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     command = 0x8107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1) 
#     command = 0x0000
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1) 

# def write_trigger(dev):
#     command = 0x0107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     dev.ActivateTriggerIn(ep41trigin_address_i, 0)
#     time.sleep(0.1) 
#     command = 0x0000
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1) 

# def write_trigger_i(dev,wr_addr,data):

#     command = ((wr_addr & 0x7F) << 8) | (data & 0x7F)
#     # command = 0x0107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     dev.ActivateTriggerIn(ep41trigin_address_i, 0)
#     time.sleep(0.1) 
#     command = 0x0000
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1)


# reset(dev) 

# for i in range(10):
#     wr_addr = i
#     data    = 100-i*4
#     write_trigger_i(dev,wr_addr,data)
# # wr_addr = 1
# # data    = 7
# # write_trigger_i(dev,wr_addr,data)
# for i in range(10):

#     value_to_send       = (i & 0xFF )
#     dev.SetWireInValue(ep00wirein_address, value_to_send)
#     dev.UpdateWireIns()  
#     time.sleep(0.5)
#     print(f"\nAddress: {value_to_send}")
#     read_wire_out(dev,ep20wireout_address)

# read_wire_out(dev,ep20wireout_address)



# REAL CODE STARTS HERE

# ep00wire_address = 0x00 # adzdress you are writing to 
# for i in range(1000):  # You can set the range as needed
#     # print(i) 
#     ep00wire = i  # led light value set
#     dev.UpdateWireOuts() # updates input wire
#     # ep20wire =  dev.GetWireOutValue(0x20)
#     # print(f"ep20wire is: {ep20wire}") # reads input buffer
#     ep21wire =  dev.GetWireOutValue(0x21)
#     print(f"measured frequnecy is: {ep21wire:,}Mh") # reads input buffer
#     # #Set Values for wire out
#     dev.SetWireInValue(ep00wire_address, ep00wire) # LED lights
#     dev.UpdateWireIns() # updates inpit registers (connected to output buffer)
# #     time.sleep(1)  # Wait for 1 second


# import time
# import ok

# def send_trigger_command(dev, data, reset, wr_addr, write_enable, in_val):
#     command = ((in_val & 0x7F) << 16) | ((write_enable & 0x1) << 15) | \
#               ((wr_addr & 0x7F) << 8)   | ((reset & 0x1) << 7)     | \
#               (data & 0x7F)
    
#     # The trigger in endpoint for ep41trigin is typically at address 0x41.
#     ep_addr = 0x41
#     dev.ActivateTriggerIn(ep_addr, command)

#     # # Loop through the 23 bits and send a pulse for each bit that is 1.
#     # for bit in range(23):
#     #     if (command >> bit) & 0x1:
#     #         dev.ActivateTriggerIn(ep_addr, command)
#     #         # Optionally, wait a short time between pulses if needed.
#     #         time.sleep(0.001)

#     print(f"Sent trigger command: 0x{command:06X}")



# def read_wire_out(dev,address):
#     dev.UpdateWireOuts()
#     ep20_val = dev.GetWireOutValue(address)
#     out_value = (ep20_val >> 8) & 0x7F  
#     out_debug = ep20_val & 0x7F
#     # print(f"Extracted ep{address}_val value: {ep20_val}")
#     # print(f"Extracted out value: {out_value}")
#     print(f"Extracted out_debug value: {out_debug}")
#     # return out_value, out_debug


# # wire_in_address     = 0x00  
# # value_to_send       = 0x00
# # dev.SetWireInValue(wire_in_address, value_to_send)
# # dev.UpdateWireIns() 


# ep00wirein_address  = 0x00
# ep40trigin_address  = 0x00
# ep41trigin_address  = 0x01
# ep40trigin_address_i  = 0x40
# ep41trigin_address_i  = 0x41

# ep20wireout_address = 0x20
# ep21wireout_address = 0x3e

# value_to_send       = 0x00
# dev.SetWireInValue(ep00wirein_address, value_to_send)
# dev.UpdateWireIns()  
# time.sleep(0.5)

# for i in range(5):
#     command = 0x80
#     time.sleep(0.25)  
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     command = 0x00
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.25) 


# def reset(dev):
#     command = 0x80
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     command = 0x00
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 

# def write(dev):
#     command = 0x0107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     command = 0x8107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1) 
#     command = 0x0000
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1) 

# def write_trigger(dev):
#     command = 0x0107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     dev.ActivateTriggerIn(ep41trigin_address_i, 0)
#     time.sleep(0.1) 
#     command = 0x0000
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1) 

# def write_trigger_i(dev,wr_addr,data):

#     command = ((wr_addr & 0x7F) << 8) | (data & 0x7F)
#     # command = 0x0107
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.1) 
#     dev.ActivateTriggerIn(ep41trigin_address_i, 0)
#     time.sleep(0.1) 
#     command = 0x0000
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns() 
#     time.sleep(0.1)

#     command = ((in_val & 0x7F) << 16) | \
#               ((wr_addr & 0x7F) << 8) | \
#               (data & 0x7F)
    





# write(dev)

# write_trigger(dev)





# command = 0x8101

# dev.ActivateTriggerIn(ep40trigin_address, 1)
# dev.ActivateTriggerIn(ep41trigin_address, 1)

# value_to_send       = 0x01

# dev.SetWireInValue(ep00wirein_address, value_to_send)
# dev.UpdateWireIns()  
# time.sleep(0.5)


# read_wire_out(dev,ep21wireout_address)
# print("Sending trigger command")
# # send_trigger_command(dev, data=0x0, reset=1, wr_addr=0, write_enable=0, in_val=0x0)

# # send_trigger_command(dev, data=0x1, reset=0, wr_addr=0, write_enable=1, in_val=0x0)



# wire_in_address     = 0x00  
# value_to_send       = 0x00

# for i in range(30):
#     dev.SetWireInValue(wire_in_address, value_to_send)
#     dev.UpdateWireIns()  
#     time.sleep(0.5)
#     value_to_send += 1



# out_val, out_dbg = read_wire_out(dev)





# dev.UpdateWireOuts()
# ep20_val = dev.GetWireOutValue(0x20)
# out_value = (ep20_val >> 8) & 0x7F  
# out_debug = ep20_val & 0x7F
# print(f"Extracted ep20_val value: {ep20_val}")
# print(f"Extracted out value: {out_value}")
# print(f"Extracted out_debug value: {out_debug}")


