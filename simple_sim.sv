`timescale 1ns / 1ps

// Testbench top module
module simple_sim;
    bit clk;
    bit reset;
    bit pwm_en;

    bit [7:0]pwm_value;
    bit [7:0]pwm_range;

    bit pwm_out;
    bit pwm_period;

    // Reset
    initial begin
        reset     = 1'b0;
        pwm_en    = 1'b0;
        pwm_range = 8'h00;
        pwm_value = 8'h00;
        #30
        reset     = 1'b1;
        #100
        pwm_en    = 1'b1;
        pwm_range = 8'hFF;
    end

    // Clock generation
    always #5 begin
        clk = ~clk;
    end
    
    always #2560 begin
        pwm_value = pwm_value + 1;
        $displayb(pwm_value);
    end

    PWM_UNIT pwm_dut(
        .pwm_clk    (clk),
        .pwm_reset  (reset),
        .pwm_en     (pwm_en),
        .pwm_value  (pwm_value),
        .pwm_range  (pwm_range),
        .pwm_out    (pwm_out),
        .pwm_period (pwm_period)
    );
endmodule

