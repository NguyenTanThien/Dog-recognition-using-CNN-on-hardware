module top (
              input clk,
              input resetn,
              input enable,
              input valid_in,
              
              input [31:0]data_in0,
              input [31:0]data_in1,
              input [31:0]data_in2,
              output  [31:0]predict0,
              output [31:0]predict1,
              output [1:0]is,
              output load_weight_done,
              output load_kernel,
              output load_kernel_done,
              output load_weight,
              output reg [63:0]counter_load,
              output valid_out,
              output ready_1,
           
              output valid_out_layer1,
              output valid_out_layer2,
              output valid_out_layer3,
              output valid_out_fully,
              
              output [31:0]class0,
              output [31:0]class1
              
             
              

);
//wire load_kernel;
//wire load_weight;
wire  valid_out_conv;
reg [63:0]counter_load_w;
always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) begin
        counter_load <= 0;
      end
      else if (load_kernel == 1'b1) begin
        counter_load <= (counter_load == 1576 )?counter_load:counter_load + 1;
      end
      else if (load_kernel == 1'b0) begin
        counter_load <= counter_load;
      end
	end
	wire  load_kernel0,load_kernel1,load_kernel2;
	wire [31:0]kernel;
	ROM rom (counter_load,kernel);

	assign load_kernel0 = ((counter_load >= 0 & counter_load < 112) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_load >= 112 & counter_load < 408) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_load >= 408 & counter_load < 1576) & load_kernel == 1'b1)?1'b1:1'b0;



always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) begin
        counter_load_w <= 0;
      end
      else if (load_weight == 1'b1) begin
        counter_load_w <= (counter_load_w == 257 )?counter_load_w:counter_load_w + 1;
      end
      else if (load_weight == 1'b0) begin
        counter_load_w <= counter_load_w;
      end
	end
	wire [31:0]weight0,weight1;
	ROM_w rom_w(counter_load_w,weight0,weight1);


	wire load_weight0;
	assign load_weight0 = ((counter_load_w >= 0 & counter_load_w < 257) & load_weight == 1'b1)?1'b1:1'b0;
	
	
	wire [31:0]data_out_conv0,data_out_conv1,data_out_conv2,data_out_conv3;
	//wire valid_out_layer1;
	wire load_kernel_done0,load_kernel_done1,load_kernel_done2;
	assign load_kernel_done = load_kernel_done0 && load_kernel_done1 && load_kernel_done2;
	
	//wire ready_1;
	controler control(clk,resetn,enable,load_kernel_done,load_weight_done,valid_in,valid_out,load_kernel,load_weight,ready_1);

convolution_layer1 #(
                            .WIDTH(32),
                            .HEIGHT (32),
                            .CHANEL (3),
                            .NUM_KERNEL( 4)
                                )

                            inst(
                            clk,
                            resetn,
                            valid_in,
                            data_in0,
                            data_in1,
                            data_in2,
                            load_kernel0,
                           kernel,
                           data_out_conv0,
                           data_out_conv1,
                           data_out_conv2,
                           data_out_conv3,

                           valid_out_layer1,
                           load_kernel_done0
                           
                           );

  //wire valid_out_layer2;
  wire [31:0]data_out_conv2_0,data_out_conv2_1,data_out_conv2_2,data_out_conv2_3;
  wire [31:0] data_out_conv2_4,data_out_conv2_5,data_out_conv2_6,data_out_conv2_7;
 convolution_layer2 #(
                            .WIDTH(16),
                            .HEIGHT (16),
                            .CHANEL (4),
                            .NUM_KERNEL(8)
                                )

                            inst1(
                            clk,
                             resetn,
                            valid_out_layer1,
                            data_out_conv0,
                           data_out_conv1,
                           data_out_conv2,
                           data_out_conv3,
                            load_kernel1,
                            kernel,
                           data_out_conv2_0,
                           data_out_conv2_1,
                          data_out_conv2_2,
                          data_out_conv2_3,
                          data_out_conv2_4,
                          data_out_conv2_5,
                           data_out_conv2_6,
                           data_out_conv2_7,

                          valid_out_layer2,
                           load_kernel_done1
                           
                                                   );
                                                   
    //wire valid_out_layer3;
     wire [31:0]data_out_conv3_0;
       wire [31:0] data_out_conv3_1;
       wire [31:0] data_out_conv3_2;
         wire [31:0]  data_out_conv3_3;
       wire [31:0]  data_out_conv3_4;
       wire [31:0]  data_out_conv3_5;
         wire [31:0]  data_out_conv3_6;
         wire [31:0]   data_out_conv3_7;
         wire [31:0]  data_out_conv3_8;
          wire [31:0] data_out_conv3_9;
         wire [31:0] data_out_conv3_10;
         wire [31:0]data_out_conv3_11;
        wire [31:0]  data_out_conv3_12;
         wire [31:0] data_out_conv3_13;
         wire [31:0] data_out_conv3_14;
         wire [31:0]data_out_conv3_15;                                      
    convolution_layer3 #(
                            .WIDTH(8),
                            .HEIGHT (8),
                            .CHANEL (8),
                            .NUM_KERNEL(16)
                                )

                           inst3 (
                            clk,
                            resetn,
                            valid_out_layer2,
                            data_out_conv2_0,
                           data_out_conv2_1,
                          data_out_conv2_2,
                          data_out_conv2_3,
                          data_out_conv2_4,
                          data_out_conv2_5,
                           data_out_conv2_6,
                           data_out_conv2_7,
                           load_kernel2,
                          kernel,
                           data_out_conv3_0,
                           data_out_conv3_1,
                           data_out_conv3_2,
                           data_out_conv3_3,
                          data_out_conv3_4,
                           data_out_conv3_5,
                           data_out_conv3_6,
                           data_out_conv3_7,
                          data_out_conv3_8,
                           data_out_conv3_9,
                           data_out_conv3_10,
                           data_out_conv3_11,
                           data_out_conv3_12,
                           data_out_conv3_13,
                           data_out_conv3_14,
                           data_out_conv3_15,

                             valid_out_layer3,
                         load_kernel_done2
                                                   );                                             
                                                   
            assign check_out_conv3 = data_out_conv3_0;                            
      // wire valid_out_fully;   
      // wire [31:0]class0,class1;                                       
      fully_conected_3d #(.WIDTH  (4),
                           .HEIGHT (4),
                            .DEPT  (16),
                           .N  (2)
                            )
                          inst4(
                            clk,
                             resetn,
                            valid_out_layer3,
                             data_out_conv3_0,
                           data_out_conv3_1,
                           data_out_conv3_2,
                           data_out_conv3_3,
                          data_out_conv3_4,
                           data_out_conv3_5,
                           data_out_conv3_6,
                           data_out_conv3_7,
                          data_out_conv3_8,
                           data_out_conv3_9,
                           data_out_conv3_10,
                           data_out_conv3_11,
                           data_out_conv3_12,
                           data_out_conv3_13,
                           data_out_conv3_14,
                           data_out_conv3_15,
                           load_weight0,
                           weight0,
                           weight1,
                           class0,
                           class1,
                         valid_out_fully,
                             load_weight_done
                          
                          );                                             
                                                   
   /*    softmax inst5(
    clk,
    resetn,
    valid_out_fully,
    class0,
    class1,
    predict0,
    predict1,
    valid_out
    );                                            
 */
 assign valid_out = valid_out_fully;                                
assign is = (valid_out==1)?(($signed(predict0) > $signed(predict1))? 2'b01 : 2'b10) : 2'b00 ;
endmodule