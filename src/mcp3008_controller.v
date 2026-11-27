`timescale 1ns/1ps

module mcp3008_controller(
    input clk,
    input reset,
    input start,
    input [2:0] channel,
    input miso,
    output reg cs_n,
    output reg sclk,
    output reg mosi,
    output wire [9:0] data,
    output reg busy,
    output reg done

);

    reg [23:0] command;
    reg [4:0] bit_index;

    parameter integer SPI_HALF_CYCLES = 4; // how many clock cycles make half of of the spi main clock
    reg [15:0] divider_count;

    wire reciever_reset;
    wire reciever_enable;

adc_receiver reciever_inst(
    .clk(clk),
    .reset(reciever_reset),
    .shift_in(miso),
    .shift_enable(reciever_enable),
    .data(data),
    .bits_received(),
    .done()
);

assign reciever_reset = reset || (start && !busy);

assign reciever_enable = busy && !sclk
                      && (divider_count == SPI_HALF_CYCLES - 1)
                      && (bit_index <= 5'd9);

always @(posedge clk)

 begin
    if (reset) begin
       cs_n <= 1'b1;
       sclk <= 1'b0;
       mosi <= 1'b0;    
       busy <= 1'b0;
       done <= 1'b0;
       command <= 24'd0;
       bit_index <= 5'd0;
       divider_count <= 16'd0;
    
    end

    else if (start && !busy) begin
       sclk <= 1'b0;
       mosi <= 1'b0;
       bit_index <= 5'd23;
       cs_n <= 1'b0; //  chip select
       busy <= 1'b1;
       done <= 1'b0;
       command <= {8'b00000001, 1'b1, channel, 12'b000000000000};
       divider_count <= 16'd0;
end
else if (busy) begin
    if (divider_count == SPI_HALF_CYCLES - 1) begin
        divider_count <= 16'd0;
            if (bit_index == 5'd24) begin
        cs_n <= 1'b1;
        busy <= 1'b0;
        done <= 1'b1;
        mosi <= 1'b0;
    end else begin
       
        sclk <= ~sclk;
       if (sclk) begin   // falling edege block 
    if (bit_index == 5'd0) begin
        bit_index <= 5'd24;
    end else begin
        bit_index <= bit_index - 5'd1;
        mosi <= command[bit_index - 5'd1];
    end
end  // falling edege block end
    end
    end else begin
        divider_count <= divider_count + 16'd1;
    end
end

 end
endmodule


 
