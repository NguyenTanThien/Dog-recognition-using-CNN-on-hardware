module mux2to1 #(
		parameter size = 24
		)
		(d0,d1,s,out);
		input [size-1:0]d0,d1;
		input s;
		output reg [size-1:0]out;
		always @(*)begin
		  case(s)
		    1'b1: out <= d1;
		    1'b0: out <= d0;
		   endcase
		  end
endmodule