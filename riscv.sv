module riscv(input  logic        clk, reset,
             output logic        MemWrite,
             output logic [31:0] Adr, WriteData,
             input  logic [31:0] ReadData);

    // Controller ve Datapath arasındaki dahili sinyaller
    logic [6:0] op;
    logic [2:0] funct3;
    logic       funct7b5;
    logic       Zero;
    
    logic [1:0] ImmSrc;
    logic [1:0] ALUSrcA, ALUSrcB;
    logic [1:0] ResultSrc;
    logic       AdrSrc;
    logic [2:0] ALUControl;
    logic       IRWrite, PCWrite, RegWrite;

    // 1. Kontrol Ünitesi (HW2'den)
    controller c(
        .clk(clk), .reset(reset), 
        .op(op), .funct3(funct3), .funct7b5(funct7b5), .zero(Zero),
        .immsrc(ImmSrc), 
        .alusrca(ALUSrcA), .alusrcb(ALUSrcB), 
        .resultsrc(ResultSrc), 
        .adrsrc(AdrSrc), 
        .alucontrol(ALUControl),
        .irwrite(IRWrite), .pcwrite(PCWrite), 
        .regwrite(RegWrite), .memwrite(MemWrite)
    );

    // 2. Veri Yolu (Az önce yazdığımız)
    datapath dp(
        .clk(clk), .reset(reset),
        .ResultSrc(ResultSrc), 
        .PCWrite(PCWrite), .AdrSrc(AdrSrc), .IRWrite(IRWrite),
        .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), 
        .ALUControl(ALUControl), 
        .ImmSrc(ImmSrc), .RegWrite(RegWrite),
        .ReadData(ReadData),
        .op(op), .funct3(funct3), .funct7b5(funct7b5), .Zero(Zero),
        .Adr(Adr), .WriteData(WriteData)
    );

endmodule