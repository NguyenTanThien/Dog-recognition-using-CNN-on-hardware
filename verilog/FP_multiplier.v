module FP_multiplier (clk,resetn,valid_in,a,b,out,valid_out);
	input clk,resetn,valid_in;
	input [31:0]a,b;
	output	reg [31:0]out;
	output reg valid_out;

	wire [31:0]FP1,FP2;
	assign FP1 = a;
	assign FP2 = b;
	wire sign;
	wire [7:0]ex1;
	wire [7:0]ex2;
	wire[7:0]o_ex;
	wire [23:0]man1, man2;
	wire [47:0]product;
	wire [22:0]mantisa;
	assign man1 = {1'b1,FP1[22:0]};
	 assign man2 = {1'b1,FP2[22:0]};
	
	assign ex1 = FP1[30:23];
	assign ex2 = FP2[30:23];

	
	assign mantisa = (product[47] == 1)? product[46:24] : product[45:23];
	assign sign = FP1[31] ^ FP2[31];
	assign o_ex = (product[47] == 1)? (ex1+ex2-126) :(ex1+ex2-127) ;
	assign product[47:0] = man1 * man2;

	always @(posedge clk or negedge resetn)begin
	if(resetn ==0 )begin
		out[31:0] = 0;
		valid_out =0;
		end
 
	else if(valid_in == 1)begin
	if(FP1 ==0 | FP2 ==0)begin
	       out[31:0] = 0;
	       valid_out = valid_in;
	end
	else begin
		out[31] = sign;
		out[30:23] = o_ex;
		out[22:0] = mantisa;

		valid_out= valid_in;
end
		end	
		else begin 
		valid_out = valid_in;

			out[31:0] = out[31:0];
			end




end

endmodule
