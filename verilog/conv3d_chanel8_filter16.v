
module conv3d_8chanel_16filter #(parameter WIDTH = 8,
                              parameter HEIGHT = 8,
                              parameter CHANEL =8,
                              parameter FILTER = 16
                              )
                              (
                              input clk,
                              input resetn,
                              input data_valid_in,
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
                              output [31:0]data_out0,
                              output [31:0]data_out1,
                              output [31:0]data_out2,
                              output [31:0]data_out3,
                              output [31:0]data_out4,
                              output [31:0]data_out5,
                              output [31:0]data_out6,
                              output [31:0]data_out7,
                              output [31:0]data_out8,
                              output [31:0]data_out9,
                              output [31:0]data_out10,
                              output [31:0]data_out11,
                              output [31:0]data_out12,
                              output [31:0]data_out13,
                              output [31:0]data_out14,
                              output [31:0]data_out15,
                              output valid_out,
                              output reg done_img,
                              output load_kernel_done
                              );
                              
                              
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
    wire load_kernel8,load_kernel9,load_kernel10,load_kernel11,load_kernel12,load_kernel13,load_kernel14,load_kernel15;
    wire done_conv8,done_conv9,done_conv10,done_conv11,done_conv12,done_conv13,done_conv14,done_conv15;

    assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel <= 72) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_kernel >= 73 & counter_kernel <= 145) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_kernel >= 146 & counter_kernel <= 218) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel3 = ((counter_kernel >= 219 & counter_kernel <= 291) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel4 = ((counter_kernel >= 292 & counter_kernel <= 364) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel5 = ((counter_kernel >= 365 & counter_kernel <= 437) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel6 = ((counter_kernel >= 438 & counter_kernel <= 510) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel7 = ((counter_kernel >= 511 & counter_kernel <= 583) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel8 = ((counter_kernel >= 584 & counter_kernel <= 656) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel9 = ((counter_kernel >= 657 & counter_kernel <= 729) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel10 = ((counter_kernel >= 730 & counter_kernel <= 802) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel11 = ((counter_kernel >= 803 & counter_kernel <= 875) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel12 = ((counter_kernel >= 876 & counter_kernel <= 948) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel13 = ((counter_kernel >= 949 & counter_kernel <= 1021) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel14 = ((counter_kernel >= 1022 & counter_kernel <= 1094) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel15 = ((counter_kernel >= 1095 & counter_kernel <= 1167) & load_kernel == 1'b1)?1'b1:1'b0;
  wire valid_out0,valid_out1,valid_out2,valid_out3,valid_out4,valid_out5,valid_out6,valid_out7;
  wire valid_out8,valid_out9,valid_out10,valid_out11,valid_out12,valid_out13,valid_out14,valid_out15;
  wire load_kernel_done_0,load_kernel_done_1,load_kernel_done_2,load_kernel_done_3,load_kernel_done_4,load_kernel_done_5,load_kernel_done_6,load_kernel_done_7;
    wire load_kernel_done_8,load_kernel_done_9,load_kernel_done_10,load_kernel_done_11,load_kernel_done_12,load_kernel_done_13,load_kernel_done_14,load_kernel_done_15;

    conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,            
		load_kernel0,
		kernel,            
		data_out0,
		valid_out0,
		
		load_kernel_done_0
		);
conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,          
		load_kernel1,
		kernel,            
		data_out1,
		valid_out1,
		
		load_kernel_done_1
		);
conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,            
		load_kernel2,
		kernel,            
		data_out2,
		valid_out2,
		
		load_kernel_done_2
		);
conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,            
		load_kernel3,
		kernel,            
		data_out3,
		valid_out3,
		
		load_kernel_done_3
		);
		conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,          
		load_kernel4,
		kernel,            
		data_out4,
		valid_out4,
		
		load_kernel_done_4
		);
		conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,           
		load_kernel5,
		kernel,            
		data_out5,
		valid_out5,
		
		load_kernel_done_5
		);
		conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,        
		load_kernel6,
		kernel,            
		data_out6,
		valid_out6,
		
		load_kernel_done_6
		);
		conv3d_8chanel_filter #(
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
		data_in4, 
		data_in5,
		data_in6,
		data_in7,          
		load_kernel7,
		kernel,            
		data_out7,
		valid_out7,
		
		load_kernel_done_7
		);
		
		
		//////////////////////////////////////////
		conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_8(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,          
		load_kernel8,
		kernel,            
		data_out8,
		valid_out8,
		
		load_kernel_done_8
		);
conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_9(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,          
		load_kernel9,
		kernel,            
		data_out9,
		valid_out9,
		
		load_kernel_done_9
		);
conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_10(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,         
		load_kernel10,
		kernel,            
		data_out10,
		valid_out10,
		
		load_kernel_done_10
		);
conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_11(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,            
		load_kernel11,
		kernel,            
		data_out11,
		valid_out11,
		
		load_kernel_done_11
		);
		conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_12(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,             
		load_kernel12,
		kernel,            
		data_out12,
		valid_out12,
		
		load_kernel_done_12
		);
		conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_13(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,             
		load_kernel13,
		kernel,            
		data_out13,
		valid_out13,
		
		load_kernel_done_13
		);
		conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_14(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,             
		load_kernel14,
		kernel,            
		data_out14,
		valid_out14,
		
		load_kernel_done_14
		);
		conv3d_8chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_15(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,
		data_in3,  
		data_in4, 
		data_in5,
		data_in6,
		data_in7,            
		load_kernel15,
		kernel,            
		data_out15,
		valid_out15,
		
		load_kernel_done_15
		);
		
		
    assign valid_out = valid_out15;
    assign load_kernel_done = load_kernel_done_15;

  

    
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
                    
                              
                              
                              
                              
    

