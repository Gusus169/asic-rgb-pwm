`timescale 1ns/1ps

module rgb_controller ( 

    input clk,
    input reset,
    input  [8:0] brightness_red,
    input  [8:0] brightness_green,
    input  [8:0] brightness_blue,
    output pwm_red,
    output pwm_green,
    output pwm_blue
);

wire [7:0] count;

counter_8bit counter_inst ( 
    .clk(clk),
    .reset(reset),
    .count(count)
);

comparator_8bit red_inst ( 
    .count(count),
    .brightness(brightness_red),
    .pwm(pwm_red)

);

comparator_8bit green_inst ( 
    .count(count),
    .brightness(brightness_green),
    .pwm(pwm_green)

);

comparator_8bit blue_inst ( 
    .count(count),
    .brightness(brightness_blue),
    .pwm(pwm_blue)

);

endmodule