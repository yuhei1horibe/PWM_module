`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2019 04:51:20 PM
// Design Name: 
// Module Name: PWM_UNIT
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

// One PWM unit
module PWM_UNIT(
    input wire [7:0]pwm_value,
    input wire [7:0]pwm_range,
    input wire      pwm_clk,
    input wire      pwm_reset,
    input wire      pwm_en,

    output wire     pwm_period,
    output wire     pwm_out
    );
    reg [7:0]value_reg;
    reg [7:0]range_reg;
    reg [7:0]counter_reg;
    reg      counter_saturated;
    reg      out_reg;

    // Update the register values only when counter saturates
    always @( posedge counter_saturated )
    begin
        if ( pwm_reset == 1'b0 )
        begin
            range_reg   = 8'hFF;
            value_reg   = 8'h00;
        end
        else
        begin
            value_reg   <= pwm_value;
            range_reg   <= pwm_range;
        end
    end

    // Counter implementation
    always @( posedge pwm_clk )
    begin
        if ( pwm_reset == 1'b0 )
        begin
            counter_reg       <= 8'hFF;
            counter_saturated <= 1'b1;
        end
        else
        begin
            if( counter_reg < range_reg )
            begin
                counter_reg       <= counter_reg + 1;
                counter_saturated <= 1'b0;
            end
            else
            begin
                counter_reg       <= 8'h00;
                counter_saturated <= 1'b1;
            end
        end
    end

    // PWM output
    always @( posedge pwm_clk )
    begin
        if ( pwm_reset == 1'b0 || pwm_en == 1'b0 )
        begin
            out_reg <= 1'b0;
        end
        else
        begin
            if ( counter_reg <=  value_reg )
            begin
                out_reg <= 1'b1;
            end
            else
            begin
                out_reg <= 1'b0;
            end
        end
    end

    // Counter period output
    assign pwm_period = counter_saturated;

    // PWM output
    assign pwm_out    = out_reg;
endmodule

