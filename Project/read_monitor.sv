`timescale 1ns / 1ps

class read_monitor;

virtual counter_iff.RD rd_mon_if;
transaction data2sb,rd_data;
mailbox#(transaction) mon2sb;

function new(virtual counter_iff.RD rd_mon_if,mailbox#(transaction) mon2sb);
begin
this.rd_mon_if=rd_mon_if;
this.mon2sb=mon2sb;
this.rd_data=new();
end
endfunction

virtual task monitor();
@(rd_mon_if.rd_cb)
rd_data.count=rd_mon_if.rd_cb.count;
rd_data.display("DATA FROM RD MONITOR");
endtask

virtual task start();
fork
begin
forever
begin
monitor();
data2sb=new rd_data;
mon2sb.put(data2sb);
end
end
join_none
endtask
endclass
