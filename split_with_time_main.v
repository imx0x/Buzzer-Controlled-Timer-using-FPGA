module sevseg(o1,o2,o3,o4,b,clk,i,reset,stop);

output reg[6:0] o1,o2,o3,o4;
output reg[1:0] b;
output  reg i;
input stop,reset;

input clk;



reg [3:0] x1,x2,x3,x4;
reg [28:0] i1,i3,i2,i4;




always @(posedge clk)
begin
	if(reset==1'b1)
		begin
		x1<=0;
		
		i1<=0;
		
		end
	
	
	else if(stop==1'b1)
	begin
		i1<=i1;	
	end
	else
	begin
		if(i1==26'h7A120)//5* 10^5
			begin
				if(x1!=9)
				begin
					x1<=x1+1;
					i1<=0;
				end
				else
					begin
					x1<=0;
					i1<=0;
					end
			end
			
			
		else
			i1<=i1+1;
	end
end







always @(posedge clk)

begin

	if(reset==1'b1)
		begin
		x2<=0;
		
		i2<=0;
		
		end
	
	
	else if(stop==1'b1)
	begin
		i2<=i2;	
	end
	else
		begin
		if(i2==29'h4C4B40)//5*10^4
		begin
			if(x2!=9)
			begin
				x2<=x2+1;
				i2<=0;
			end
			else
			begin
				x2<=0;
				i2<=0;
			end
		end
		else
			i2<=i2+1;
	end
end


always @(posedge clk) 
	begin
		i<=1'b0;
	end

always @(posedge clk) //for LSS 
	begin
if(reset==1'b1)
		begin
		x3<=0;
		
		i3<=0;
		
		end
	
	
	else if(stop==1'b1)
	begin
		i3<=i3;	
	end
	else
		begin 
		
		if(i3== 26'h2faf080) //when i3 reaches 50M 
			
			begin
				
				if(x3!=9) 
					begin
						x3<= x3+1; //LSS of second gets incremented by 1 
						i3<=0; //i3 is reset
					end 
					
				else
					begin
						x3<=0; // LSS is zero if it is currently 9
						i3<=0; // i3 is reset
					end 
					
			end 
			
		else 
			i3<=i3+1; //i3 keeps incrementing till it reaches 50M
	end
end



always @(posedge clk) //for MSS
		
begin 
	if(reset==1'b1)
		begin
		x4<=0;
		
		i4<=0;
		
		end
	
	
	else if(stop==1'b1)
	begin
		i4<=i4;	
	end
	else
		begin
			
			if(i4== 29'h1dcd6500) //to create 10s we need to multiply 50M*10. If condition true, execution happens.
			
				begin 
					
					if(x4!=5) //if MSS isn't 5 it is incremented by 1
						
						begin 
							x4<=x4+1; 
							i4<=0; //i4 is reset 
						end
					else
						
						begin 
							x4<=0; //if MSS 5 then it should come back to zero?
							i4<=0; 
						end 
				end 
			
			else 
			i4<=i4+1; //i4 keeps incrementing till it reaches 50M *10
		end
	end

	











always @(x1)
	case(x1)
		4'h0:o1<=7'b1000000;
		4'h1:o1<=7'b1111001;
		4'h2:o1<=7'b0100100;
		4'h3:o1<=7'b0110000;
		4'h4:o1<=7'b0011001;
		4'h5:o1<=7'b0010010;
		4'h6:o1<=7'b0000010;
		4'h7:o1<=7'b1111000;
		4'h8:o1<=7'b0000000;
		4'h9:o1<=7'b0010000;
	default:o1<=7'b0000000;
	endcase
	
	



always @(x2)
	case(x2)
		4'h0:o2<=7'b1000000;
		4'h1:o2<=7'b1111001;
		4'h2:o2<=7'b0100100;
		4'h3:o2<=7'b0110000;
		4'h4:o2<=7'b0011001;
		4'h5:o2<=7'b0010010;
		4'h6:o2<=7'b0000010;
		4'h7:o2<=7'b1111000;
		4'h8:o2<=7'b0000000;
		4'h9:o2<=7'b0010000;
	default:o2<=7'b0000000;
	endcase
	
	
	
always @(x3) //to assign LSS output to seven segment display
		
		case(x3)
			
			4'h0: o3<=7'b1000000;
			4'h1: o3<=7'b1111001;
			4'h2: o3<=7'b0100100;
			4'h3: o3<=7'b0110000;
			4'h4: o3<=7'b0011001;
			4'h5: o3<=7'b0010010;
			4'h6: o3<=7'b0000010;
			4'h7: o3<=7'b1111000;
			4'h8: o3<=7'b0000000;
			4'h9: o3<=7'b0010000;
			default: o3<= 7'b1111111; //if anylogical error we can identify easily
		
		endcase
			
always @(x4) //to assign MSS output to 7 segment display
		
		case(x4)
			
			4'h0: o4 <= 7'b1000000;
			4'h1: o4 <= 7'b1111001;
			4'h2: o4 <= 7'b0100100;
			4'h3: o4 <= 7'b0110000;
			4'h4: o4 <= 7'b0011001;
			4'h5: o4 <= 7'b0010010; //only 5 because it is a 60s counter and it rolls back to 0 if its 60s
			
			default: o4 <= 7'b1111111;
		
		endcase
		
always @(posedge clk)
	
	begin
		if(x3==9 && x4==5)
			begin
				b[1]<=1'b1;
				b[0]<=1'b0;
			end
		
		else 
				begin
				   b[1]<=1'b0;
					b[0]<=1'b0;
				end 
	end
	
	
endmodule









	

	
	

	
	
			
	


