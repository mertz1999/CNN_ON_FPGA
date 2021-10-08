# Implement Convolutional neural networks (CNN) in FPGA

This implemetation is my Bachelor degree final Project!
There are some ways and tools to implement a neural network on FPGA, but in this project i design a simple Convolutional neural network on FPGA with VHDL design without Implementation tools. 
so, you can also download my final Report for this Project in ./report folder (in persian)


## Parts of this project:
 - Train a Convolutional neural networks in **Pytorch**
 - Extract all parameters by using **ONNX**
 - Make all parameters **Fixed-Point**
 - Design all part of a CNN model: Convolution, Activation Function, Max-Pooling, Classification part
 - Test all module

## Included Files

-> ./VHDL

 - **FIFO.vhd               :** Design a First-in First-out Component
 - **Relu.vhd                :** Design Relu activation function 
 - **cnn_types.vhd      :** max-pooling states of state-machine
 - **filter_one.vhd       :**  crossing
 - **find_max.vhd        :** find maximum value for max-pooling window
 - **main.vhd               :** all things together
 - **main_class.vhd     :** classification part
 - **main_cnn.vhd       :** convolution
 - **main_feature.vhd :** convolution + crossing + Relu
 - **max_pooling.vhd  :** max-pooling

-> ./Python

 - List item

-> ./Testbech
In this folder we have several testbench file for testing and simulation modules.

-> ./ISE Project
This folder include all files that you can load them in ISE software.

 


## Necessarily Info:

 ##### Fixed-Point Table
 
|  Name| N.Decimal part |N. Integer part| Signed
|--|--|--|--
| Conv coeff |6 | 1 | +
| Conv Bias| 7| 0 | +
| Input | 7|  0| +
| each conv output |7 | 6 |+
| pooling output | 7| 6 |+
| last nodes coeff |6 | 1 |+
| Final output | 6| 15 |+


