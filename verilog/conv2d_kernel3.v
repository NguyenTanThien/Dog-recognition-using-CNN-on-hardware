

module conv2d_kernel3 #(
  parameter DATA_WIDTH = 32,
  parameter WIDTH = 32,
  parameter HEIGHT = 32
  )
  (
    input     wire            clk,
    input     wire            resetn,
    // input     wire            eof,
    input     wire            data_valid_in,
    input     wire   [DATA_WIDTH-1:0]    data_in,
    input     wire            load_kernel,
    input     wire   [31:0]   kernel,
    //input     wire            enable_cvt,
    
    output    wire   [31:0]    data_out,
    output     valid_out_pixel, 
	output reg load_kernel_done
  );
    wire [31:0] w1,w2,w3,w4,w5,w6,w7,w8,w9;
    wire [31:0] D1,D2,D3,D4,D5,D6,D7,D8,D9;
    reg [31:0] kernelR [0:8];

    wire [31:0] x1,x2,x3,x4,x5,x6,x7,x8,x9;

    wire [8:0] valid_out_mult;
    wire [31:0] res1,res2,res3,res4,res5,res6,res7,res8,res_x9;
    reg [31:0] counter;
    wire valid_add1,valid_add2,valid_add3,valid_add4,valid_add5,valid_add6,valid_add7,valid_add8;
   // wire [31:0] x9_bk,x9_temp;
    //wire [31:0] res_flt;
    // control signals : enable_cvt, enable_mult 

    //reg [DATA_WIDTH-1:0] data;
    //reg enable_counter,enable_cvt;
function integer clogb2;
   input [31:0] value;
   integer 	i;
   begin
      clogb2 = 0;
      for(i = 0; 2**i < value; i = i + 1)
	clogb2 = i + 1;
   end
endfunction
  localparam COUNTER_WIDTH = clogb2(WIDTH);
    wire enable_mult;
    //reg [COUNTER_WIDTH*COUNTER_WIDTH-1:0] counter;
    reg [3:0] counter_load;
    
    genvar i;
    // generate
    // for (i = 9; i >= 0; i=i-1) begin
    //   //if(i > 168) nbit_dff#(32) nbit_dff_ins(clk,resetn,load_weight,32'b0,tmp[i]);
    //   if (i == 9) nbit_dff#(32) nbit_dff_ins(clk,resetn,load_kernel,kernel,kernelR[i]);
    //   else nbit_dff#(32) nbit_dff_ins(clk,resetn,load_kernel,kernelR[i+1],kernelR[i]);
    // end
    // endgenerate
    // reg [31:0] mem [0:9];
    always @(posedge clk)
      if (load_kernel==1 & load_kernel_done == 0)
        kernelR[counter_load] <= kernel;
    
    always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) begin
        counter_load <= 4'b0;
      end
      else if (load_kernel == 1'b1) begin
        counter_load <= counter_load + 1;
      end
      else if (load_kernel == 1'b0) begin
        counter_load <= counter_load;
      end
	  end
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			load_kernel_done <= 1'b0;
		end
		else if (counter_load == 8) begin
			load_kernel_done <= 1'b1;
		end
		else begin
			load_kernel_done <= load_kernel_done;
		end
	end
	
  
  

  reg [COUNTER_WIDTH-1:0] counter_w5_col,counter_w5_row;

	always @(posedge clk or negedge resetn) begin
		if (resetn == 1'b0) counter_w5_col <= 0;
		else if(enable_mult == 1'b1)begin
      counter_w5_col <= (counter_w5_col==WIDTH-1)?0:counter_w5_col + 1; 
    end 
    else counter_w5_col <= counter_w5_col;
  end
  always @(posedge clk or negedge resetn) begin
		if (resetn == 1'b0) counter_w5_row <= 0;
		else if(enable_mult == 1'b1)begin
      if(counter_w5_row != WIDTH -1)
        counter_w5_row <= (counter_w5_col==WIDTH-1)?counter_w5_row + 1:counter_w5_row; //8*6
        else counter_w5_row <= (counter_w5_col==WIDTH-1)?0:counter_w5_row;
    end 
    else counter_w5_row <= counter_w5_row;
  end
    
    double_line_buffer #(.DATA_WIDTH(DATA_WIDTH),.IMG_WIDTH(WIDTH)) 
              double_lbs(
                clk,
                resetn,
                //enable,
                data_valid_in/*|push_remain*/,
                data_in,
                w1,
                w2,
                w3,
                w4,
                w5,
                w6,
                w7,
                w8,
                w9,
                enable_mult
              );
    assign D1 = (counter_w5_row == 0 | counter_w5_col == 0                      ) ? 0:  w1;
    assign D2 = (counter_w5_row == 0                                            ) ? 0:  w2;
    assign D3 = (counter_w5_row == 0 | counter_w5_col == WIDTH -1           ) ? 0:  w3;

    assign D4 = (counter_w5_col == 0                                            ) ? 0:  w4;
    assign D5 =                                                                         w5;
    assign D6 = (counter_w5_col == WIDTH -1                                 ) ? 0:  w6;

    assign D7 = (counter_w5_row == WIDTH -1 | counter_w5_col == 0           ) ? 0:  w7;
    assign D8 = (counter_w5_row == WIDTH -1                                 ) ? 0:  w8;
    assign D9 = (counter_w5_row == WIDTH -1 | counter_w5_col == WIDTH -1) ? 0:  w9;
    
   FP_multiplier kernel_1(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[0],
                       D1,
                       x1,
                       valid_out_mult[0]
                       );
                        
   FP_multiplier kernel_2(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[1],
                       D2,
                       x2,
                       valid_out_mult[1]
                       );
   FP_multiplier kernel_3(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[2],
                       D3,
                       x3,
                       valid_out_mult[2]
                       );
   FP_multiplier kernel_4(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[3],
                       D4,
                       x4,
                       valid_out_mult[3]
                       );
   FP_multiplier kernel_5(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[4],
                       D5,
                       x5,
                       valid_out_mult[4]
                       );
   FP_multiplier kernel_6(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[5],
                       D6,
                       x6,
                       valid_out_mult[5]
                       );
   FP_multiplier kernel_7(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[6],
                       D7,
                       x7,
                       valid_out_mult[6]
                       );
   FP_multiplier kernel_8(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[7],
                       D8,
                       x8,
                       valid_out_mult[7]
                       );
   FP_multiplier kernel_9(
                       clk,
                       resetn,
                       //enable,
                       enable_mult,
                       kernelR[8],
                       D9,
                       x9,
                       valid_out_mult[8]
                       );
     fpadd add_1(
               clk,
               resetn,
               //enable,
               valid_out_mult[0],
               x1,
               x2,
               res1,
               valid_add1
               );
   fpadd add_2(
               clk,
               resetn,
               //enable,
               valid_out_mult[2],
               x3,
               x4,
               res2,
               valid_add2
               );
   fpadd add_3(
               clk,
               resetn,
               //enable,
               valid_out_mult[4],
               x5,
               x6,
               res3,
               valid_add3
               );
   fpadd add_4(
               clk,
               resetn,
               //enable,
               valid_out_mult[6],
               x7,
               x8,
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
               res5,
               valid_add5
               );
   fpadd add_6(
               clk,
               resetn,
               //enable,
               valid_add3,
               res3,
               res4,
               res6,
               valid_add6
               );
   fpadd add_7(
               clk,
               resetn,
               //enable,
               valid_add5,
               res5,
               res6,
               res7,
               valid_add7
               );
               wire [31:0]x9_delay;
 delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(3)) delayx9(clk,resetn,1'b1,x9,x9_delay);
   fpadd add_8(
               clk,
               resetn,
               //enable,
               valid_add7,
               res7,
               x9_delay,
               data_out,
               valid_out_pixel
               );


   

	

  endmodule
