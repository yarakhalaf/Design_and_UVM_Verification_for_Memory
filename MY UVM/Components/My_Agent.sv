class agent extends uvm_agent ;

`uvm_component_utils (agent)

sequencer sequencer_1 ;
monitor monitor_1 ;
driver driver_1 ;

virtual intf my_vif ;

uvm_analysis_port #(sequence_item) analysis_port ;

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;
sequencer_1 = sequencer::type_id::create("sequencer_1",this);
monitor_1 = monitor::type_id::create("monitor_1",this);
driver_1 = driver::type_id::create("driver_1",this);

void' (uvm_config_db #(virtual intf) :: get (this,"" , "vif" ,my_vif));
uvm_config_db #(virtual intf) :: set (this,"monitor_1" , "vif" ,my_vif);
uvm_config_db #(virtual intf) :: set (this,"driver_1" , "vif" ,my_vif);

analysis_port = new("analysis_port",this);

$display("build Agent");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);
monitor_1.analysis_port.connect(analysis_port);
driver_1.seq_item_port.connect(sequencer_1.seq_item_export) ;

$display("connect Agent");
endfunction

function new(string name = "agent" , uvm_component parent);
super.new(name,parent);
endfunction

task run_phase (uvm_phase phase) ;
super.run_phase(phase);
$display("Run Agent");
endtask

endclass
