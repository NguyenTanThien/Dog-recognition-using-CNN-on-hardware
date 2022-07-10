module controler (clk,resetn,enable,load_kernel_done,load_weight_done,valid_in,valid_out,load_kernel,load_weight,ready_1);
  
  
  input clk,resetn;
  input enable;
  input load_kernel_done,load_weight_done;
  input valid_in;
  input valid_out;
  //input done;
  wire [2:0]out_next,out_current;
  output load_kernel,load_weight,ready_1;
  next_state inst(enable,load_kernel_done,load_weight_done,valid_in,valid_out,out_current,out_next);
  current_state inst1(clk, resetn, out_next,out_current);
  out   inst2(out_current,load_kernel,load_weight,ready_1);
  
  
endmodule


module current_state(clk,resetn,out_next,out_current);
  
  input clk,resetn;
  input [2:0]out_next;
  output reg [2:0]out_current;
  always @(posedge clk or negedge resetn)begin
    if(resetn ==0)
      out_current <=0;
    else
      out_current <= out_next;

  end
endmodule

module next_state(enable,load_kernel_done,load_weight_done,valid_in,valid_out,out_current,out_next);
  parameter IDLE = 0;
  parameter LOADKERNEL =1;
  parameter LOADWEIGHT =2;
  parameter READY = 4;
  parameter RUN =5;
  parameter DONE = 6;
  
  input enable;
  input load_kernel_done,load_weight_done;
  input valid_in;
  input valid_out;
  input [2:0]out_current;
  
  output reg [2:0]out_next;
  
  
  always @(*)begin
    case(out_current)
      IDLE: if(enable == 0) out_next <= IDLE;
          else out_next <= LOADKERNEL;
      LOADKERNEL: if(load_kernel_done == 0) out_next <= LOADKERNEL;
                else out_next <= LOADWEIGHT;
      LOADWEIGHT: if(load_weight_done ==0) out_next <= LOADWEIGHT;
                  else out_next <= READY;
      READY: if(valid_in == 0) out_next<=READY;
            else out_next <= RUN;
              
      RUN: if(valid_out ==0) out_next <= RUN;
          else out_next <= DONE;
      DONE:   out_next <= READY;
    endcase
    
    
    
    
  end
endmodule
    
     
     
     module out(out_next,load_kernel,load_weight,ready_1);
       
       parameter IDLE = 0;
  parameter LOADKERNEL =1;
  parameter LOADWEIGHT =2;
  parameter READY = 4;
  parameter RUN =5;
   parameter DONE = 6;     
       input [2:0]out_next;
       output reg load_kernel;
       output reg load_weight;
       output reg ready_1;
     
       always @(*)begin
         case(out_next)
           IDLE: begin
                  load_kernel <=0;
                  load_weight <=0;
           end
           LOADKERNEL: begin
                          load_kernel <=1;
                          load_weight <=0;
                          ready_1 <=0;
                         
                      end
            LOADWEIGHT: begin
                          load_kernel <=0;
                          load_weight <=1;
                          ready_1 <=0;
                         
                      end
            READY: begin
                          load_kernel <=0;
                          load_weight <=0;
                          ready_1 <=1;
                          
                      end
            RUN: begin
                          load_kernel <=0;
                          load_weight <=0;
                          ready_1 <=0;
                         
                      end
          DONE: begin
                          load_kernel <=0;
                          load_weight <=0;
                          ready_1 <=0;
                          
                      end
                      
        endcase
         
         
         end
         
         
         
         endmodule