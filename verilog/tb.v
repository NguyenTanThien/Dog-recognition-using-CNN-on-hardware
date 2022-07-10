`timescale 1ns/1ps
module tb();
    
    reg clk,resetn,valid_in,enable;
    reg [31:0]data_in0,data_in1,data_in2;
    wire [31:0]predict0,predict1;
    wire load_weight;
    wire load_weight_done;
    wire load_kernel;
    wire load_kernel_done;
    reg [31:0] d1[0:1023];
    reg [31:0] d2[0:1023];
    reg [31:0] d3[0:1023];
    reg [31:0]counter;
   
    wire   valid_out;
    wire [63:0]counter_load;
    wire ready;
    wire  valid_out_layer1, valid_out_layer2, valid_out_layer3, valid_out_fully;
     wire [31:0]class0,class1;
     
     wire [1:0]is;
    top top_inst(
               clk,
              resetn,
              enable,
              valid_in,
              
              data_in0,
              data_in1,
              data_in2,
              predict0,
              predict1,
              is,
              load_weight_done,
              load_kernel,
             load_kernel_done,
              load_weight,

              counter_load,
              valid_out,
              ready,
              
             valid_out_layer1,
            valid_out_layer2,
             valid_out_layer3,
              valid_out_fully,
            
              class0,
              class1
              
);
    initial begin
     $readmemb("D:/CNN/verilog/weight/W1.txt",top_inst.rom_w.my_rom1);
     $readmemb("D:/CNN/verilog/weight/W0.txt",top_inst.rom_w.my_rom);
    $readmemb("D:/CNN/verilog/weight/kernel.txt",top_inst.rom.my_rom); 
    $readmemb("D:/CNN/software/result_layer/0_0.txt",d1);
    $readmemb("D:/CNN/software/result_layer/1_1.txt",d2);
    $readmemb("D:/CNN/software/result_layer/2_2.txt",d3);
    #0 clk = 0; resetn = 0; enable = 0; valid_in = 0;data_in0 = 0;data_in1 =0; data_in2=0;
    #100 resetn = 1;
    #100 enable = 1;
    #20 enable = 0;
    
    
    end
    always @(posedge clk)begin
    if(ready == 1 )
            valid_in <= 1;
     if(valid_out == 1 & counter == 1023) valid_in = 0;
    end

    always #10 clk = !clk;
    always @(posedge clk or negedge resetn)begin
        if(resetn ==0)
            counter <= 0;
            else if(valid_in == 1)begin
                        if(counter == 1023)counter <= counter;
                            else counter <= counter+1;
                            end
    
    end
    always @(counter)begin
        data_in0 <= d1[counter];
        data_in1 <= d2[counter];
        data_in2 <= d3[counter];
    end
/////////////////////////////
/////////////////////////////
parameter size2 = 1024;
 write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_result_0.txt"),.SIZE(size2))
			write_inst1_0(
 				clk,
 				resetn,
 				top_inst.inst.valid_out,
 				top_inst.inst.data_in_max0
 			);
write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_result_1.txt"),.SIZE(size2))
			write_inst1_1(
 				clk,
 				resetn,
 				top_inst.inst.valid_out,
 				top_inst.inst.data_in_max1
 			);
write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_result_2.txt"),.SIZE(size2))
			write_inst1_2(
 				clk,
 				resetn,
 				top_inst.inst.valid_out,
 				top_inst.inst.data_in_max2
 			);
write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_result_3.txt"),.SIZE(size2))
			write_inst1_3(
 				clk,
 				resetn,
 				top_inst.inst.valid_out,
 				top_inst.inst.data_in_max3
 			);


	///////////////////////
    ////////////////////////////
    parameter size = 256;
   write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_0.txt"),.SIZE(size))
			write_convo3_0(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max0
 			);
 			
    write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_1.txt"),.SIZE(size))
			write_convo3_1(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max1
 			);
write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_2.txt"),.SIZE(size))
			write_convo3_3(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max2
 			);
 			
write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_3.txt"),.SIZE(size))
			write_convo3_4(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max3
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_4.txt"),.SIZE(size))
			write_convo3_5(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max4
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_5.txt"),.SIZE(size))
			write_convo3_6(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max5
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_6.txt"),.SIZE(size))
			write_convo3_7(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max6
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D:/CNN/out_verilog/conv3d_1_result_7.txt"),.SIZE(size))
			write_convo3_8(
 				clk,
 				resetn,
 				top_inst.inst1.valid_out,
 				top_inst.inst1.data_in_max7
 			);
 			
 			
 			////////////////////////////////
 			/////////////////////////
 			////
 			
 			parameter size1 = 64;
    write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_0.txt"),.SIZE(size1))
			write_convo3_11(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max0
 			);
write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_1.txt"),.SIZE(size1))
			write_convo3_31(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max1
 			);
 			
write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_2.txt"),.SIZE(size1))
			write_convo3_41(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max2
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_3.txt"),.SIZE(size1))
			write_convo3_51(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max3
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_4.txt"),.SIZE(size1))
			write_convo3_61(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max4
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_5.txt"),.SIZE(size1))
			write_convo3_71(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max5
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_6.txt"),.SIZE(size1))
			write_convo3_81(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max6
 			);
 			
 			
 write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_7.txt"),.SIZE(size1))
			w1rite_inst_1(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max7
 			);
 			
    write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_8.txt"),.SIZE(size1))
			w1rite_inst_2(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max8
 			);
write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_9.txt"),.SIZE(size1))
			w1rite_inst_3(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max9
 			);
 			
write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_10.txt"),.SIZE(size1))
			w1rite_inst_4(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max10
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_11.txt"),.SIZE(size1))
			w1rite_inst_5(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max11
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_12.txt"),.SIZE(size1))
			w1rite_inst_6(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max12
 			);
	
write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_13.txt"),.SIZE(size1))
			w1rite_inst_7(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max13
 			);

write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_14.txt"),.SIZE(size1))
			w1rite_inst_8(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max14
 			);
 		
 		write_file #(.DATA_WIDTH(32),.FILENAME("D://CNN/out_verilog//conv3d_2_result_15.txt"),.SIZE(size1))
			w1rite_inst_9(
 				clk,
 				resetn,
 				top_inst.inst3.valid_out,
 				top_inst.inst3.data_in_max15
 			);
 			 
 ///////////////////////////////////////
 ///////////////////////////////////////

    endmodule
    

