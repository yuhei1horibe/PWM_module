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

`ifndef TOP_GUARD
`define TOP_GUARD

`include "interface.sv"
`include "random_test.sv"

// Test bench top module
module tbench_top;

    // Clock and Reset
    bit clk;
    bit reset;

    // Clock generation
    always #10 clk = ~clk;

    // Reset
    initial begin
        reset     = 0;
        #50 reset = 1;
    end

    // Interface
    pwm_intf intf(.pwm_clk(clk), .pwm_reset(reset));

    // Testcase instance
    test t1(intf);

    // DUT instantiation
    PWM_UNIT PWM_DUT(
        .pwm_value  (intf.pwm_value  ),
        .pwm_range  (intf.pwm_range  ),
        .pwm_clk    (intf.clk    ),
        .pwm_reset  (intf.reset  ),
        .pwm_en     (intf.pwm_en     ),

        .pwm_period (intf.pwm_period ),
        .pwm_out    (intf.pwm_out)
    );

    // Wave dump
    initial begin
        $dumpfile ("dump.vcd");
        $dumpvars;
    end
endmodule
`endif

