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

`ifndef GEN_GUARD
`define GEN_GUARD

`include "transaction.sv"

// Generator will generate transactions,
// and pass it to driver
class Generator;
    // Transaction class
    pwm_transaction trans;

    // mailbox
    mailbox gen2drv;

    // Repeat count
    int repeat_count;

    // Generator end event
    event ended;

    // Constructor
    function new (mailbox gen2drv, event ended);
    //function new (mailbox gen2drv);
        this.gen2drv = gen2drv;
        this.ended   = ended;
    endfunction

    task gen_trans();
        repeat(repeat_count)
        begin
            trans = new();
            if(!trans.randomize())
            begin
                $fatal("Gen::trans randomization failed");
            end
            gen2drv.put(trans);
        end
        ->ended;
    endtask
endclass
`endif
