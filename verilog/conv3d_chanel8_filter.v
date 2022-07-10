
//`include "fpadd.v";
//`include "conv2d_kernel3.v";
module conv3d_8chanel_filter #(parameter WIDTH= 8,
                              parameter HEIGHT  = 8,
                               parameter CHANEL = 8
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
  //output [31:0]data_out0,
  //output [31:0]data_out1,
  //output [31:0]data_out2,
  output [31:0]data_out_conv,
  output valid_out,

  output reg load_kernel_done

  );
 reg [31:0]bias;
reg [31:0] counter_kernel,counter;
wire load_bias;
wire [31:0]data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;
    always @ (posedge clk or negedge resetn)begin
      if(resetn == 0) counter_kernel <= 0;
      else if (load_kernel == 1'b1) begin
        if(counter_kernel > 3*3*CHANEL + 1) counter_kernel <= counter_kernel;
        else counter_kernel <= counter_kernel + 1;
      end
      else counter_kernel <= counter_kernel;
    end

    wire load_kernel0,load_kernel1,load_kernel2,load_kernel3,load_kernel4,load_kernel5,load_kernel6,load_kernel7;


    assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel <=8) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_kernel >= 9 & counter_kernel <=17) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_kernel >= 18 & counter_kernel <=26) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel3 = ((counter_kernel >= 27 & counter_kernel <=35) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel4 = ((counter_kernel >= 36 & counter_kernel <=44) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel5 = ((counter_kernel >= 45 & counter_kernel <=53) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel6 = ((counter_kernel >= 54 & counter_kernel <=62) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel7 = ((counter_kernel >= 63 & counter_kernel <=71) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_bias = (counter_kernel == 72 & load_kernel == 1'b1)?1'b1:1'b0;

wire valid_out_conv0,valid_out_conv1,valid_out_conv2,valid_out_conv3,valid_out_conv4,valid_out_conv5,valid_out_conv6,valid_out_conv7;
wire load_kernel_done_0,load_kernel_done_1,load_kernel_done_2,load_kernel_done_3;
wire load_kernel_done_4,load_kernel_done_5,load_kernel_done_6,load_kernel_done_7;
always @(posedge clk or negedge resetn) begin
      if(resetn == 0)begin
        load_kernel_done <=0;
        bias <= 0;
      end
      else if(load_bias == 1'b1)begin
        load_kernel_done <=load_bias;
        bias <= kernel;
        end
      else begin
        load_kernel_done <=load_kernel_done;
        bias <= bias;
      end
    end
    conv2d_kernel3 #(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_0(
		clk,
		resetn,
		data_valid_in,
		data_in0,
		load_kernel0,
		kernel,            
		data_out0,
		valid_out_conv0,

		load_kernel_done_0
		);
     conv2d_kernel3#(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_1(
		clk,
		resetn,
		data_valid_in,
		data_in1,

		load_kernel1,
		kernel,            
		data_out1,
		valid_out_conv1,
	
		load_kernel_done_1
		);
    conv2d_kernel3#(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_2(
		clk,
		resetn,
		data_valid_in,
		data_in2,

		load_kernel2,
		kernel,            
		data_out2,
		valid_out_conv2,

		load_kernel_done_2
		);
conv2d_kernel3#(
	.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_3(
		clk,
		resetn,
		data_valid_in,
		data_in3,

		load_kernel3,
		kernel,            
		data_out3,
		valid_out_conv3,

		load_kernel_done_3
		);
		
		 conv2d_kernel3 #(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_4(
		clk,
		resetn,
		data_valid_in,
		data_in4,
		load_kernel4,
		kernel,            
		data_out4,
		valid_out_conv4,
	
		load_kernel_done_4
		);
     conv2d_kernel3#(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_5(
		clk,
		resetn,
		data_valid_in,
		data_in5,

		load_kernel5,
		kernel,            
		data_out5,
		valid_out_conv5,
		
		load_kernel_done_5
		);
    conv2d_kernel3#(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_6(
		clk,
		resetn,
		data_valid_in,
		data_in6,

		load_kernel6,
		kernel,            
		data_out6,
		valid_out_conv6,
	
		load_kernel_done_6
		);
conv2d_kernel3#(
		.DATA_WIDTH(32),.WIDTH(WIDTH),.HEIGHT(HEIGHT)
		)
		conv2_7(
		clk,
		resetn,
		data_valid_in,
		data_in7,

		load_kernel7,
		kernel,            
		data_out7,
		valid_out_conv7,
	
		load_kernel_done_7
		);
    //assign done_img = done_conv_1;
    
    
    wire [31:0]res1,res2,res3,res4,res5;
    wire [31:0]x1,x2,x3;
    wire valid_add1,valid_add2,valid_add3,valid_add4,valid_add5,valid_add6,valid_add7,valid_add8;
    fpadd add_1(
               clk,
               resetn,
               //enable,
               valid_out_conv0,
               data_out0,
               data_out1,
               res1,
               valid_add1
               );
    fpadd add_2(
               clk,
               resetn,
               //enable,
               valid_out_conv2,
               data_out2,
               data_out3,
               res2,
               valid_add2
               );
    fpadd add_3(
               clk,
               resetn,
               //enable,
               valid_out_conv4,
               data_out4,
               data_out5,
               res3,
               valid_add3
               );
    fpadd add_4(
               clk,
               resetn,
               //enable,
               valid_out_conv6,
               data_out6,
               data_out7,
               res4,
               valid_add4
               );
               
    fpadd add_5(
               clk,
               resetn,
               //enable,
               valid_add1,
               res1,
               res2,
               x1,
               valid_add5
               );
    fpadd add_6(
               clk,
               resetn,
               //enable,
               valid_add3,
               res3,
               res4,
               x2,
               valid_add6
               );   
         
     fpadd add_7(
               clk,
               resetn,
               //enable,
               valid_add5,
               x1,
               x2,
               x3,
               valid_add7
               );                      
               fpadd add_8(
               clk,
               resetn,
               //enable,
             valid_add7,
               x3,
               bias,
               data_out_conv,
               valid_add8
  );
    assign valid_out = valid_add8;
  
  endmodule  
  
  
  
  

