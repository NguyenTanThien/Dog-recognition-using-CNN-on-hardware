
module conv_4chanel_8filter #(parameter WIDTH = 16,
                              parameter HEIGHT = 16,
                              parameter CHANEL =4,
                              parameter FILTER = 8
                              )
                              (
                              input clk,
                              input resetn,
                              input data_valid_in,
                              input [31:0]data_in0,
                              input [31:0]data_in1,
                              input [31:0]data_in2,
                              input [31:0]data_in3,
                              input load_kernel,
                              input [31:0]kernel,
                              output [31:0]data_out0,
                              output [31:0]data_out1,
                              output [31:0]data_out2,
                              output [31:0]data_out3,
                              output [31:0]data_out4,
                              output [31:0]data_out5,
                              output [31:0]data_out6,
                              output [31:0]data_out7,
                              output valid_out,
                              output reg done_img,
                              output load_kernel_done);
                              
                              
         reg [31:0] counter_kernel,counter;
    always @ (posedge clk or negedge resetn)begin
      if(resetn == 0) counter_kernel <= 0;
      else if (load_kernel == 1'b1) begin
        if(counter_kernel > 3*3*CHANEL*FILTER + FILTER) counter_kernel <= counter_kernel;
        else counter_kernel <= counter_kernel + 1;
      end
      else counter_kernel <= counter_kernel;
    end

    wire load_kernel0,load_kernel1,load_kernel2,load_kernel3,load_kernel4,load_kernel5,load_kernel6,load_kernel7;
    wire done_conv0,done_conv1,done_conv2,done_conv3,done_conv4,done_conv5,done_conv6,done_conv7;

    assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel <= 36) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_kernel >= 37 & counter_kernel <= 73) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_kernel >= 74 & counter_kernel <= 110) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel3 = ((counter_kernel >= 111 & counter_kernel <= 147) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel4 = ((counter_kernel >= 148 & counter_kernel <= 184) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel5 = ((counter_kernel >= 185 & counter_kernel <= 221) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel6 = ((counter_kernel >= 222 & counter_kernel <= 258) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel7 = ((counter_kernel >= 259 & counter_kernel <= 295) & load_kernel == 1'b1)?1'b1:1'b0;
  wire valid_out0,valid_out1,valid_out2,valid_out3,valid_out4,valid_out5,valid_out6,valid_out7;
  wire load_kernel_done_0,load_kernel_done_1,load_kernel_done_2,load_kernel_done_3,load_kernel_done_4,load_kernel_done_5,load_kernel_done_6,load_kernel_done_7;
    conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_0(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,            
		load_kernel0,
		kernel,            
		data_out0,
		valid_out0,
	
		load_kernel_done_0
		);
 conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_1(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,            
		load_kernel1,
		kernel,            
		data_out1,
		valid_out1,
		
		load_kernel_done_1
		);
conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_2(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,            
		load_kernel2,
		kernel,            
		data_out2,
		valid_out2,
		
		load_kernel_done_2
		);
conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_3(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,             
		load_kernel3,
		kernel,            
		data_out3,
		valid_out3,
		
		load_kernel_done_3
		);
		conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_4(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,             
		load_kernel4,
		kernel,            
		data_out4,
		valid_out4,
		
		load_kernel_done_4
		);
		conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_5(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,             
		load_kernel5,
		kernel,            
		data_out5,
		valid_out5,
		
		load_kernel_done_5
		);
		conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_6(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,             
		load_kernel6,
		kernel,            
		data_out6,
		valid_out6,
	
		load_kernel_done_6
		);
		conv3d_4chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_7(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,             
		load_kernel7,
		kernel,            
		data_out7,
		valid_out7,
	
		load_kernel_done_7
		);
    assign valid_out = valid_out7;
    assign load_kernel_done = load_kernel_done_7;

  

    
  always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) counter <= 0;
      else if (done_img == 1'b1) begin
        counter <= 0;
      end
      else if(valid_out == 1'b1) begin
        if(counter == (WIDTH)*(HEIGHT) ) counter <= 0;
        else counter <= counter + 1;
      end
      else counter <= counter;
    end
    always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) done_img <= 0;
      else if(counter == (WIDTH)*(HEIGHT) -1) done_img <= (valid_out)?1'b1:1'b0;
      else done_img <= 0;
    end


  endmodule                      
                    
                              
                              
                              
                              
    
