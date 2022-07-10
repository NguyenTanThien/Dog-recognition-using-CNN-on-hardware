module convolution_layer1 #(
                            parameter WIDTH =32,
                            parameter HEIGHT = 32,
                            parameter CHANEL = 3,
                            parameter NUM_KERNEL = 4
                                )

                            (
                            input clk,
                            input resetn,
                            input valid_in,
                            input [31:0]data_in0,
                            input [31:0]data_in1,
                            input [31:0]data_in2,
                            input load_kernel,
                            input [31:0]kernel,
                           output [31:0]data_out_conv0,
                           output [31:0]data_out_conv1,
                           output [31:0]data_out_conv2,
                           output [31:0]data_out_conv3,

                            output valid_out_layer1,
                            output load_kernel_done
                          
                            
                    
                                                   );
 // wire load_kernel_done;
                         
  wire valid_out,done_img;   
   wire [31:0]data_out0,data_out1,data_out2,data_out3;
  conv_3chanel_4filter #(.WIDTH (32),
                          .HEIGHT ( 32),
                           .CHANEL (3),
                            .FILTER( 4))
                             conv3d_1 (
                              clk,
                              resetn,
                              valid_in,
                              data_in0,
                              data_in1,
                              data_in2,
                              load_kernel,
                              kernel,
                              data_out0,
                              data_out1,
                              data_out2,
                              data_out3,
                              valid_out,
                               done_img,
                              load_kernel_done
                              );
                               
      wire [31:0]data_in_max0,data_in_max1,data_in_max2,data_in_max3;                         
  Relu # (.DATA_WIDTH (32))
		inst(data_out0,data_in_max0);
		Relu # (.DATA_WIDTH (32))
		 inst1(data_out1,data_in_max1);
		Relu # (.DATA_WIDTH (32))
		inst2(data_out2,data_in_max2);
		Relu # (.DATA_WIDTH (32))
		inst3 (data_out3,data_in_max3);
	////////
	
	
	
	
	//////	
		wire done0,done1,done2,done3;
		wire valid_out_conv0,valid_out_conv1,valid_out_conv2,valid_out_conv3;
		max_pooling #(
    .DATA_WIDTH (32),
    .WIDTH ( 32),
    .HEIGHT(32)
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
    .WIDTH ( 32),
    .HEIGHT(32)
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
    .WIDTH ( 32),
    .HEIGHT(32)
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
    .WIDTH ( 32),
    .HEIGHT(32)
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
  assign valid_out_layer1 = valid_out_conv3;
endmodule