module ROM_w
 (
        addr,
        data_out,
        data_out1
    );

    input [64-1:0] addr;
    output [31:0] data_out;
    output [31:0] data_out1;
    reg [31:0] my_rom [0 : 257-1];
    reg [31:0] my_rom1 [0 : 257-1];
  
    assign data_out = my_rom[addr];
    assign data_out1 = my_rom1[addr];
endmodule
