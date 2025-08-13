`timescale 1ns/1ns

module axi4_slave#(parameter N=32)(
//--------------------------signals----------------------
input wire CLK, input wire R,

input wire [N-1:0]awaddr,		//AXi read address
input wire awvalid,
output reg awready,

input wire[N-1:0] wdata,		//AXi read data
input wire wvalid,
output reg wready,

input wire bready,			//Axi read resposne
output reg bvalid,

output reg [N-1:0] addr,		//memeory inteface
output reg [N-1:0] data,
output reg mem_write_en		);

//-------------------------STATEs-----------------------------

reg [1:0] state;
localparam RESET=2'b00,ADDRS=2'b01,DATA=2'b10,RESPO=2'b11;

always@(posedge CLK or posedge R)
begin
if(R) begin
	awready<=1'b0;
	wready<=1'b0;
	bvalid<=1'b0;
	mem_write_en<=1'b0;
	state<=RESET;
      end
else begin
case(state)
RESET:	begin
	if(awvalid)begin
			awready<=1'b1;
			state<=ADDRS;
		   end	
	end	
ADDRS:  begin
	if(awvalid && awready)begin
				awready<=1'b0;
				addr<=awaddr;
				wready<=1'b1;
				state<= DATA;
			     end
	end
DATA:   begin
	if(wvalid && wready)begin
				data<=wdata;
				mem_write_en<=1'b1;
				wready<=1'b0;
				bvalid<=1'b1;
				state<=RESPO;				
			    end
	end
RESPO:  begin
	mem_write_en<=1'b0;	
	if(bready)      begin
			bvalid<=1'b0;
			state<=RESET;
			end
	end
default:state<= RESET;
endcase
     end
end

endmodule
