
module fully_conected_2d #(
                            parameter WIDTH = 4,
                            parameter HEIGHT = 4,
                            parameter N = 2
                            )
                            (
                            input clk,
                            input resetn,
                            input valid_in,
                            input start,
                            input [31:0]data_in0,
                            input [31:0]data_in1,
                            input [31:0]data_in2,
                            input [31:0]data_in3,
                            input [31:0]data_in4,
                            input [31:0]data_in5,
                            input [31:0]data_in6,
                            input [31:0]data_in7,
                            input [31:0]data_in8,
                            input [31:0]data_in9,
                            input [31:0]data_in10,
                            input [31:0]data_in11,
                            input [31:0]data_in12,
                            input [31:0]data_in13,
                            input [31:0]data_in14,
                            input [31:0]data_in15,
                            
                            input load_weight,
                            input [31:0]weight0,
                            input [31:0]weight1,
                            output [31:0]class0,
                            output [31:0]class1,
                            output valid_out,
                            output reg load_weight_done
                            
                            );
                            

reg [31:0]counter_load;
reg [31:0]weightR0[0:15];
reg [31:0]weightR1[0:15];
wire [31:0]x [0:15];
    wire [31:0]y [0:15];
    wire [15:0]valid_out_mult;
    wire [15:0]valid_out_mult1;
    wire [31:0] res[0:7];
    wire [31:0] res1[0:7];
      wire [15:0]valid_out_add;
      wire [15:0]valid_out_add1;
   
      
      reg load_data_done;
always @(posedge clk)
      if (load_weight ==1 & load_weight_done == 0)begin
        weightR0[counter_load] <= weight0;
        weightR1[counter_load] <= weight1;
      end
    
   
    always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) begin
        counter_load <= 4'b0;
      end
      else if (load_weight == 1'b1) begin
        counter_load <= counter_load + 1;
      end
      else if (load_weight == 1'b0) begin
        counter_load <= counter_load;
      end
	  end
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			load_weight_done <= 1'b0;
		end
		else if (counter_load == 15) begin
			load_weight_done <= 1'b1;
		end
		else begin
			load_weight_done <= load_weight_done;
		end
	end
	
	reg [31:0]data_inR[0:15];
	always @(posedge clk or negedge resetn)begin
	if(resetn ==0)begin
	   data_inR[0] = data_in0;
	 data_inR[1] = 0;
	 data_inR[2] = 0;
	 data_inR[3] = 0;
	 data_inR[4] = 0;
	 data_inR[5] = 0;
	 data_inR[6] = 0;
	 data_inR[7] = 0;
	 data_inR[8] = 0;
	 data_inR[9] = 0;
	 data_inR[10] = 0;
	 data_inR[11] = 0;
	 data_inR[12] = 0;
	 data_inR[13] = 0;
	 data_inR[14] = 0;
	 data_inR[15] = 0;
	end
	else if(valid_in == 1)begin
	 data_inR[0] = data_in0;
	 data_inR[1] = data_in1;
	 data_inR[2] = data_in2;
	 data_inR[3] = data_in3;
	 data_inR[4] = data_in4;
	 data_inR[5] = data_in5;
	 data_inR[6] = data_in6;
	 data_inR[7] = data_in7;
	 data_inR[8] = data_in8;
	 data_inR[9] = data_in9;
	 data_inR[10] = data_in10;
	 data_inR[11] = data_in11;
	 data_inR[12] = data_in12;
	 data_inR[13] = data_in13;
	 data_inR[14] = data_in14;
	 data_inR[15] = data_in15;
	end
	else begin
	 data_inR[0] = data_inR[0];
	 data_inR[1] = data_inR[1];
	 data_inR[2] = data_inR[2];
	 data_inR[3] = data_inR[3];
	 data_inR[4] = data_inR[4];
	 data_inR[5] = data_inR[5];
	 data_inR[6] = data_inR[6];
	 data_inR[7] = data_inR[7];
	 data_inR[8] = data_inR[8];
	 data_inR[9] = data_inR[9];
	 data_inR[10] = data_inR[10];
	 data_inR[11] = data_inR[11];
	 data_inR[12] = data_inR[12];
	 data_inR[13] = data_inR[13];
	 data_inR[14] = data_inR[14];
	 data_inR[15] = data_inR[15];
	
	end
	end
    genvar i;
    generate  for (i=0; i<= 15; i=i+1)
      begin:gen_mult


      FP_multiplier multi0(clk,
                                resetn,
                                start,
                                weightR0[i],
                                data_inR[i],
                                x[i],
                                valid_out_mult[i]
                                );
    end
    endgenerate
    
    
      
      fpadd add0(clk,
                 resetn,
                 valid_out_mult[0],
                 x[0],
                 x[1],
                 res[0],
                valid_out_add[0]
                  );
                  
           
    fpadd add1(clk,
                 resetn,
                 valid_out_mult[2],
                 x[2],
                 x[3],
                 res[1],
                valid_out_add[1]
                  );
    fpadd add2(clk,
                 resetn,
                 valid_out_mult[4],
                 x[4],
                 x[5],
                 res[2],
                valid_out_add[2]
                  );
     fpadd add3(clk,
                 resetn,
                 valid_out_mult[6],
                 x[6],
                 x[7],
                 res[3],
                valid_out_add[3]
                  );
       fpadd add4(clk,
                 resetn,
                 valid_out_mult[8],
                 x[8],
                 x[9],
                 res[4],
                valid_out_add[4]
                  ); 
       fpadd add5(clk,
                 resetn,
                 valid_out_mult[10],
                 x[10],
                 x[11],
                 res[5],
                valid_out_add[5]
                  );           
           fpadd add6(clk,
                 resetn,
                 valid_out_mult[12],
                 x[12],
                 x[13],
                 res[6],
                valid_out_add[6]
                  );   
           fpadd add7(clk,
                 resetn,
                 valid_out_mult[14],
                 x[14],
                 x[15],
                 res[7],
                valid_out_add[7]
                
                  );     
                  
          
          wire [31:0] rs[0:3];
          
           fpadd addd0(clk,
                 resetn,
                 valid_out_add[0],
                 res[0],
                 res[1],
                 rs[0],
                valid_out_add[8]
                  );   
                  
                       
             fpadd addd1(clk,
                 resetn,
                 valid_out_add[2],
                 res[2],
                 res[3],
                 rs[1],
                valid_out_add[9]
                  );   
                  
          fpadd addd2(clk,
                 resetn,
                 valid_out_add[4],
                 res[4],
                 res[5],
                 rs[2],
                valid_out_add[10]
                  ); 
                  
                  
          fpadd addd3(clk,
                 resetn,
                 valid_out_add[6],
                 res[6],
                 res[7],
                 rs[3],
                valid_out_add[11]
                  );                         
        
        
        
        wire [31:0]x1[0:1];
        
        fpadd adddd0(clk,
                 resetn,
                 valid_out_add[8],
                 rs[0],
                 rs[1],
                 x1[0],
                valid_out_add[12]
                  );            
    fpadd adddd1(clk,
                 resetn,
                 valid_out_add[10],
                 rs[2],
                 rs[3],
                 x1[1],
                valid_out_add[13]
                  );            
    
    
    fpadd adddd01(clk,
                 resetn,
                 valid_out_add[12],
                 x1[0],
                 x1[1],
                 class0,
                valid_out_add[14]
                  );            
    
    
    generate  for (i=0; i<=15; i=i+1)
      begin:gen_mult1

 
      FP_multiplier multi1(clk,
                                resetn,
                                start,
                                weightR1[i],
                                data_inR[i],
                                y[i],
                                valid_out_mult1[i]
                                );
    end
    endgenerate
 
      fpadd add_0(clk,
                 resetn,
                 valid_out_mult1[0],
                 y[0],
                 y[1],
                 res1[0],
                valid_out_add1[0]
                  );
                  
                  
    fpadd add_1(clk,
                 resetn,
                 valid_out_mult1[2],
                 y[2],
                 y[3],
                 res1[1],
                valid_out_add1[1]
                  );
    fpadd add_2(clk,
                 resetn,
                 valid_out_mult1[4],
                 y[4],
                 y[5],
                 res1[2],
                valid_out_add1[2]
                  );
     fpadd add_3(clk,
                 resetn,
                 valid_out_mult1[6],
                 y[6],
                 y[7],
                 res1[3],
                valid_out_add1[3]
                  );
       fpadd add_4(clk,
                 resetn,
                 valid_out_mult1[8],
                 y[8],
                 y[9],
                 res1[4],
                valid_out_add1[4]
                  ); 
       fpadd add_5(clk,
                 resetn,
                 valid_out_mult1[10],
                 y[10],
                 y[11],
                 res1[5],
                valid_out_add1[5]
                  );           
           fpadd add_6(clk,
                 resetn,
                 valid_out_mult1[12],
                 y[12],
                 y[13],
                 res1[6],
                valid_out_add1[6]
                  );   
           fpadd add_7(clk,
                 resetn,
                 valid_out_mult1[14],
                 y[14],
                 y[15],
                 res1[7],
                valid_out_add1[7]
                
                  );     
                  
          
          wire [31:0] rs1[0:3];
          
           fpadd addd_0(clk,
                 resetn,
                 valid_out_add1[0],
                 res1[0],
                 res1[1],
                 rs1[0],
                valid_out_add1[8]
                  );   
                  
                       
             fpadd addd_1(clk,
                 resetn,
                 valid_out_add1[2],
                 res1[2],
                 res1[3],
                 rs1[1],
                valid_out_add1[9]
                  );   
                  
          fpadd addd_2(clk,
                 resetn,
                 valid_out_add1[4],
                 res1[4],
                 res1[5],
                 rs1[2],
                valid_out_add1[10]
                  ); 
                  
                  
          fpadd addd_3(clk,
                 resetn,
                 valid_out_add1[6],
                 res1[6],
                 res1[7],
                 rs1[3],
                valid_out_add1[11]
                  );                         
        
        
        
        wire [31:0]x1_1[0:1];
        
        fpadd adddd_0(clk,
                 resetn,
                 valid_out_add1[8],
                 rs1[0],
                 rs1[1],
                 x1_1[0],
                valid_out_add1[12]
                  );            
    fpadd adddd_1(clk,
                 resetn,
                 valid_out_add1[10],
                 rs1[2],
                 rs1[3],
                 x1_1[1],
                valid_out_add1[13]
                  );            
    
    
    fpadd adddd_01(clk,
                 resetn,
                 valid_out_add1[12],
                 x1_1[0],
                 x1_1[1],
                 class1,
                valid_out_add1[14]
                  );      
                  
                  
           assign valid_out = valid_out_add[14];      
endmodule  