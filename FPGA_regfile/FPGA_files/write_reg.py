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



def read_wire_out(dev,address):
    dev.UpdateWireOuts()
    ep20_val = dev.GetWireOutValue(address)
    out_value = (ep20_val >> 8) & 0x7F  
    out_debug = ep20_val & 0x7F
    # print(f"Extracted ep{address}_val value: {ep20_val}")
    # print(f"Extracted out value: {out_value}")
    print(f"Extracted out_debug value: {out_debug}")
    # return out_value, out_debug


# # wire_in_address     = 0x00  
# # value_to_send       = 0x00
# # dev.SetWireInValue(wire_in_address, value_to_send)
# # dev.UpdateWireIns() 


ep00wirein_address  = 0x00
ep40trigin_address  = 0x00
ep41trigin_address  = 0x01
ep40trigin_address_i  = 0x40
ep41trigin_address_i  = 0x41

ep20wireout_address = 0x20
ep21wireout_address = 0x3e

value_to_send       = 0x00
dev.SetWireInValue(ep00wirein_address, value_to_send)
dev.UpdateWireIns()  
time.sleep(0.5)

# for i in range(5):
#     command = 0x80
#     time.sleep(0.25)  
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     command = 0x00
#     dev.SetWireInValue(ep41trigin_address, command)
#     dev.UpdateWireIns()  
#     time.sleep(0.25) 


def reset(dev):
    command = 0x80
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns()  
    time.sleep(0.1) 
    command = 0x00
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns() 

def write(dev):
    command = 0x0107
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns()  
    time.sleep(0.1) 
    command = 0x8107
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns() 
    time.sleep(0.1) 
    command = 0x0000
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns() 
    time.sleep(0.1) 

def write_trigger(dev):
    command = 0x0107
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns()  
    time.sleep(0.1) 
    dev.ActivateTriggerIn(ep41trigin_address_i, 0)
    time.sleep(0.1) 
    command = 0x0000
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns() 
    time.sleep(0.1) 

def write_trigger_i(dev,wr_addr,data):

    command = ((wr_addr & 0x7F) << 8) | (data & 0x7F)
    # command = 0x0107
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns()  
    time.sleep(0.1) 
    dev.ActivateTriggerIn(ep41trigin_address_i, 0)
    time.sleep(0.1) 
    command = 0x0000
    dev.SetWireInValue(ep41trigin_address, command)
    dev.UpdateWireIns() 
    time.sleep(0.1)

#     command = ((in_val & 0x7F) << 16) | \
#               ((wr_addr & 0x7F) << 8) | \
#               (data & 0x7F)
    




reset(dev) 
# write(dev)

# write_trigger(dev)

for i in range(10):
    wr_addr = i
    data    = 100-i*4
    write_trigger_i(dev,wr_addr,data)
# wr_addr = 1
# data    = 7
# write_trigger_i(dev,wr_addr,data)
for i in range(10):

    value_to_send       = (i & 0xFF )
    dev.SetWireInValue(ep00wirein_address, value_to_send)
    dev.UpdateWireIns()  
    time.sleep(0.5)
    print(f"\nAddress: {value_to_send}")
    read_wire_out(dev,ep20wireout_address)





# command = 0x8101

# dev.ActivateTriggerIn(ep40trigin_address, 1)
# dev.ActivateTriggerIn(ep41trigin_address, 1)

# value_to_send       = 0x01

# dev.SetWireInValue(ep00wirein_address, value_to_send)
# dev.UpdateWireIns()  
# time.sleep(0.5)


read_wire_out(dev,ep20wireout_address)
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


