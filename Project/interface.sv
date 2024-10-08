`timescale 1ns / 1ps

interface counter_iff(input bit clk);
logic [3:0]Din;
logic load;
logic rst;
logic up_down;
logic [3:0] count;


clocking dr_cb@(posedge clk);
default input #1 output #1;
output Din;
output load;
output up_down;
output rst;
endclocking

clocking wr_cb@(posedge clk);
default input #1 output #1;
input Din;
input load;
input up_down;
input rst;
endclocking


clocking rd_cb@(posedge clk);
default input #1 output #1;
input count;
endclocking

modport DRV(clocking dr_cb);
modport WR(clocking wr_cb);
modport RD(clocking rd_cb);


endinterface