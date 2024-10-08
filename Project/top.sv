`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Advait Risbud
// 
// Create Date: 07.10.2024 12:51:29
// Design Name: Top testbench
// Module Name: top
// Project Name: Modulo 12 counter
// Target Devices: 
// Tool Versions: Vivado 2024.1
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top();

import counter_pkg::*;
reg clock;

counter_iff DUV_IF(clock);
test t_h;

counter DUV(.clk(clock),.Din(DUV_IF.Din),.load(DUV_IF.load),.up_down(DUV_IF.up_down),.rst(DUV_IF.rst),.count(DUV_IF.count));

initial 
begin
clock=1'b0;
forever
#10 clock=~clock;
end

initial begin
t_h=new(DUV_IF,DUV_IF,DUV_IF);
no_of_transaction=100;
t_h.build();
t_h.run();
$finish;


end
endmodule
