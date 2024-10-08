`timescale 1ns / 1ps

class driver;
mailbox #(transaction) gen2drv;
transaction data_r;
virtual counter_iff.DRV drv_if;

function new(mailbox#(transaction) gen2drv, virtual counter_iff.DRV drv_if);
begin
this.gen2drv=gen2drv;
this.drv_if=drv_if;
end
endfunction


virtual task drive();
begin
@(drv_if.dr_cb);
drv_if.dr_cb.load<=data_r.load;
drv_if.dr_cb.Din<=data_r.Din;
drv_if.dr_cb.up_down<=data_r.up_down;
drv_if.dr_cb.rst<=data_r.rst;
end
endtask




virtual task start();
fork
begin
forever
begin
gen2drv.get(data_r);
drive();
end
end
join_none
endtask


endclass