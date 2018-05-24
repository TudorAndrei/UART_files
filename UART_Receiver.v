`define STATE_IDLE 0
`define STATE_START 1
`define STATE_BIT0 2
`define STATE_BIT1 3
`define STATE_BIT2 4
`define STATE_BIT3 5
`define STATE_BIT4 6
`define STATE_BIT5 7
`define STATE_BIT6 8
`define STATE_BIT7 9
`define STATE_STOP 10


module UART_Receiver
#(
	parameter BAUD_RATE = 9600,
	parameter DATA_WIDTH = 8 //kinda useless
)
(
	output data_ready,
	output reg [DATA_WIDTH-1:0] data,
	input rx,
	input rst,
	input clk
);

//50M clock
localparam integer limit = 5e7/BAUD_RATE;

reg data_ready_reg = 0;
assign data_ready = data_ready_reg;

reg [12:0] counter = 0;
reg [3:0] state = `STATE_IDLE;
reg [DATA_WIDTH-1:0] data_reg = 0;

always@(posedge clk) begin
	if (rst) begin
		counter <= 0;
		state <= `STATE_IDLE;
		data_reg <= 0;
		data_ready_reg <= 0;
	end
	else begin
		case(state)
			`STATE_IDLE: begin
				data_ready_reg <= 0;
				if (counter > limit) begin
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						if (rx == 0) //start bit
							state <= state + 1;
					
					counter <= counter + 1;
				end
			end
			`STATE_START: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else
					counter <= counter + 1;
			end
			
			`STATE_BIT0: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[0] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT1: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[1] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT2: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[2] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT3: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[3] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT4: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[4] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT5: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[5] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT6: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[6] <= rx;
					counter <= counter + 1;
				end
			end
			
			`STATE_BIT7: begin
				if (counter > limit) begin
					state <= state + 1;
					counter <= 0;		
				end
				else begin
					if (counter == (limit/2))
						data_reg[7] <= rx;
					counter <= counter + 1;
				end
			end
				
			`STATE_STOP: begin
				if (counter > limit) begin
					data_ready_reg <= 1;
					data <= data_reg;
					state <= 0;
				else
					counter <= counter + 1;
				end
			end
		endcase
	end
end

endmodule