from re import I
import jinja2
import numpy as np # linear algebra
#import matplotlib.pyplot as plt
#from tensorflow.keras.utils import plot_model
import sys
import struct
from numpy.lib.function_base import append
import math 
#import yaml
np.set_printoptions(threshold=sys.maxsize)
# Splitting data
def float_to_bin(value):
	#return struct.unpack('Q', struct.pack('d', value))[0]
    #return np.binary_repr(value)
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', value))
# Metrics 
# Deep Learning
from PIL import Image
import imageio
from keras import backend as K
from tensorflow.keras.utils import plot_model
import tensorflow as tf
print('TensoFlow Version: ', tf.__version__)
from tensorflow.keras.preprocessing.image import ImageDataGenerator
K.set_floatx('float64')
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Dense, Flatten, GlobalAveragePooling2D, BatchNormalization, Dropout
from tensorflow.keras.applications.resnet import ResNet50
from jinja2 import Template
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping, ReduceLROnPlateau, CSVLogger
from numpy import asarray
index = 1
count = 0

model_done  = tf.keras.models.load_model("model.h5")
'''outputs = []
for layer in model_done.layers:
    keras_function = K.function([model_done.input], [layer.output])
    outputs.append(keras_function([training_data, 1]))
print(outputs)'''
inp = model_done.input                                           # input placeholder
outputs = [layer.output for layer in model_done.layers]          # all layer outputs
functors = [K.function([inp], [out]) for out in outputs]    # evaluation functions

# Testing
#im = Image.open('Lenna.jpg')
#new_image = im.resize((32, 32))
name_layer = []
for layer in model_done.layers:
    #print (layer.name)
    name_layer.append(layer.name)

picture ="D:\\CNN\\software\\result_layer\\test\\dog\\0022"
#for cca in range (len(cc_picture)):
for qweqwe in range (1):
    temp_input_data = []
    data = imageio.imread('{0}.png'.format(picture))
    data = data[np.newaxis,...]
    inp = data
    print (data.shape)
    temp_input_data =data.transpose((0, 3, 2, 1))
    print(data)
    print(temp_input_data.shape)
    print(temp_input_data)

    ############ Lấy input từ hình
    
        #f.write("32\n32\n1\n")
    for i_pic in range (3):
        with open('{0}_{0}.txt'.format(i_pic), 'w') as f:
            for i  in range (32):
                for j in range (32):
                    
                    binary_string = float_to_bin(temp_input_data[0][i_pic][j][i])
                    f.write(binary_string)
                    f.write("\n")
                    
        f.close
    #print (new_image.size)
    #print (test.shape)
    #pixels = list(im.getdata())
    #test = np.random.random([32,32,3])[np.newaxis,...]
    ############################################################## Lấy kết quả các layer của model
    layer_outs = [func([data]) for func in functors]
    model_done.summary()
    for i in range (len(layer_outs)):
        temp_array =  np.array(layer_outs[i])
        for j in range (len(temp_array)):
                if (temp_array[j].ndim == 4):
                    temp_haha = temp_array[j][:, :, :, :].transpose((0, 3, 2, 1))
                    axis1, axis2, axis3 ,axis4 =temp_haha.shape
                    #print("axit1", axis1)
                    #print("axit2", axis2)
                    #print("axit3", axis3)
                    #print("axit4", axis4)
                    #print(temp_haha.shape)
                    for h in range (axis1):
                        for k in range(axis2):
                            with open('D:\\CNN\\software\\result_layer\\' +name_layer[i] +'_result' +'_{0}.txt'.format(k),'w') as f:
                                #f.write("32\n32\n1\n")
                                for l in range(axis3):
                                    for m in range (axis4):
                                        #binary_string = float_to_bin(temp_haha[h][k][l][m])
                                        binary_string = str(temp_haha[h][k][m][l])
                                        #decimal_representation = int(binary_string, 2)
                                        #hexadecimal_string = hex(decimal_representation)
                                        #f.write(hexadecimal_string[2:])
                                        #if (temp_haha[h][k][l][m] == 0):
                                        #    f.write("	")
                                        #f.write("\t")
                                        f.write(binary_string)
                                        #f.write(str(temp_haha[h][k][l][m]))
                                        f.write("\n")
                                    #f.write("\n")
                            f.close
                else:
                    temp_haha = temp_array[j]
                   
                    print(temp_haha)
                    with open('D:\\CNN\\software\\result_layer\\' +name_layer[i] +'_result' +'_{0}.txt'.format(k),'w') as f:
                        #print(name_layer[i])
                        for tt in range (len((temp_haha[0]))):
                            #binary_string = float_to_bin(temp_haha[0][tt])
                            #decimal_representation = int(binary_string, 2)
                            #hexadecimal_string = hex(decimal_representation)
                            #f.write(hexadecimal_string[2:])
                            f.write(str(temp_haha[0][tt]))
                            f.write("\n")
                    f.close
    '''for i_pic in range (3):
        D_in = []
        with open('D:\\MT7\\New_model\\Weight_Result\\input_2_result_{0}.txt'.format(i_pic),'r') as f:
                D_in = f.readlines()
        D_in = [x.strip() for x in D_in]
        with open('input_for_HDL_{0}.txt'.format(i_pic), 'a') as f:
            for asd in range (len(D_in)):
                f.write(D_in[asd])
                f.write("\n")
        f.close'''

    a = layer_outs[-1][0]
    max_value = np.amax(a[0])
    class_output = np.where(a[0]  == max_value)
    print ("the Max value is :", max_value)
    print ("The class index is : ", class_output[0])
'''for i in range (len(name_layer)):
    print (name_layer[i])
print (len(layer_outs[-1]))
b = (layer_outs[-1][0][1])
print (b)
for i in range (len(b)):
    print (b[i])
for i in range(len(a)):
print (a[0][i])'''
import tensorflow as tf
import cv2
from keras.models import load_model


def prepare(filepath):
  IMG_SIZE = 32
  img_array = cv2.imread(filepath)
  img_array = cv2.cvtColor(img_array ,cv2.COLOR_BGR2RGB)
  new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE))
  return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 3)





predict_prob = model_done.predict(prepare('{0}.png'.format(picture)))[0]




# Predict label



print('predict prob = ', np.max(predict_prob))
print('predict prob0 = ', np.max(predict_prob[0]))
print('predict prob1 = ', np.max(predict_prob[1]))
print('predict prob = ', np.max(predict_prob[0]))
is_dog = np.max(predict_prob[0]) ==1
print(is_dog)
if is_dog:
    print("That's a dog!")
else:
    print("That's not a dog!")