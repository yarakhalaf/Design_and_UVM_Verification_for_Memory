class sequence_item extends uvm_sequence_item;

`uvm_object_utils(sequence_item)

         logic        renable;
         logic        wenable ;
         logic        rst ;
 randc   logic [ 3:0] addr;
 randc   logic [31:0] data_in;      
         logic [31:0] data_out;
         logic        valid_out;


function new(string name = "sequence_item");
super.new(name);
endfunction

endclass 
