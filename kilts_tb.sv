`timescale 1ns / 1ps

module kilts_tb();


  wire [31:0] quotient,quotient_1;
  reg clk = 0;
  reg [31:0] a,b;
    Kilts_pipelined_Goldschmidt DUT(.*);
    parametrizable_Goldschmidt #(9) DUT_1(.*,.quotient(quotient_1));    
    real num[3:0] = {3.0,86.0,6742.0,1616.953125};
    real den[3:0] = {3.0,7.0,7.0,2044.3515625};
    real quot;
    int i = 3;
    always begin
      #5 clk = 0;
      #5 clk = 1;
    end
    
    initial begin
      #10;
      a = 32'b00000000_00000011_00000000_00000000;
      b = 32'b00000000_00000011_00000000_00000000;
      #10;
      a = 32'b00000000_01010110_00000000_00000000;
      b = 32'b00000000_00000111_00000000_00000000;
      
      #10;
      a = 32'b00011010_01010110_00000000_00000000;
      b = 32'b00000000_00000111_00000000_00000000;  
      
      #10;
      a = 32'b00000110_01010000_11110100_00000000;
      b = 32'b00001000_00000111_01011010_00000000;           
      
      #100 $finish;
    end
    
    always@(quotient) begin
      quot = num[i] / den[i];
      i--;
    end
    

endmodule
