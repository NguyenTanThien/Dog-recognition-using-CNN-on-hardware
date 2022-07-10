module ROM
 (
        addr,
        data_out
    );

    input [64-1:0] addr;
    output [31:0] data_out;

    reg [31:0] my_rom [0 : 1576-1];
    
    
    assign data_out = my_rom[addr];

endmodule