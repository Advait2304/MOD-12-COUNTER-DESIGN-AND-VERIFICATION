`timescale 1ns / 1ps

class scoreboard;
event DONE;
transaction r_data,sb_data,cov_data;

int ref_data,rm_data,data_verified;

mailbox #(transaction) ref2sb;
mailbox #(transaction) rdm2sb;



function new(mailbox #(transaction) ref2sb,mailbox#(transaction) rdm2sb);
this.ref2sb=ref2sb;
this.rdm2sb=rdm2sb;

endfunction

virtual task check(transaction rdata);
   if(r_data.count==rdata.count)
   $display("Count Matches");
   else 
   $display("Count does not match");
data_verified++;
$display("Data verified %d",data_verified);
if(data_verified>=no_of_transaction)
begin
->DONE;
end                       
endtask

virtual task start();
fork
forever
begin
ref2sb.get(r_data);
ref_data++;

rdm2sb.get(sb_data);
rm_data++;
check(sb_data);
end
join_none
endtask


virtual function void report();
$display("..................SCOREBOARD.............");
$display("Data_expected =%d Data_GENERATED=%d Data_verified=%d",ref_data,rm_data,data_verified);
$display("..........................................");
endfunction

endclass





