
import struct
from scipy import ndimage
import sys
import numpy as np

import fileinput


def bin_to_float(b):
      """ Convert binary string to a float. """
      f = int(b, 2)  
      return struct.unpack('f', struct.pack('I', f))[0]

for i in range(4):
    with open ('D://CNN//out_verilog//float_conv3d_result' +'_{0}.txt'.format(i),'w') as f1:
        with open ('D://CNN//out_verilog//conv3d_result' +'_{0}.txt'.format(i),'r') as f:
            string = f.readlines()
            for line in string :
                float_string  = bin_to_float(line)
                f1.write(str(float_string))           
                f1.write("\n")
        f.close()
    f1.close()
for i in range(8):
    with open ('D://CNN//out_verilog//float_conv3d_1_result' +'_{0}.txt'.format(i),'w') as f1:
        with open ('D://CNN//out_verilog//conv3d_1_result' +'_{0}.txt'.format(i),'r') as f:
            string = f.readlines()
            for line in string :
                float_string  = bin_to_float(line)
                f1.write(str(float_string))           
                f1.write("\n")
        f.close()
    f1.close()
for i in range(16):
    with open ('D://CNN//out_verilog//float_conv3d_2_result' +'_{0}.txt'.format(i),'w') as f1:
        with open ('D://CNN//out_verilog//conv3d_2_result' +'_{0}.txt'.format(i),'r') as f:
            string = f.readlines()
            for line in string :
                float_string  = bin_to_float(line)
                f1.write(str(float_string))           
                f1.write("\n")
        f.close()
    f1.close()



_max = 0

for i in range(4):

    with open('D://CNN//software//result_layer//conv2d_result' +'_{0}.txt'.format(i),'r') as f:
        with open('D://CNN//out_verilog//float_conv3d_result' + '_{0}.txt'.format(i),'r') as f1:
            for j in range(1024):
                string0 =  f.readline()
                string1 = f1.readline()
                
                a = abs( float(string1) - float(string0))
                if (a > _max): 
                    _max = a
        f1.close()
    f.close()
                
print("max_conv2d_result: \n", _max)
            
_max_ = 0
for i in range(8):

    with open('D://CNN//software//result_layer//conv2d_1_result' +'_{0}.txt'.format(i),'r') as f:
        with open('D://CNN//out_verilog//float_conv3d_1_result' + '_{0}.txt'.format(i),'r') as f1:
            for j in range(256):
                string0 = f.readline()
                string1 = f1.readline()
                
                
                a = abs(float(string1) - float(string0))
                if (a > _max_): 
                    _max_ = a
        f1.close()
    f.close()


print("max_conv2d_1_result: \n", _max_)
_max__ = 0
for i in range(16):

    with open('D://CNN//software//result_layer//conv2d_2_result' +'_{0}.txt'.format(i),'r') as f:
        with open('D://CNN//out_verilog//float_conv3d_2_result' + '_{0}.txt'.format(i),'r') as f1:
            for j in range(64):
                string0 = f.readline()
                string1 = f1.readline()
                
                
                a = abs(float(string1) - float(string0))
                if (a > _max__): 
                    _max__ = a
        f1.close()
    f.close()
print("max_conv2d_2_result: \n", _max__)
sum_ = 0
with open("D://CNN//software//result_layer//flatten_result_15.txt" ,'r') as f:
    with open("D://CNN//weight//W0.txt",'r') as f1:
        for j in range(256):
            string0 = f.readline()
            string1 = f1.readline()
            float_str = bin_to_float(string1)
            
            product = (float(float_str) * float(string0))
            sum_ = sum_ + product
        
        string1 = f1.readline()
        float_str = bin_to_float(string1)
        sum_ = sum_ + float(float_str)
    f1.close()
f.close()
print("class0", sum_)

sum__ = 0
with open("D://CNN//software//result_layer//flatten_result_15.txt" ,'r') as f:
    with open("D://CNN//weight//W1.txt",'r') as f1:
        for j in range(256):
            string0 = f.readline()
            string1 = f1.readline()
            float_str = bin_to_float(string1)
            
            product = (float(float_str) * float(string0))
            sum__ = sum__ + product
        
        string1 = f1.readline()
        float_str = bin_to_float(string1)
        sum__ = sum__ + float(float_str)
    f1.close()
f.close()
print("class1", sum__)