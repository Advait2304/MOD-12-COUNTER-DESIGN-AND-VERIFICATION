`timescale 1ns / 1ps

class reference;
transaction wdata;
static logic[3:0] ref_count=0;

mailbox#(transaction) wrmon2rm;
mailbox #(transaction) rm2sb;

function new(mailbox #(transaction) wrmon2rm, mailbox#(transaction) rm2sb);
this.wrmon2rm=wrmon2rm;
this.rm2sb=rm2sb;
endfunction


virtual task count_mod(transaction model_counter);
begin
if(model_counter.load)
ref_count<= model_counter.Din;
else
begin
if(!model_counter.up_down)
begin
if(ref_count>=11)
ref_count<=0;
else
ref_count<=ref_count+1;
end

else
begin
if(ref_count<=0)
ref_count<=11;
else
ref_count<=ref_count-1;
end

end
end

$display(" %d =From REF model",ref_count);
endtask

virtual task start();
fork
begin
forever
begin
wrmon2rm.get(wdata);
count_mod(wdata);
wdata.count=ref_count;
rm2sb.put(wdata);
end
end
join_none
endtask



endclass
