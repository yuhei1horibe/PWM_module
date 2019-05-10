//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2019 04:51:20 PM
// Design Name: 
// Module Name: PWM_UNIT_TEST
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`ifndef INTF_GUARD
`define INTF_GUARD

interface pwm_intf(input logic clk, reset);
    // Signals
    logic [7:0] pwm_value;
    logic [7:0] pwm_range;
    logic       pwm_en;

    logic       pwm_period;
    logic       pwm_out;
    
    // Driver clocking block
    clocking driver_cb @(posedge clk);
        default input #256 output #256;
        output pwm_value;
        output pwm_range;
        output pwm_en;

        input  pwm_period;
        input  pwm_out;
    endclocking

    // Monitor clocking block
    clocking monitor_cb @(posedge clk);
        default input#1 output #1;
        input  pwm_value;
        input  pwm_range;
        input  pwm_en;

        input  pwm_period;
        input  pwm_out;
    endclocking

    // modport
    modport DRIVER (clocking driver_cb, input clk, reset);
    modport MONITOR (clocking monitor_cb, input clk, reset);
endinterface

`endif
