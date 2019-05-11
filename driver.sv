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

`ifndef DRV_GUARD
`define DRV_GUARD

`include "interface.sv"
`include "transaction.sv"

`define DRIV_IF pwm_vif.DRIVER.driver_cb

class Driver;
    // Count the transactions
    int num_transactions;

    // Virtual interface
    virtual pwm_intf pwm_vif;

    // mailbox
    mailbox gen2drv;

    // Constructor
    function new (virtual pwm_intf pwm_vif, mailbox gen2drv);
        this.pwm_vif = pwm_vif;
        this.gen2drv = gen2drv;
    endfunction

    // Reset task
    task reset();
        wait(!pwm_vif.DRIVER.reset);
        $display("----[DRIVER] Reset----");
        `DRIV_IF.pwm_value  <= 8'h00;
        `DRIV_IF.pwm_range  <= 8'hFF;
        `DRIV_IF.pwm_en     <= 0;
        wait(pwm_vif.DRIVER.reset);
        $display("----[DRIVER] Unreset----");
    endtask

    // Drive the transaction itemst to interface signals
    task drive();
        forever begin
            pwm_transaction trans;
            `DRIV_IF.pwm_en <= 1'b1;
            gen2drv.get(trans);
            $display("----[DRIVER-TRANSER: %0d]----", num_transactions);
            @(posedge pwm_vif.DRIVER.clk);
            begin
            //@(posedge `DRIV_IF.clk);
                `DRIV_IF.pwm_value <= trans.pwm_value;
                `DRIV_IF.pwm_range <= trans.pwm_range;
            end
            $display("\tRange: %0d, Value: %0d", trans.pwm_range, trans.pwm_value);
            $display("-----------------------------");
            num_transactions++;
        end
    endtask
endclass

`endif
