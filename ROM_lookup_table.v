`timescale 1ns / 1ps

module ROM_lookup_table(
    input clk,
    input [9:0] addr,
    output [15:0] data
    );

   localparam ROM_WIDTH = 16;
   localparam ROM_ADDR_BITS = 10;

   (* rom_style="{distributed | block}" *)
   reg [ROM_WIDTH-1:0] lookup_table [(2**ROM_ADDR_BITS)-1:0];
   reg [ROM_WIDTH-1:0] output_data;

   wire [ROM_ADDR_BITS-1:0] address;

   initial
      $readmemb("C:/Users/19259/Documents/Goldschmidt_div_fixed_point/ROM_data.txt", lookup_table, 0, (2**ROM_ADDR_BITS)-1);

   always @(posedge clk)
         output_data <= lookup_table[address];
				
				
    assign address = addr;
    assign data = output_data[15:0];
    
    
    
    
    
endmodule
