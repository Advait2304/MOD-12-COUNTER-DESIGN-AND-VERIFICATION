`timescale 1ns / 1ps


class test;
virtual counter_iff.DRV dr_if;
virtual counter_iff.WR wr_if;
virtual counter_iff.RD rd_if;

environment env;


function new(virtual counter_iff.DRV dr_if,
virtual counter_iff.WR wr_if,
virtual counter_iff.RD rd_if);
this.dr_if=dr_if;
this.wr_if=wr_if;
this.rd_if=rd_if;
env=new(dr_if,wr_if,rd_if);
endfunction

virtual task build();
env.build();
endtask

virtual task run();
env.run();
endtask

endclass