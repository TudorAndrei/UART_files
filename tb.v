module tb();


reg clk = 0;
reg [7:0] val = 8'b11010101;
reg start;
wire [7:0] rec_out;
wire data_ready;
reg rst;
wire t_to_r;

always
begin
#2 clk = ~clk;
end

transmiter trans0
(
	.data_in(val),
	.start(start),
	.reset(rst),
	.clk(clk),
	.tx(t_to_r)
);

UART_Receiver rec0
(
	.data_ready(data_ready),
	.data(rec_out),
	.rx(t_to_r),
	.rst(rst),
	.clk(clk)
);

initial
begin
#10000000 $stop;
end

initial
begin
#100 rst <= 1;
#100 rst <= 0;
#10 start <= 1;
#10 start <= 0;
end 

endmodule