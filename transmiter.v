module transmiter
(
	input [7:0] data_in,
	input start,
	input reset,
	input clk,
	output reg tx
);

reg [4:0] state;
reg [15 : 0] counting_register ;

always@(posedge clk)
begin
	if (reset == 1)
		begin
		state <= 0;
		counting_register <= 0;
		end
	else begin
		case (state)
		0:	//idle state
			begin
			tx <= 1;
			if(start == 1)
				begin
				state <= state +1;
				counting_register <= 0;
				end
			end//end idle state 
		1:		//start bit
			begin
			tx <= 0;
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end //end start bit
		2 : 
			//lsb
			begin
			tx <= data_in[0];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
		3 : 
			//2nd bit
			begin
			tx <= data_in[1];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			4 : 
			//3rd bit
			begin
			tx <= data_in[2];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			5 : 
			//4th bit
			begin
			tx <= data_in[3];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			6 : 
			//5th bit
			begin
			tx <= data_in[4];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			7 : 
			//6th bit
			begin
			tx <= data_in[5];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			8 : 
			//7th bit
			begin
			tx <= data_in[6];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			9 : 
			//msb
			begin
			tx <= data_in[7];
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= state +1;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
			10 : 
			//end 
			begin
			tx <= 1;
			if(counting_register >= 5200)
				begin
				counting_register <= 0;
				state <= 0;
				end
			else
				begin
				counting_register <= counting_register + 1;
				end 
			end 
			
		default: state <= 0;
		endcase
	end 
	

end 

endmodule 