`timescale 1ns/1ps

module adc_receiver(


    input clk,
    input reset,
    input shift_in,   
    input shift_enable,
    output reg [9:0] data,
    output reg [3:0] bits_received,
    output wire done

);

always @ (posedge clk) begin

 if(reset) begin
  data <= 10'b0000000000;
  bits_received <= 4'd0;
end

 else if (shift_enable && bits_received < 4'd10) begin
  data <=  {data[8:0], shift_in};
  bits_received <= bits_received + 4'd1;
end


end

assign done = (bits_received == 4'd10);


endmodule