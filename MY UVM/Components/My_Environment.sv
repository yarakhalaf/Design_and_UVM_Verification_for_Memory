class environment extends uvm_env ;

`uvm_component_utils (environment)

agent agent_1 ;
subscriber subscriber_1 ;
scoreboard scoreboard_1 ;

virtual intf my_vif ;

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;
agent_1 = agent::type_id::create("agent_1",this);
subscriber_1 = subscriber::type_id::create("subscriber_1",this);
scoreboard_1 = scoreboard::type_id::create("scoreboard_1",this);

void' (uvm_config_db #(virtual intf) :: get (this,"" , "vif" ,my_vif));
uvm_config_db #(virtual intf) :: set (this,"agent_1" , "vif" ,my_vif);

$display("build environment");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);

agent_1.analysis_port.connect(scoreboard_1.analysis_export);
agent_1.analysis_port.connect(subscriber_1.analysis_export);

$display("connect environment");
endfunction

function new(string name = "environment" , uvm_component parent);
super.new(name,parent);
endfunction


task run_phase (uvm_phase phase) ;
super.run_phase(phase);
$display("Run Environment");
endtask

endclass
