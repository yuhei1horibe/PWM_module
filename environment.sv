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

`ifndef ENV_GUARD
`define ENV_GUARD

`include "generator.sv"
`include "driver.sv"

// Environment has generator, transaction
// and mailbox and connects those 2 blocks
// 
class environment;
    // Generator and Driver instances
    Generator gen;
    Driver    drv;

    // mailbox
    mailbox gen2drv;

    // End event
    event gen_ended;

    // Virtual interface
    virtual pwm_intf pwm_vif;

    // Constructor
    function new (virtual pwm_intf pwm_vif);
        this.pwm_vif = pwm_vif;

        // Create mailbox
        gen2drv = new();

        // Instantiating generator and driver
        gen = new(gen2drv, gen_ended);
        drv = new(pwm_vif, gen2drv);
    endfunction

    task pre_test();
        drv.reset();
    endtask

    task test();
        fork
            gen.gen_trans();
            drv.drive();
        join_any
    endtask

    task post_test();
        wait(gen_ended.triggered);
        wait(gen.repeat_count == drv.num_transactions);
    endtask

    // Main task
    task run();
        pre_test();
        test();
        post_test();
        $finish;
    endtask
endclass

`endif
