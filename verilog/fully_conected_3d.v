module fully_conected_3d #(parameter WIDTH = 4,
                            parameter HEIGHT =4,
                            parameter DEPT = 16,
                            parameter N = 2
                            )
                          (
                            input clk,
                            input resetn,
                            input valid_in,
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
                            output [31:0]data_out0,
                            output [31:0]data_out1,
                            output valid_out,
                            output reg load_weight_done
                            
                            
                          );
                          
reg [31:0]bias0,bias1;
reg [31:0] counter_weight;
wire load_bias;

    always @ (posedge clk or negedge resetn)begin
      if(resetn == 0) counter_weight <= 0;
      else if (load_weight == 1'b1) begin
        if(counter_weight > WIDTH * HEIGHT*DEPT) counter_weight <= counter_weight;
        else counter_weight <= counter_weight + 1;
      end
      else counter_weight <= counter_weight;
    end

    wire load_weight0,load_weight1,load_weight2,load_weight3;
    wire load_weight4,load_weight5,load_weight6,load_weight7;
    wire load_weight8,load_weight9,load_weight10,load_weight11;
    wire load_weight12,load_weight13,load_weight14,load_weight15;
    
    
    
    assign load_weight0 = ((counter_weight >= 0 & counter_weight <=15) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight1 = ((counter_weight >= 16 & counter_weight <=31) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight2 = ((counter_weight >= 32 & counter_weight <= 47) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight3 = ((counter_weight >= 48 & counter_weight <=63) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight4 = ((counter_weight >= 64 & counter_weight <=79) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight5 = ((counter_weight >= 80 & counter_weight <=95) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight6 = ((counter_weight >= 96 & counter_weight <=111) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight7 = ((counter_weight >= 112 & counter_weight <=127) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight8 = ((counter_weight >= 128 & counter_weight <=143) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight9 = ((counter_weight >= 144 & counter_weight <=159) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight10 = ((counter_weight >= 160 & counter_weight <=175) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight11 = ((counter_weight >= 176 & counter_weight <=191) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight12 = ((counter_weight >= 192 & counter_weight <=207) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight13 = ((counter_weight >= 208 & counter_weight <=223) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight14 = ((counter_weight >= 224 & counter_weight <=239) & load_weight == 1'b1)?1'b1:1'b0;
assign load_weight15 = ((counter_weight >= 240 & counter_weight <=255) & load_weight == 1'b1)?1'b1:1'b0;
assign load_bias = (counter_weight == 256 & load_weight == 1'b1)?1'b1:1'b0;     
always @(posedge clk or negedge resetn) begin
      if(resetn == 0)begin
        load_weight_done <=0;
        bias0 <= 0;
        bias1 <=0;
      end
      else if(load_bias == 1'b1)begin
        load_weight_done <=load_bias;
        bias0 <= weight0;
        bias1 <= weight1;
        end
      else begin
        load_weight_done <=load_weight_done;
        bias0 <= bias0;
        bias1 <= bias1;
      end
    end  
    wire [31:0]class0,class1; 
    wire [31:0]class0_1,class1_1;
    wire [31:0]class0_2,class1_2;
    wire [31:0]class0_3,class1_3;
    wire [31:0]class0_4,class1_4;
    wire [31:0]class0_5,class1_5;
    wire [31:0]class0_6,class1_6;   
    wire [31:0]class0_7,class1_7;
    wire [31:0]class0_8,class1_8;
    wire [31:0]class0_9,class1_9;   
    wire [31:0]class0_10,class1_10;
    wire [31:0]class0_11,class1_11;
    wire [31:0]class0_12,class1_12;   
    wire [31:0]class0_13,class1_13;
    wire [31:0]class0_14,class1_14;
    wire [31:0]class0_15,class1_15;   
    wire valid_out_0,valid_out_1,valid_out_2,valid_out3;
    wire valid_out_4,valid_out_5,valid_out_6,valid_out7;  
    wire valid_out_8,valid_out_9,valid_out_10,valid_out11;  
    wire valid_out_12,valid_out_13,valid_out_14,valid_out_15;  
    
    
   
     
      
  
      
    reg [5:0]counter_tmp ;
    always @(posedge clk or negedge resetn)begin
      if(resetn == 0) counter_tmp <=0;
      else if(valid_in ==1)begin
        if(counter_tmp < 17)
        counter_tmp <= counter_tmp + 1;
        else counter_tmp <= counter_tmp;
      end
    else counter_tmp <= counter_tmp;
      
    end
    
    reg start;
    reg [15:0]valid;
    always @(counter_tmp,valid_in)begin
    if(valid_in == 1)begin
         
      case(counter_tmp)
        6'd0: valid[15:0] =  16'b0000000000000001; 
        6'd1: valid[15:0] =  16'b0000000000000010;
        6'd2: valid[15:0] =  16'b0000000000000100;
        6'd3: valid[15:0] =  16'b0000000000001000;
        6'd4: valid[15:0] =  16'b0000000000010000;
        6'd5: valid[15:0] =  16'b0000000000100000;
        6'd6: valid[15:0] =  16'b0000000001000000;
        6'd7: valid[15:0] =  16'b0000000010000000;
        6'd8: valid[15:0] =  16'b0000000100000000;
        6'd9: valid[15:0] =  16'b0000001000000000;
        6'd10: valid[15:0] = 16'b0000010000000000;
        6'd11: valid[15:0] = 16'b0000100000000000;
        6'd12: valid[15:0] = 16'b0001000000000000;
        6'd13: valid[15:0] = 16'b0010000000000000;
        6'd14: valid[15:0] = 16'b0100000000000000;
        6'd15: valid[15:0] = 16'b1000000000000000;
        6'd16: valid[15:0] =  16'b0000000000000000;
      default: valid[15:0] =  16'b0000000000000000;
    endcase
     end
     else begin
     valid[15:0] = 16'd0;
     if(counter_tmp == 16) start = 1;
     else start = 0;
     end 
    end
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst (
                            clk,
                            resetn,
                            valid[0],
                            start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight0,
                           weight0,
                           weight1,
                           class0,
                           class1,
                            valid_out_0,
                            load_weight_done_0
                            
                            ); 
                            
                            
                            
                            
            
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst1 (
                            clk,
                            resetn,
                            valid[1],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight1,
                           weight0,
                           weight1,
                           class0_1,
                           class1_1,
                            valid_out_1,
                            load_weight_done_1
                            );                       
  
          
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst2 (
                            clk,
                            resetn,
                            valid[2],
                            start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight2,
                           weight0,
                           weight1,
                           class0_2,
                           class1_2,
                            valid_out_2,
                            load_weight_done_2
                            );                       
  
           
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst3 (
                            clk,
                            resetn,
                           valid[3],
                           start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight3,
                           weight0,
                           weight1,
                           class0_3,
                           class1_3,
                            valid_out_3,
                            load_weight_done_3
                            );                       
  
           
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst4 (
                            clk,
                            resetn,
                            valid[4],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight4,
                           weight0,
                           weight1,
                           class0_4,
                           class1_4,
                            valid_out_4,
                            load_weight_done_4
                            );                       
  
          
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst5 (
                            clk,
                            resetn,
                            valid[5],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight5,
                           weight0,
                           weight1,
                           class0_5,
                           class1_5,
                            valid_out_5,
                            load_weight_done_5
                            );                       
  
          
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst6 (
                            clk,
                            resetn,
                           valid[6],
                           start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight6,
                           weight0,
                           weight1,
                           class0_6,
                           class1_6,
                            valid_out_6,
                            load_weight_done_6
                            );                            
         fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst7 (
                            clk,
                            resetn,
                             valid[7],
                             start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight7,
                           weight0,
                           weight1,
                           class0_7,
                           class1_7,
                            valid_out_7,
                            load_weight_done_7
                            );                
  
          
   fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst8 (
                            clk,
                            resetn,
                            valid[8],
                            start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight8,
                           weight0,
                           weight1,
                           class0_8,
                           class1_8,
                            valid_out_8,
                            load_weight_done_8
                            ); 
                            
  fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst9 (
                            clk,
                            resetn,
                            valid[9],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight9,
                           weight0,
                           weight1,
                           class0_9,
                           class1_9,
                            valid_out_9,
                            load_weight_done_9
                            );          
    fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst10 (
                            clk,
                            resetn,
                            valid[10],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight10,
                           weight0,
                           weight1,
                           class0_10,
                           class1_10,
                            valid_out_10,
                            load_weight_done_10
                            );   
                            
                            
                            
  fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst11 (
                            clk,
                            resetn,
                            valid[11],
                            start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight11,
                           weight0,
                           weight1,
                           class0_11,
                           class1_11,
                            valid_out_11,
                            load_weight_done_11
                            );                 
                            
  fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst12 (
                            clk,
                            resetn,
                            valid[12],
                            start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight12,
                           weight0,
                           weight1,
                           class0_12,
                           class1_12,
                            valid_out_12,
                            load_weight_done_12
                            );                 
    fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst13 (
                            clk,
                            resetn,
                            valid[13],
                            start,
                           data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight13,
                           weight0,
                           weight1,
                           class0_13,
                           class1_13,
                            valid_out_13,
                            load_weight_done_13
                            );                 
                            
    fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst14 (
                            clk,
                            resetn,
                            valid[14],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight14,
                           weight0,
                           weight1,
                           class0_14,
                           class1_14,
                            valid_out_14,
                            load_weight_done_14
                            );          
      fully_conected_2d #(
                          .WIDTH (WIDTH),
                          .HEIGHT(HEIGHT),
                         .N(N)
                            )
                           inst15 (
                            clk,
                            resetn,
                            valid[15],
                            start,
                          data_in0,
                            data_in1,
                             data_in2,
                               data_in3,
                             data_in4,
                            data_in5,
                            data_in6,
                            data_in7,
                             data_in8,
                            data_in9,
                            data_in10,
                             data_in11,
                            data_in12,
                            data_in13,
                             data_in14,
                             data_in15,
                            load_weight15,
                           weight0,
                           weight1,
                           class0_15,
                           class1_15,
                            valid_out_15,
                            load_weight_done_15
                            );                  
  
  wire [31:0]res[0:7];
  wire [7:0] valid_out_add;
  fpadd add0(clk,
                 resetn,
                 valid_out_0,
                 class0,
                 class0_1,
                 res[0],
                valid_out_add[0]
                  );
fpadd add1(clk,
                 resetn,
                 valid_out_2,
                 class0_2,
                 class0_3,
                 res[1],
                valid_out_add[1]
                  );
 fpadd add2(clk,
                 resetn,
                 valid_out_4,
                 class0_4,
                 class0_5,
                 res[2],
                valid_out_add[2]
                  );
  fpadd add3(clk,
                 resetn,
                 valid_out_6,
                 class0_6,
                 class0_7,
                 res[3],
                valid_out_add[3]
                  );
  fpadd add4(clk,
                 resetn,
                valid_out_8,
                 class0_8,
                 class0_9,
                 res[4],
                valid_out_add[4]
                  );
   fpadd add5(clk,
                 resetn,
                 valid_out_10,
                 class0_10,
                 class0_11,
                 res[5],
                valid_out_add[5]
                  );            
  fpadd add6(clk,
                 resetn,
                 valid_out_12,
                 class0_12,
                 class0_13,
                 res[6],
                valid_out_add[6]
                  );   
                  
  fpadd add7(clk,
                 resetn,
                 valid_out_14,
                 class0_14,
                 class0_15,
                 res[7],
                valid_out_add[7]
                  );
                  
           wire [31:0]rs[0:3];  
           wire [3:0]valid_out_add0_0;     
   fpadd add8(clk,
                 resetn,
                 valid_out_add[0],
                 res[0],
                 res[1],
                 rs[0],
                valid_out_add0_0[0]
                  );               
   fpadd add9(clk,
                 resetn,
                 valid_out_add[2],
                 res[2],
                 res[3],
                 rs[1],
                valid_out_add0_0[1]
                  );                      
    fpadd add10(clk,
                 resetn,
                 valid_out_add[4],
                 res[4],
                 res[5],
                 rs[2],
                valid_out_add0_0[2]
                  );            
     fpadd add11(clk,
                 resetn,
                 valid_out_add[6],
                 res[6],
                 res[7],
                 rs[3],
                valid_out_add0_0[3]
                  );                    
         wire [31:0]x[0:2] ;
         wire [3:0]valid_out_add0_1;
  fpadd add12(clk,
                 resetn,
                 valid_out_add0_0[0],
                 rs[0],
                 rs[1],
                 x[0],
                valid_out_add0_1[0]
                  );                
    fpadd add13(clk,
                 resetn,
                 valid_out_add0_0[2],
                 rs[2],
                 rs[3],
                 x[1],
                valid_out_add0_1[1]
                  );                        
     fpadd add14(clk,
                 resetn,
                 valid_out_add0_1[0],
                 x[0],
                 x[1],
                 x[2],
                valid_out_add0_1[2]
                  );    
     fpadd add15(clk,
                 resetn,
                 valid_out_add0_1[2],
                 x[2],
                 bias0,
                 data_out0,
                valid_out_add0_1[3]
                  ); 
                
                  
  ////////////
  
  wire [31:0]res1[0:7];
  wire [31:0] valid_out_add1;
  fpadd add_0(clk,
                 resetn,
                 valid_out_0,
                 class1,
                 class1_1,
                 res1[0],
                valid_out_add1[0]
                  );
fpadd add_1(clk,
                 resetn,
                 valid_out_2,
                 class1_2,
                 class1_3,
                 res1[1],
                valid_out_add1[1]
                  );
 fpadd add_2(clk,
                 resetn,
                 valid_out_4,
                 class1_4,
                 class1_5,
                 res1[2],
                valid_out_add1[2]
                  );
  fpadd add_3(clk,
                 resetn,
                 valid_out_6,
                 class1_6,
                 class1_7,
                 res1[3],
                valid_out_add1[3]
                  );
  fpadd add_4(clk,
                 resetn,
                 valid_out_8,
                 class1_8,
                 class1_9,
                 res1[4],
                valid_out_add1[4]
                  );
   fpadd add_5(clk,
                 resetn,
                 valid_out_10,
                 class1_10,
                 class1_11,
                 res1[5],
                valid_out_add1[5]
                  );            
  fpadd add_6(clk,
                 resetn,
                 valid_out_12,
                 class1_12,
                 class1_13,
                 res1[6],
                valid_out_add1[6]
                  );   
                  
  fpadd add_7(clk,
                 resetn,
                 valid_out_14,
                 class1_14,
                 class1_15,
                 res1[7],
                valid_out_add1[7]
                  );
                  
           wire [31:0]rs1[0:3];   
           wire [3:0]valid_out_add1_0;      
   fpadd add_8(clk,
                 resetn,
                 valid_out_add1[0],
                 res1[0],
                 res1[1],
                 rs1[0],
                valid_out_add1_0[0]
                  );               
   fpadd add_9(clk,
                 resetn,
                 valid_out_add1[2],
                 res1[2],
                 res1[3],
                 rs1[1],
                valid_out_add1_0[1]
                  );                      
    fpadd add_10(clk,
                 resetn,
                 valid_out_add1[4],
                 res1[4],
                 res1[5],
                 rs1[2],
                valid_out_add1_0[2]
                  );            
     fpadd add_11(clk,
                 resetn,
                 valid_out_add1[6],
                 res1[6],
                 res1[7],
                 rs1[3],
                valid_out_add1_0[3]
                  );                    
         wire [31:0]x1[0:2] ;
         wire [3:0]valid_out_add1_1; 
  fpadd add_12(clk,
                 resetn,
                valid_out_add1_0[0],
                 rs1[0],
                 rs1[1],
                 x1[0],
                valid_out_add1_1[0]
                  );                
    fpadd add_13(clk,
                 resetn,
                 valid_out_add1_0[2],
                 rs1[2],
                 rs1[3],
                 x1[1],
                valid_out_add1_1[1]
                  );                        
     fpadd add_14(clk,
                 resetn,
                 valid_out_add1_1[0],
                 x1[0],
                 x1[1],
                 x1[2],
                valid_out_add1_1[2]
                  );    
     fpadd add_15(clk,
                 resetn,
                  valid_out_add1_1[2],
                 x1[2],
                 bias1,
                 data_out1,
                 valid_out_add1_1[3]
                  ); 
  
  
    assign valid_out =  valid_out_add1_1[3];                        
  endmodule
