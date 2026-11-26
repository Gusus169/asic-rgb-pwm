`timescale 1ns/1ps

module counter_8bit (//this is the 8 bit syncronous counter // just expanded version of 2 bit counter
    
    input wire clk,
    input wire reset,
    output reg [7:0] count);

    always @ (posedge clk) begin

     if(reset)
      count <=8'b0000000;
     else
      count <= count + 8'b0000001;
    
    end
   
endmodule