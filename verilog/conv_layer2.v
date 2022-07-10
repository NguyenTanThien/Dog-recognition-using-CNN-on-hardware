module convolution_layer2 #(
                            parameter WIDTH =16,
                            parameter HEIGHT = 16,
                            parameter CHANEL = 4,
                            parameter NUM_KERNEL = 8
                                )

                            (
                            input clk,
                            input resetn,
                            input valid_in,
                            input [31:0]data_in0,
                            input [31:0]data_in1,
                            input [31:0]data_in2,
                            input [31:0]data_in3,
                            input load_kernel,
                            input [31:0]kernel,
                           output [31:0]data_out_conv0,
                           output [31:0]data_out_conv1,
                           output [31:0]data_out_conv2,
                           output [31:0]data_out_conv3,
                           output [31:0]data_out_conv4,
                           output [31:0]data_out_conv5,
                           output [31:0]data_out_conv6,
                           output [31:0]data_out_conv7,

                            output valid_out_layer1,
                            output load_kernel_done
                                                   );
     //wire load_kernel_done;                    
  wire valid_out,done_img;   
   wire [31:0]data_out0,data_out1,data_out2,data_out3;
   wire [31:0]data_out4,data_out5,data_out6,data_out7;
  conv_4chanel_8filter #( .WIDTH (16),
                         .HEIGHT (16),
                          .CHANEL (4),
                         .FILTER (8)
                              )
                             conv_layer (
                              clk,
                              resetn,
                              valid_in,
                              data_in0,
                              data_in1,
                              data_in2,
                              data_in3,
                              load_kernel,
                              kernel,
                              data_out0,
                              data_out1,
                              data_out2,
                              data_out3,
                              data_out4,
                              data_out5,
                              data_out6,
                              data_out7,
                               valid_out,
                               done_img,
                              load_kernel_done);
                               
      wire [31:0]data_in_max0,data_in_max1,data_in_max2,data_in_max3;  
      wire [31:0]data_in_max4,data_in_max5,data_in_max6,data_in_max7;                       
  Relu # (.DATA_WIDTH (32))
		inst(data_out0,data_in_max0);
		Relu # (.DATA_WIDTH (32))
		 inst1(data_out1,data_in_max1);
		Relu # (.DATA_WIDTH (32))
		inst2(data_out2,data_in_max2);
		Relu # (.DATA_WIDTH (32))
		inst3 (data_out3,data_in_max3);
		Relu # (.DATA_WIDTH (32))
		inst4(data_out4,data_in_max4);
		Relu # (.DATA_WIDTH (32))
		 inst5(data_out5,data_in_max5);
		Relu # (.DATA_WIDTH (32))
		inst6(data_out6,data_in_max6);
		Relu # (.DATA_WIDTH (32))
		inst7 (data_out7,data_in_max7);
		
		
		wire done0,done1,done2,done3;
		wire done4,done5,done6,done7;
		wire valid_out_conv0,valid_out_conv1,valid_out_conv2,valid_out_conv3;
		wire valid_out_conv4,valid_out_conv5,valid_out_conv6,valid_out_conv7;
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max0,
        data_out_conv0,
        valid_out_conv0,
        done0
);
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max1
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max1,
        data_out_conv1,
        valid_out_conv1,
        done1
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max2
    (
        clk,
    
     done_img,
        resetn,
        valid_out,
    
        data_in_max2,
        data_out_conv2,
        valid_out_conv2,
        done2
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max3
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max3,
        data_out_conv3,
        valid_out_conv3,
        done3
);



max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max4
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max4,
        data_out_conv4,
        valid_out_conv4,
        done4
);
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max5
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max5,
        data_out_conv5,
        valid_out_conv5,
        done5
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max6
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max6,
        data_out_conv6,
        valid_out_conv6,
        done6
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 16),
    .HEIGHT(16)
)   inst_max7
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max7,
        data_out_conv7,
        valid_out_conv7,
        done7
);
  assign valid_out_layer1 = valid_out_conv7;
endmodule
