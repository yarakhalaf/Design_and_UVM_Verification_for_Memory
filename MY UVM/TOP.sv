module TOP ;

import uvm_pkg ::* ;
import My_Package::*;


intf intf1 () ;


memory_16x32  dut (
.clk(intf1.clk),
.renable(intf1.renable),   
.wenable(intf1.wenable),
.rst(intf1.rst),  
.addr(intf1.addr),
.data_in(intf1.data_in),
.data_out(intf1.data_out),
.valid_out(intf1.valid_out) );

initial begin

uvm_config_db #(virtual intf) :: set (null,"uvm_test_top" , "vif" ,intf1);

run_test ("test");
 $display("top module");

end


endmodule






