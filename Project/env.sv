`timescale 1ns / 1ps

class environment;
virtual counter_iff.DRV dr_if;
virtual counter_iff.WR wrmon_if;
virtual counter_iff.RD rdmon_if;

mailbox#(transaction) gen2dr=new();
mailbox#(transaction) rm2sb=new();
mailbox#(transaction) mon2sb=new();
mailbox#(transaction) mon2rm=new();

generator gen;
driver drv;
wr_mon wrmon;
read_monitor rdmon;
scoreboard sb;
reference refmod;


function new(virtual counter_iff.DRV dr_if,virtual counter_iff.WR wrmon_if,virtual counter_iff.RD rdmon_if);
this.dr_if=dr_if;
this.wrmon_if=wrmon_if;
this.rdmon_if=rdmon_if;

endfunction

virtual task build();
gen=new(gen2dr);
drv=new(gen2dr,dr_if);
wrmon=new(mon2rm,wrmon_if);
rdmon=new(rdmon_if,mon2sb);
refmod=new(mon2rm,rm2sb);
sb=new(rm2sb,mon2sb);
endtask

virtual task reset_duv();
@(dr_if.dr_cb);
dr_if.dr_cb.rst<=1'b0;
repeat(2)
@(dr_if.dr_cb);
dr_if.dr_cb.rst<=1'b1;

endtask

virtual task start();

gen.start();
drv.start();
wrmon.start();
rdmon.start();
refmod.start();
sb.start();
endtask

virtual task run();
reset_duv();
start();
wait(sb.DONE.triggered);
sb.report();
endtask

endclass