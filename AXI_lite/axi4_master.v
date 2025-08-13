`timescale 1ns/1ns

module axi4 #(parameter N = 32)(CLK,R,awvalid,awready,awaddr,wready,wvalid,wdata,bvalid,bready,addr,data,start,done);
input wire CLK; input wire R;

//-----------------------signals-----------------------

input wire awready;		//AXI write address
output reg awvalid;
output reg [N-1:0] awaddr;

input wire wready;		//AXi write Data
output reg wvalid;
output reg [N-1:0] wdata;

input wire bvalid; output reg bready;  		//AXi response

input wire [N-1:0] addr;	//AXi control
input wire [N-1:0] data;
input wire start;
output reg done;		
//------------------------STATEs---------------

reg [1:0] state;
localparam RESET=2'b00, ADDRS=2'b01, DATA=2'b10, RESPO=2'b11;

always@(posedge CLK or posedge R)
begin
if(R)begin
	awaddr <= N-1'b0;
	awvalid <= 1'b0;
	wdata <= N-1'b0; 
	bready <= 1'b0;
	done <= 1'b0;
	state <= RESET;
     end
else begin
case(state)
RESET:  begin
	done<=1'b0;
	if(start)begin
		 awaddr <= addr;
		 awvalid <= 1'b1;
		 state <= ADDRS;
		 end
	end
ADDRS:  begin
	if(awready) begin
		    awvalid <= 1'b0;
		    wdata <= data;
		    wvalid <= 1'b1;
		    state <= DATA;
		    end	
	end
DATA:   begin
	if(wready)begin
		  wvalid<=1'b0;
		  bready<=1'b1;
		  state<= RESPO;
		  end	
	end

RESPO:  begin
	if(bvalid)begin
		  bready <= 1'b0;
		  done <= 1'b1;
		  state <= RESET;
		  end
	end
default: state<= RESET;
endcase
     end	

end 
endmodule























