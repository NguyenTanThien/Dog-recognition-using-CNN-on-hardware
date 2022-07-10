
module conv_3chanel_4filter #(parameter WIDTH = 32,
                              parameter HEIGHT = 32,
                              parameter CHANEL =3,
                              parameter FILTER = 4)
                              (
                              input clk,
                              input resetn,
                              input data_valid_in,
                              input [31:0]data_in0,
                              input [31:0]data_in1,
                              input [31:0]data_in2,
                              input load_kernel,
                              input [31:0]kernel,
                              output [31:0]data_out0,
                              output [31:0]data_out1,
                              output [31:0]data_out2,
                              output [31:0]data_out3,
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

    wire load_kernel0,load_kernel1,load_kernel2,load_kernel3;
    wire done_conv0,done_conv1,done_conv2,done_conv3;

    assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel <= 27) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_kernel >= 28 & counter_kernel <= 55) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_kernel >= 56 & counter_kernel <= 83) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel3 = ((counter_kernel >= 84 & counter_kernel <= 111) & load_kernel == 1'b1)?1'b1:1'b0;
  wire valid_out0,valid_out1,valid_out2,valid_out3;
  wire load_kernel_done_0,load_kernel_done_1,load_kernel_done_2,load_kernel_done_3;
    conv3d_3chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_0(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,            
		load_kernel0,
		kernel,            
		data_out0,
		valid_out0,

		load_kernel_done_0
		);
conv3d_3chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_1(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,            
		load_kernel1,
		kernel,            
		data_out1,
		valid_out1,
	
		load_kernel_done_1
		);
conv3d_3chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_2(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,             
		load_kernel2,
		kernel,            
		data_out2,
		valid_out2,
	
		load_kernel_done_2
		);
conv3d_3chanel_filter #(
		.WIDTH(WIDTH),.HEIGHT(HEIGHT),.CHANEL(CHANEL)
		)
		abc_3(
		clk,
		resetn,
		data_valid_in,
		data_in0, 
		data_in1,
		data_in2,             
		load_kernel3,
		kernel,            
		data_out3,
		valid_out3,
		
		load_kernel_done
		);
    assign valid_out = valid_out3;


  

    
  always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) counter <= 0;
      else if (done_img == 1'b1) begin
        counter <= 0;
      end
      else if(valid_out == 1'b1) begin
        if(counter == (WIDTH)*(HEIGHT)  ) counter <= 0;
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
                    
                              
                              
                              
                              
    