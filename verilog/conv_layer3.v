module convolution_layer3 #(
                            parameter WIDTH =8,
                            parameter HEIGHT = 8,
                            parameter CHANEL = 8,
                            parameter NUM_KERNEL = 16
                                )

                            (
                            input clk,
                            input resetn,
                            input valid_in,
                            input [31:0]data_in0,
                            input [31:0]data_in1,
                            input [31:0]data_in2,
                            input [31:0]data_in3,
                            input [31:0]data_in4,
                            input [31:0]data_in5,
                            input [31:0]data_in6,
                            input [31:0]data_in7,
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
                           output [31:0]data_out_conv8,
                           output [31:0]data_out_conv9,
                           output [31:0]data_out_conv10,
                           output [31:0]data_out_conv11,
                           output [31:0]data_out_conv12,
                           output [31:0]data_out_conv13,
                           output [31:0]data_out_conv14,
                           output [31:0]data_out_conv15,

                            output valid_out_layer1,
                            output load_kernel_done
                            
                                                   );
                         
  wire valid_out,done_img;   
   wire [31:0]data_out0,data_out1,data_out2,data_out3;
   wire [31:0]data_out4,data_out5,data_out6,data_out7;
   wire [31:0]data_out8,data_out9,data_out10,data_out11;
   wire [31:0]data_out12,data_out13,data_out14,data_out15;
  conv3d_8chanel_16filter #(.WIDTH  (8),
                             .HEIGHT  (8),
                              .CHANEL (8),
                              .FILTER ( 16)
                              )
                              conv_layer(
                              clk,
                              resetn,
                              valid_in,
                              data_in0,
                              data_in1,
                              data_in2,
                              data_in3,
                              data_in4,
                              data_in5,
                              data_in6,
                              data_in7,
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
                              data_out8,
                              data_out9,
                              data_out10,
                              data_out11,
                              data_out12,
                              data_out13,
                              data_out14,
                              data_out15,
                              valid_out,
                              done_img,
                              load_kernel_done
                              );
                               
      wire [31:0]data_in_max0,data_in_max1,data_in_max2,data_in_max3;  
      wire [31:0]data_in_max4,data_in_max5,data_in_max6,data_in_max7; 
      wire [31:0]data_in_max8,data_in_max9,data_in_max10,data_in_max11;  
      wire [31:0]data_in_max12,data_in_max13,data_in_max14,data_in_max15;                       
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
		
		Relu # (.DATA_WIDTH (32))
		inst8(data_out8,data_in_max8);
		Relu # (.DATA_WIDTH (32))
		 inst9(data_out9,data_in_max9);
		Relu # (.DATA_WIDTH (32))
		inst10(data_out10,data_in_max10);
		Relu # (.DATA_WIDTH (32))
		inst11 (data_out11,data_in_max11);
		Relu # (.DATA_WIDTH (32))
		inst12(data_out12,data_in_max12);
		Relu # (.DATA_WIDTH (32))
		 inst13(data_out13,data_in_max13);
		Relu # (.DATA_WIDTH (32))
		inst14(data_out14,data_in_max14);
		Relu # (.DATA_WIDTH (32))
		inst15 (data_out15,data_in_max15);
		wire done0,done1,done2,done3;
		wire done4,done5,done6,done7;
		wire done8,done9,done10,done11;
		wire done12,done13,done14,done15;
		wire valid_out_conv0,valid_out_conv1,valid_out_conv2,valid_out_conv3;
		wire valid_out_conv4,valid_out_conv5,valid_out_conv6,valid_out_conv7;
		wire valid_out_conv8,valid_out_conv9,valid_out_conv10,valid_out_conv11;
		wire valid_out_conv12,valid_out_conv13,valid_out_conv14,valid_out_conv15;
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
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
    .WIDTH ( 8),
    .HEIGHT(8)
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
    .WIDTH (8),
    .HEIGHT(8)
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
    .WIDTH ( 8),
    .HEIGHT(8)
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
    .WIDTH ( 8),
    .HEIGHT(8)
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
    .WIDTH ( 8),
    .HEIGHT(8)
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
    .WIDTH (8),
    .HEIGHT(8)
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
    .WIDTH (8),
    .HEIGHT(8)
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
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
)   inst_max8
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max8,
        data_out_conv8,
        valid_out_conv8,
        done8
);
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH (8),
    .HEIGHT(8)
)   inst_max9
    (
        clk,
    
     done_img,
        resetn,
        valid_out,
    
        data_in_max9,
        data_out_conv9,
        valid_out_conv9,
        done9
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
)   inst_max10
    (
        clk,
    
     done_img,
        resetn,
        valid_out,
    
        data_in_max10,
        data_out_conv10,
        valid_out_conv1,
        done10
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
)   inst_max11
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max11,
        data_out_conv11,
        valid_out_conv11,
        done11
);



max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
)   inst_max12
    (
        clk,
    
     done_img,
        resetn,
        valid_out,
    
        data_in_max12,
        data_out_conv12,
        valid_out_conv12,
        done12
);
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH (8),
    .HEIGHT(8)
)   inst_max13
    (
        clk,
    
     done_img,
        resetn,
        valid_out,
    
        data_in_max13,
        data_out_conv13,
        valid_out_conv13,
        done13
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
)   inst_max14
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max14,
        data_out_conv14,
        valid_out_conv14,
        done14
);
max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 8),
    .HEIGHT(8)
)   inst_max15
    (
        clk,
     done_img,
    
        resetn,
        valid_out,
    
        data_in_max15,
        data_out_conv15,
        valid_out_conv15,
        done15
);
  assign valid_out_layer1 = valid_out_conv15;
endmodule

