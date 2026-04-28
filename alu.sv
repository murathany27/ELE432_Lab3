module alu(input  logic [31:0] SrcA, SrcB,
           input  logic [2:0]  ALUControl,
           output logic [31:0] ALUResult,
           output logic        Zero);

    always_comb begin
        case(ALUControl)
            3'b010: ALUResult = SrcA + SrcB;       // ADD (Artık 010)
            3'b110: ALUResult = SrcA - SrcB;       // SUB (Artık 110)
            3'b000: ALUResult = SrcA & SrcB;       // AND (Artık 000)
            3'b001: ALUResult = SrcA | SrcB;       // OR  (Artık 001)
            3'b111: ALUResult = (SrcA < SrcB) ? 32'd1 : 32'd0; // SLT
            3'b100: ALUResult = SrcA ^ SrcB;       // XOR (Bizim eklediğimiz XOR)
            default: ALUResult = 32'bx;            
        endcase
    end

    assign Zero = (ALUResult == 32'b0);
endmodule