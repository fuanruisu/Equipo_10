module SL2Pad(
input [3:0] MSBAd,
input [25:0] offset,
output [31:0] offsetpad
);


assign offsetpad = {MSBAd,offset,2'b00};


endmodule 