
module conv3d_4chanel_filter#(parameter WIDTH= 16,
                              parameter HEIGHT  = 16,
                               parameter CHANEL = 4
                                         )
                              (
  input clk,resetn,
  input data_valid_in,
  input [31:0]data_in0,
                              input [31:0]data_in1,
                              input [31:0]data_in2,
                              input [31:0]data_in3,
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
wire [31:0]data_out0,data_out1,data_out2,data_out3;
    always @ (posedge clk or negedge resetn)begin
      if(resetn == 0) counter_kernel <= 0;
      else if (load_kernel == 1'b1) begin
        if(counter_kernel > 3*3*CHANEL + 1) counter_kernel <= counter_kernel;
        else counter_kernel <= counter_kernel + 1;
      end
      else counter_kernel <= counter_kernel;
    end

    wire load_kernel0,load_kernel1,load_kernel2,load_kernel3;


    assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel <=8) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_kernel >= 9 & counter_kernel <=17) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_kernel >= 18 & counter_kernel <=26) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel3 = ((counter_kernel >= 27 & counter_kernel <=35) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_bias = (counter_kernel == 36 & load_kernel == 1'b1)?1'b1:1'b0;

wire valid_out_conv0,valid_out_conv1,valid_out_conv2,valid_out_conv3;
wire load_kernel_done_0,load_kernel_done_1,load_kernel_done_2,load_kernel_done_3;
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

    //assign done_img = done_conv_1;
  
    wire [31:0]res1,res2,res3;
    wire valid_add1,valid_add2,valid_add3,valid_add4;
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
             valid_add1,
               res1,
               res2,
               res3,
               valid_add3
               );

    fpadd add_4(
               clk,
               resetn,
               //enable,
               
               valid_add3,
               res3,
               bias,
               data_out_conv,
               valid_add4
               );

    assign valid_out = valid_add4;
  
  endmodule  
  
  
  
  
