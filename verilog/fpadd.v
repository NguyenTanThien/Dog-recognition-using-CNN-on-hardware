//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2021 04:00:42 PM
// Design Name: 
// Module Name: Addition_Subtraction
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module fpadd(clk, resetn, valid_in, iA, iB, result, valid_out);
    
    /////////
    input clk;
    input resetn;
    input valid_in;
    input [31:0] iA;
    input [31:0] iB;
    output reg [31:0] result;
    output reg valid_out;
    ///////////
    
    wire [31:0] A, B;
    assign A = iA;
assign B = iB;
    ////////
    wire [7:0] ExpA, ExpB;
    wire [22:0] MantisaA, MantisaB;
    wire SignA, SignB;
    ///////
    assign SignA= A[31];
    assign SignB= B[31];
    assign MantisaA = A[22:0];
    assign MantisaB = B[22:0];
    assign ExpA = A[30:23];
    assign ExpB = B[30:23];
    /////////
    reg [8:0] num_shift;
    reg [7:0] Exp_large;//, Exp_small;
    reg [22:0] Man_large, Man_small;
    
    
    ///
    always @(*) begin
        //////////////stage1/////////
        if(ExpA > ExpB) begin
            num_shift =ExpA - ExpB;
            Exp_large = ExpA;
            //Exp_small = ExpB;
            Man_large = MantisaA;
            Man_small = MantisaB;
        end
        else/* if(ExpA < ExpB) */begin
            num_shift =ExpB - ExpA;
            Exp_large = ExpB;
            Man_small = MantisaA;
            Man_large = MantisaB;
        end
   
        if( ExpA ==8'b0 || ExpB ==8'b0)
            num_shift = 9'd0;
        else 
            num_shift = num_shift;
    end
    //// reg stage1;
    reg [22:0] small_Man_pp2,large_Man_pp2 ;
    always @(*) begin
        if (ExpA != 0) begin
            small_Man_pp2 ={1'b1, Man_small[22:1]};
            small_Man_pp2 = (small_Man_pp2 >>num_shift);
        end
        else begin
            small_Man_pp2 =Man_small;
        end
        if (ExpB != 0) begin
            large_Man_pp2 = {1'b1, Man_large[22:1]};
        end
        else begin
            if(ExpA != 0) begin
                large_Man_pp2 = {1'b1, Man_large[22:1]};
            end
            else
                large_Man_pp2=Man_large;
        end
    end
    ////////////reg pp2
    
    reg [22:0] small_Man_pp3, large_Man_pp3;
    always @(*) begin
        if(small_Man_pp2 <large_Man_pp2) begin
               small_Man_pp3 =small_Man_pp2;
               large_Man_pp3 =large_Man_pp2;
        end
        else begin
               small_Man_pp3 =large_Man_pp2;
               large_Man_pp3 =small_Man_pp2;
        end
    end
    reg [23:0] Add_Mantisa;
   reg [4:0] shiftMan;
   reg [7:0] renorm_Exp;
    always @(*) begin
        if(ExpA !=0 && ExpB !=0) begin
            Add_Mantisa = (SignA==SignB)? large_Man_pp3 +small_Man_pp3 : large_Man_pp3 -small_Man_pp3;
        end
        else begin
            Add_Mantisa =large_Man_pp3;
        end
        ///renormalization for mantissa
        if(Add_Mantisa[23] ==1'b1) begin
            shiftMan =5'd1;
            renorm_Exp =8'd1;
        end
        else if(Add_Mantisa[22] ==1'b1) begin
            shiftMan =5'd2;
            renorm_Exp =8'd0;
        end
        else if(Add_Mantisa[21] ==1'b1) begin
            shiftMan =5'd3;
            renorm_Exp =8'hff; //-1
        end
        else if(Add_Mantisa[20] ==1'b1) begin
            shiftMan =5'd4;
            renorm_Exp =8'hfe; //-2
        end
        else if(Add_Mantisa[19] ==1'b1) begin
            shiftMan =5'd5;
            renorm_Exp =8'hfd; //-3
        end
        else if(Add_Mantisa[18] ==1'b1) begin
            shiftMan =5'd6;
            renorm_Exp =8'hfc; //-4
        end
        else if(Add_Mantisa[17] ==1'b1) begin
            shiftMan =5'd7;
            renorm_Exp =8'hfb; //-5
        end
        else if(Add_Mantisa[16] ==1'b1) begin
            shiftMan =5'd8;
            renorm_Exp =8'hfa; //-7
        end
        else if(Add_Mantisa[15] ==1'b1) begin
            shiftMan =5'd9;
            renorm_Exp =8'hf8; //-8
        end
        else if(Add_Mantisa[14] ==1'b1) begin
            shiftMan =5'd10;
            renorm_Exp =8'hf7; //-9
        end
        else if(Add_Mantisa[13] ==1'b1) begin
            shiftMan =5'd11;
            renorm_Exp =8'hf6; //-10
        end
        else if(Add_Mantisa[12] ==1'b1) begin
            shiftMan =5'd12;
            renorm_Exp =8'hf5; //-11
        end
        else if(Add_Mantisa[11] ==1'b1) begin
            shiftMan =5'd13;
            renorm_Exp =8'hf4; //-12
        end
        else if(Add_Mantisa[10] ==1'b1) begin
            shiftMan =5'd14;
            renorm_Exp =8'hf3; //-13
        end
        else if(Add_Mantisa[9] ==1'b1) begin
            shiftMan =5'd15;
            renorm_Exp =8'hf2; //-14
        end
        else if(Add_Mantisa[8] ==1'b1) begin
            shiftMan =5'd16;
            renorm_Exp =8'hf1; //-15
        end
        else if(Add_Mantisa[7] ==1'b1) begin
            shiftMan =5'd17;
            renorm_Exp =8'hf0; //-16
        end
        else if(Add_Mantisa[6] ==1'b1) begin
            shiftMan =5'd18;
            renorm_Exp =8'hef; //-17
        end
        else if(Add_Mantisa[5] ==1'b1) begin
            shiftMan =5'd19;
            renorm_Exp =8'hee; //-18
        end
        
        else begin
            if(SignA!=SignB && ExpA == ExpB)
                renorm_Exp = ~Exp_large +8'd1; //bu 2
            else 
            renorm_Exp =8'b0;
            shiftMan = 0;
        end
    end
    ///
    reg [23:0] Add1_Mantisa;
    reg [22:0] Man_out;
    reg [7:0] Exp_out;
    reg Sign_out;
    always@(*)begin
        if(shiftMan!=0) begin
            Add1_Mantisa = Add_Mantisa <<shiftMan;  
        end
        else begin
            Add1_Mantisa = Add_Mantisa;
        end
        //if (signA_PP4 != signB_PP4 && 
        Exp_out =  Exp_large + renorm_Exp;
        Man_out = Add1_Mantisa[23:1];
        /// set sign
        if(SignA == SignB)
            Sign_out = SignA;
        if(ExpA > ExpB)
            Sign_out = SignA;
        else if (ExpA < ExpB)
            Sign_out = SignB;
         else begin
            if(MantisaA >MantisaB)
                Sign_out = SignA;
             else 
                Sign_out = SignB;
         end
    end
    //
    /*always @(posedge clk or negedge resetn) begin
        if(resetn==1'b0) begin
            result <=32'b0;
            valido <=1'b0;
        end
        else begin
            result <= {Sign_out, Exp_out, Man_out}; 
            valido <= validi;
        end
    end*/
    always @(posedge clk or negedge resetn) begin
        if(resetn==1'b0) begin
            result <=32'b0;
            valid_out <=1'b0;
        end
        else if(valid_in == 1)begin
           // if ({Exp_out,Man_out} ==0) 
             //   result <= {1'b0, Exp_out, Man_out}; 
           // else 
                result <= {Sign_out, Exp_out, Man_out}; 
            valid_out <= valid_in;
        end
	else begin
	result <= result;
	valid_out <= valid_in;
end
    end
endmodule


