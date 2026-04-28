module testbench();
    logic        clk;
    logic        reset;
    logic [31:0] WriteData, DataAdr;
    logic        MemWrite;

    top dut(clk, reset, WriteData, DataAdr, MemWrite);

    initial begin
        reset <= 1; # 22; reset <= 0;
    end

    always begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    always @(negedge clk) begin
        if(MemWrite) begin
            if(DataAdr === 100 & WriteData === 25) begin
                $display("SUCCESS! XOR is working.");
                $stop;                               
            end else begin
                $display("FAIL!");                   
                $stop;                               
            end
        end
    end
endmodule