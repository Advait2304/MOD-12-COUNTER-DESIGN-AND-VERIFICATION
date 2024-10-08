 `timescale 1ns / 1ps

class wr_mon;
mailbox#(transaction) mon2ref;
transaction datawrm2c;
transaction copy_datawrm2c;
virtual counter_iff.WR mon_if;

function new(mailbox#(transaction) mon2ref, virtual counter_iff.WR mon_if);
this.mon2ref=mon2ref;
this.mon_if=mon_if;
this.datawrm2c=new();

endfunction

virtual task monitor();
@(mon_if.wr_cb)
datawrm2c.load<=mon_if.wr_cb.load;
datawrm2c.Din<=mon_if.wr_cb.Din;
datawrm2c.up_down<=mon_if.wr_cb.up_down;
datawrm2c.rst<=mon_if.wr_cb.rst;
datawrm2c.display("DATA FROM WR MONITOR");
endtask

virtual task start();
fork
begin
forever
begin
monitor();
copy_datawrm2c=new datawrm2c;
mon2ref.put(copy_datawrm2c);
end
end
join_none
endtask


endclass