
class sequencer extends uvm_sequencer #( sequence_item  ) ;

`uvm_component_utils (sequencer)
//sequence_item seq_item ;

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;
//seq_item = sequence_item::type_id::create("seq_item");
$display("build sequencer");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);
$display("connect sequencer");
endfunction

function new(string name = "sequencer" , uvm_component parent);
super.new(name ,parent);
endfunction

task run_phase (uvm_phase phase) ;
super.run_phase(phase);
$display("Run sequencer");
endtask

endclass
