class driver extends uvm_driver #(sequence_item ) ;

`uvm_component_utils (driver)
sequence_item seq_item ;

virtual intf my_vif;

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;
seq_item = sequence_item::type_id::create("seq_item");

void' (uvm_config_db #(virtual intf) :: get (this,"" , "vif" ,my_vif));

$display("build driver");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);
$display("connect driver");
endfunction

function new(string name = "driver" , uvm_component parent);
super.new(name,parent);
endfunction

task run_phase (uvm_phase phase) ;
super.run_phase(phase);
forever begin
    seq_item_port.get_next_item(seq_item);
    $display ("driver item = %p" , seq_item );
    drive(seq_item);
    #1step seq_item_port.item_done();
end
$display("Run driver");
endtask

task drive(sequence_item seq_item);
    @(posedge my_vif.clk);
      my_vif.rst      <= seq_item.rst ;
      my_vif.renable  <= seq_item.renable ;
      my_vif.wenable  <= seq_item.wenable ;
      my_vif.data_in  <= seq_item.data_in ;
      my_vif.addr     <= seq_item.addr ;
      #1step$display ("driver data in = %p" , my_vif.data_in );

endtask

endclass
