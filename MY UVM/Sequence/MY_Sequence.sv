
class sequencee extends uvm_sequence  ;

`uvm_object_utils (sequencee)
sequence_item seq_item;

task pre_body ;
seq_item = sequence_item::type_id::create("seq_item");
endtask

task body ;


$display("start of body task") ;

/////////////////////////////WRITE CASE////////////////////////
for (int i = 0 ; i < 16 ; i++) begin
start_item(seq_item);
$display("start of write case") ;
seq_item.rst = 1'b1 ;
seq_item.renable = 1'b0 ;
seq_item.wenable = 1'b1 ;
void'(seq_item.randomize() );
finish_item(seq_item); end
///////////////////////////////////////////////////////////////

/////////////////////////////READ CASE/////////////////////////
for (int i = 0 ; i < 16 ; i++) begin
start_item(seq_item);
$display("start of read case") ;
seq_item.rst = 1'b1 ;
seq_item.renable = 1'b1 ;
seq_item.wenable = 1'b0 ;
void'(seq_item.randomize() );
finish_item(seq_item); end
///////////////////////////////////////////////////////////////

endtask

function new(string name = "sequencee");
super.new(name);
endfunction

endclass
