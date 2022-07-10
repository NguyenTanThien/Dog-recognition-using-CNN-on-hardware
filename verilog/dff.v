module dff(
		clk,
		resetn,
		enable,
		in,
		out
);
	input clk;
	input resetn;
	input enable;
	input in;
	output out;
	
	
	
	reg R;
	
	assign out = R;
	
	always @ (posedge clk or negedge resetn) begin
		if (resetn == 1'b0) R <= 1'b0;
		else if (resetn == 1'b1) begin
			if (enable == 1'b1) R <= in;
			else if (enable == 1'b0) R <= R;
		end
	end

endmodule