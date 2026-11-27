/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_gusus169_rgb_pwm (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7:6] = 2'b00;
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};

pot_rgb_controller controller_inst(
    .clk(clk),
    .reset(!rst_n),
    .miso(ui_in[0]),
    .red_pwm(uo_out[0]),
    .green_pwm(uo_out[1]),
    .blue_pwm(uo_out[2]),
    .cs_n(uo_out[3]),
    .sclk(uo_out[4]),
    .mosi(uo_out[5])
);

endmodule
