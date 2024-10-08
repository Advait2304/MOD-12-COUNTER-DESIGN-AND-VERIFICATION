`timescale 1ns / 1ps

class generator;
mailbox #(transaction) gen2drv;
transaction trans;
transaction trans_copy;
int i;

function new(mailbox#(transaction) gen2drv);
this.gen2drv=gen2drv;
this.trans=new;

endfunction

virtual task start();
fork
begin
for (i=0;i<no_of_transaction;i++)
begin
assert(trans.randomize);
trans_copy=new trans;
gen2drv.put(trans_copy);
end
end
join_none
endtask

endclass