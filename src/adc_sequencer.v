    `timescale 1ns/1ps

    module adc_sequencer(

        input clk,
        input reset,
        input adc_busy,   
        input adc_done,
        input [9:0] adc_data,
        output reg adc_start,
        output reg [2:0] adc_channel,
        output reg [9:0] red_reading,
        output reg [9:0] green_reading,
        output reg [9:0] blue_reading

    );

    localparam REQUEST = 2'b00;
    localparam WAIT_BUSY = 2'b01;
    localparam WAIT_DONE = 2'b10;

    reg [1:0] state;

    always @(posedge clk)

    if(reset) begin
        state <= REQUEST;
        adc_start <= 1'b0;
        adc_channel <= 3'b000;
        red_reading <= 10'd0;
        green_reading <= 10'd0;
        blue_reading <= 10'd0;

    end

    else begin
    adc_start <= 1'b0;

    case (state)
        REQUEST: begin
            if(!adc_busy) begin
                adc_start <= 1'b1;
                state <= WAIT_BUSY;
            end
        end

        WAIT_BUSY: begin
            if(adc_busy) begin
                state <= WAIT_DONE;
            end
        end

        WAIT_DONE: begin
             if(adc_done && !adc_busy) begin
                case(adc_channel)
                3'd0: red_reading <= adc_data;
                3'd1: green_reading <= adc_data;
                3'd2: blue_reading <= adc_data;
                endcase

             if(adc_channel == 3'd2)
                adc_channel <= 3'd0;

                else
                
                adc_channel <= adc_channel + 3'd1;
                state <= REQUEST;
              
             end
            end         
            

                

    
    endcase

    end
    




    endmodule