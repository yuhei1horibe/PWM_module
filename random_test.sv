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

`ifndef RAND_TEST_GUARD
`define RAND_TEST_GUARD

`include "environment.sv"

program test(pwm_intf intf);
    // Environment
    environment env;

    initial begin
        // Instantiation of environment
        env = new(intf);

        // Repeat count
        env.gen.repeat_count = 10;

        // Run test
        env.run();
    end
endprogram

`endif
