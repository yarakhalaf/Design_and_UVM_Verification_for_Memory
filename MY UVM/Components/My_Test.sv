class test extends uvm_test ;

`uvm_component_utils (test)

environment environment_1 ;
sequencee sequencee_1 ;

virtual intf my_vif;

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;
environment_1 = environment::type_id::create("environment_1",this);
sequencee_1 = sequencee::type_id::create("sequencee_1",this);

void' ( uvm_config_db #(virtual intf) :: get (this,"" , "vif" ,my_vif));
uvm_config_db #(virtual intf) :: set (this,"environment_1" , "vif" ,my_vif);

$display("build test");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);

$display("connect test");
endfunction

function new(string name = "test" , uvm_component parent);
super.new(name,parent);
endfunction

task run_phase (uvm_phase phase) ;
super.run_phase(phase);
phase.raise_objection(this);
my_vif.reset () ;
sequencee_1.start(environment_1.agent_1.sequencer_1);
phase.drop_objection(this);

$display("Run Test");
endtask

endclass