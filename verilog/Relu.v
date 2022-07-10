module Relu # (parameter DATA_WIDTH = 32)
		(in,out);
	input [DATA_WIDTH -1 :0] in;
	output [DATA_WIDTH -1 :0] out;

	assign out = (in[DATA_WIDTH -1])?0:in; // in < 0, out = 0, in > 0, out = in
	

endmodule 
