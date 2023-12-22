class scoreboard extends uvm_scoreboard ;

`uvm_component_utils (scoreboard)

sequence_item seq_item ;

uvm_tlm_analysis_fifo #(sequence_item) analysis_fifo ;
uvm_analysis_export #(sequence_item) analysis_export ;
 
logic [31:0] write_item [16] ; 

function void build_phase(uvm_phase phase);
super.build_phase(phase) ;

analysis_fifo = new("analysis_fifo" ,this );
analysis_export = new("analysis_export",this);

$display("build scoreboard");
endfunction

function void connect_phase (uvm_phase phase) ;
super.connect_phase(phase);
analysis_export.connect(analysis_fifo.analysis_export);

$display("connect scoreboard");
endfunction

function new(string name = "scoreboard" , uvm_component parent);
super.new(name,parent);
endfunction

task run_phase (uvm_phase phase) ;
super.run_phase(phase);
$display("Run scoreboard");

forever begin
static int q[$] ;
analysis_fifo.get_peek_export.get(seq_item);

$display("scoreboard item out = %p " , seq_item.data_out) ;
$display("scoreboard item addr = %p " , seq_item.addr) ;

`uvm_info(get_type_name(), $sformatf("q: %p" ,q) ,UVM_LOW)

if(seq_item.wenable == 1'b1) begin
  write_item[seq_item.addr] = seq_item.data_in ;
`uvm_info(get_type_name(), "scoreboard write" ,UVM_LOW)
end

else if(seq_item.renable == 1'b1) begin
  `uvm_info(get_type_name(), "scoreboard read" ,UVM_LOW)
  if(seq_item.data_out == q.pop_back())begin
    $display("scoreboard success") ;
  `uvm_info(get_type_name(), "scoreboard success" ,UVM_LOW)
  end
  else begin
    $display("actual : %h , stored: %h, address: %p", seq_item.data_out , write_item[seq_item.addr],seq_item.addr);
    $display("queue:%h",q.pop_back());
    $display("scoreboard fail") ;
    `uvm_info(get_type_name(), "scoreboard failure" ,UVM_LOW)
  end
  q.insert(0,write_item[seq_item.addr]);
end

end
endtask

endclass
