`timescale 1ns / 1ps

module parametrizable_Goldschmidt#(parameter number_of_iterations = 7) //latency = 2 * number_of_iterations
   (
  output [31:0] quotient,
  input clk,
  input [31:0] a,b
    );
    
    reg [47:0]denom_reg   [number_of_iterations - 1:0];
    reg [47:0]denom_reg_1 [number_of_iterations - 1:0];    
    reg [47:0]num_reg     [number_of_iterations - 1:0];
    reg [47:0]num_reg_1   [number_of_iterations - 1:0];    
    reg [47:0]factor_reg  [number_of_iterations - 1:0];

    
    wire [95:0] denom [number_of_iterations - 1:0];
    wire [95:0] num   [number_of_iterations - 1:0];   
    wire [48:0] f     [number_of_iterations - 1:0];    
     
    
    wire[15:0] LutOut;
    wire[15:0] f_min_1;
    reg [31:0] areg,breg;      
    
    ROM_lookup_table gslut(                //This ROM uses the 10 MSBs of the denominator (b) to select an initial estimate of the 1/denominator value.
                           .addr(b[31:22]),
                           .clk(clk),
                           .data(LutOut)
                           );
                           
    assign f_min_1  = LutOut;
    assign denom[0] = breg * f_min_1;
    assign num[0]   = areg * f_min_1;  
    
    always@(posedge clk) begin
      areg <= a;
      breg <= b;    
      
      factor_reg[0]  <= f[0][47:0]; 
      denom_reg[0]   <= denom[0][47:0];
      num_reg[0]     <= num[0][47:0];
      
      denom_reg_1[0] <= denom_reg[0];
      num_reg_1[0]   <= num_reg[0];
                        
    end      
    
    genvar g;
    
    for(g = 0; g < number_of_iterations; g = g + 1) begin
      assign f[g] = {14'b0,2'b10,32'b0} - denom_reg[g];
    end
    
    for(g = 1; g < number_of_iterations; g = g + 1) begin
      assign denom[g] = denom_reg_1[g-1] * factor_reg[g-1];
      assign num[g] = num_reg_1[g-1] * factor_reg[g-1];
      
      always@(posedge clk) begin
        factor_reg[g]  <= f[g][47:0];
        denom_reg[g]   <= denom[g][79:32];
        num_reg[g]     <= num[g][79:32];
        denom_reg_1[g] <= denom_reg[g];
        num_reg_1[g]   <= num_reg[g];
      end
      
    end    
    
    assign quotient = num_reg[number_of_iterations - 1][47:16];
                                                    
    
endmodule
