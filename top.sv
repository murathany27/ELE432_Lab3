module top(input  logic        clk, reset,
           output logic [31:0] WriteData, DataAdr,
           output logic        MemWrite);

    logic [31:0] ReadData;

    riscv rv_core(
        .clk(clk), .reset(reset),
        .MemWrite(MemWrite),
        .Adr(DataAdr),       
        .WriteData(WriteData),
        .ReadData(ReadData)
    );

    mem memory_unit(
        .clk(clk), 
        .we(MemWrite), 
        .a(DataAdr), 
        .wd(WriteData), 
        .rd(ReadData)
    );

endmodule