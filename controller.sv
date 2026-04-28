module controller (input  logic       clk, reset,
                   input  logic [6:0] op,
                   input  logic [2:0] funct3,
                   input  logic       funct7b5,
                   input  logic       zero,
                   output logic [1:0] immsrc,
                   output logic [1:0] alusrca, alusrcb,
                   output logic [1:0] resultsrc,
                   output logic       adrsrc,
                   output logic [2:0] alucontrol,
                   output logic       irwrite, pcwrite,
                   output logic       regwrite, memwrite);

    logic branch, pcupdate;
    logic [1:0] aluop;

    // 1. Main FSM Unit
    mainfsm fsm_unit (
        .clk(clk), .reset(reset), .op(op),
        .Branch(branch), .PCUpdate(pcupdate), .RegWrite(regwrite), .MemWrite(memwrite),
        .IRWrite(irwrite), .AdrSrc(adrsrc),
        .ResultSrc(resultsrc), .ALUSrcB(alusrcb), .ALUSrcA(alusrca), .ALUOp(aluop)
    );

    // 2. ALU Decoder Unit
    aludec aludec_unit (
        .opb5(op[5]), 
        .funct3(funct3), 
        .funct7b5(funct7b5), 
        .ALUOp(aluop),  
        .ALUControl(alucontrol)
    );

    // 3. Instruction Decoder Unit
    instrdec instrdec_unit (
        .op(op), .ImmSrc(immsrc)
    );

    // 4. PCWrite Logic
    assign pcwrite = pcupdate | (branch & zero);

endmodule