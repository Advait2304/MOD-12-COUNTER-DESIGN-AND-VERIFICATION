`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Advait Risbud
// 
// Create Date: 05.10.2024 19:46:42
// Design Name: 
// Module Name: design
// Project Name: Modulo 12 Counter
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


module counter(
count,Din,load,rst,clk,up_down
    );
input [3:0]Din;
input load;
input rst;
input clk;
input up_down;
output reg [3:0] count;

always@(posedge clk)
begin
if (rst)
count<=0;

else if(load)
count<=Din;

else if(!up_down)
begin
if(count>=11)
count<=0;
else
count<=count+1;
end


else if(up_down)
begin
if(count<=0)
count<=11;
else
count<=count-1;
end

end
endmodule
