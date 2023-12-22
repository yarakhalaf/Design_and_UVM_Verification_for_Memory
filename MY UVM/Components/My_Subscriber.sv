class subscriber extends uvm_subscriber #(sequence_item) ;

`uvm_component_utils (subscriber)
sequence_item seq_item;

//uvm_analysis_imp #(sequence_item,subscriber) analysis_import ;

covergroup group1 ;
RESET        :coverpoint seq_item.rst ;
READ_ENABLE  :coverpoint seq_item.renable ;
WRITE_ENABLE :coverpoint seq_item.wenable ;
ADDREES      :coverpoint seq_item.addr ;
INPUT_DATA   :coverpoint seq_item.data_in ;
//OUTPUT_DATA  :coverpoint seq_item.data_out ;
//VALID        :coverpoint seq_item.valid_out ;
endgroup

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;
seq_item = sequence_item::type_id::create("seq_item");
$display("build subscriber");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);
$display("connect subscriber");
endfunction

function void write (sequence_item t);
seq_item = t ;
$display("subscriber addr = %p" , t.addr);
group1.sample() ;
endfunction

function new(string name = "subscriber" , uvm_component parent);
super.new(name,parent);
group1 = new() ;
endfunction

task run_phase (uvm_phase phase) ;
super.run_phase(phase);
$display("Run subscriber");
endtask

endclass