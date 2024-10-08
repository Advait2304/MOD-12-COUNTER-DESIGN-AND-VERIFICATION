`timescale 1ns / 1ps

class transaction;
rand logic [3:0]Din;
rand logic load;
rand logic up_down;
logic [3:0] count;
rand logic rst;

constraint C1{Din inside{[2:8]};}
constraint C2{load dist{1:=30,0:=70};}
constraint C3{up_down dist{1:=50,0:=50};}
constraint C4{rst dist{1:=10,0:=90};}

virtual function void display(input string s);
begin
$display("...............%S................",s);
$display("UP_DOWN=%d",up_down);
$display("load=%d",load);
$display("Din=%d",Din);
$display("count=%d",count);
$display("rst=%d",rst);
$display("...................................");
end
endfunction
endclass

