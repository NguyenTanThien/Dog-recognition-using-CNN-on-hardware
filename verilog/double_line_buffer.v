
module double_line_buffer #(parameter DATA_WIDTH = 32,
                parameter IMG_WIDTH = 34
                )
        (clk,resetn/*,enable*/,data_valid_in,data_in,w1,w2,w3,w4,w5,w6,w7,w8,w9,valid_out);
    input clk;
    input resetn;
    //input enable;
    input data_valid_in;
    

    input [DATA_WIDTH-1:0] data_in;

    output [DATA_WIDTH-1:0] w1;
    output [DATA_WIDTH-1:0] w2;
    output [DATA_WIDTH-1:0] w3;
    output [DATA_WIDTH-1:0] w4;
    output [DATA_WIDTH-1:0] w5;
    output [DATA_WIDTH-1:0] w6;
    output [DATA_WIDTH-1:0] w7; 
    output [DATA_WIDTH-1:0] w8;
    output [DATA_WIDTH-1:0] w9;
    output valid_out;
    
   
    wire enable;
    
    delay_valid #(.N_CLOCKs(IMG_WIDTH+1)) valid_ins(clk,resetn,data_valid_in,valid_out);

    
    assign w9 = data_in;
    line_buffer #(.DATA_WIDTH(DATA_WIDTH),.IMG_WIDTH(IMG_WIDTH)) 
                  lb_1(
                    clk,
                    resetn,
                    data_valid_in,
                    w9,
                    w6
                    );
                    
    line_buffer #(.DATA_WIDTH(DATA_WIDTH),.IMG_WIDTH(IMG_WIDTH)) 
                  lb_2(
                    clk,
                    resetn,
                    data_valid_in,
                    w6,
                    w3
                    );


    nbit_dff #(.DATA_WIDTH(DATA_WIDTH)) 
              dff_a8(
                clk,
                resetn,
                data_valid_in,
                w9,
                w8
                );
    nbit_dff #(.DATA_WIDTH(DATA_WIDTH)) 
              dff_a7(
                clk,
                resetn,
                data_valid_in,
                w8,
                w7
                );
    nbit_dff #(.DATA_WIDTH(DATA_WIDTH)) 
              dff_a5(
                clk,
                resetn,
                data_valid_in,
                w6,
                w5
                );
    nbit_dff #(.DATA_WIDTH(DATA_WIDTH)) 
              dff_a4(
                clk,
                resetn,
                data_valid_in,
                w5,
                w4
                );
    nbit_dff #(.DATA_WIDTH(DATA_WIDTH)) 
              dff_a2(
                clk,
                resetn,
                data_valid_in,
                w3,
                w2
                );
    nbit_dff #(.DATA_WIDTH(DATA_WIDTH)) 
              dff_a1(
                clk,
                resetn,
                data_valid_in,
                w2,
                w1
                );

endmodule