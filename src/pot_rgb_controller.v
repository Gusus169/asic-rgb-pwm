`timescale 1ns/1ps

module pot_rgb_controller(

    input clk,
    input reset,
    input miso,
    output wire red_pwm,
    output wire green_pwm,
    output wire blue_pwm,
    output wire cs_n,
    output wire sclk,
    output wire mosi

);

wire [9:0] adc_data;
wire adc_busy;
wire adc_done;
wire adc_start;
wire [2:0] adc_channel;

wire [9:0] red_reading;
wire [9:0] green_reading;
wire [9:0] blue_reading;


adc_sequencer sequencer_inst(
    .clk(clk),
    .reset(reset),
    .adc_busy(adc_busy),
    .adc_done(adc_done),
    .adc_data(adc_data),
    .adc_start(adc_start),
    .adc_channel(adc_channel),
    .red_reading(red_reading),
    .green_reading(green_reading),
    .blue_reading(blue_reading)
);


mcp3008_controller spi_inst(
    .clk(clk),
    .reset(reset),
    .start(adc_start),
    .channel(adc_channel),
    .miso(miso),
    .cs_n(cs_n),
    .sclk(sclk),
    .mosi(mosi),
    .data(adc_data),
    .busy(adc_busy),
    .done(adc_done)
);

wire [8:0] brightness_red;
wire [8:0] brightness_green;
wire [8:0] brightness_blue;


assign brightness_red = (red_reading == 10'd1023)
                      ? 9'd256
                      : {1'b0, red_reading[9:2]};

assign brightness_green = (green_reading == 10'd1023)
                        ? 9'd256
                        : {1'b0, green_reading[9:2]};

assign brightness_blue = (blue_reading == 10'd1023)
                       ? 9'd256
                        : {1'b0, blue_reading[9:2]};

rgb_controller rgb_inst(
    .clk(clk),
    .reset(reset),
    .brightness_red(brightness_red),
    .brightness_green(brightness_green),
    .brightness_blue(brightness_blue),
    .pwm_red(red_pwm),
    .pwm_green(green_pwm),
    .pwm_blue(blue_pwm)
);

endmodule 