onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Control_Unit_TB/Core1/clk
add wave -noupdate -radix hexadecimal /Control_Unit_TB/ALUOutput_tb
add wave -noupdate -radix hexadecimal /Control_Unit_TB/Core1/D1/RegF1/q9
add wave -noupdate -radix hexadecimal /Control_Unit_TB/Core1/D1/RegF1/q10
add wave -noupdate -radix hexadecimal /Control_Unit_TB/Core1/D1/RegF1/q11
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/clk
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/RegWrite
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/Opcode
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/ALUOp
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/ALUControl
add wave -noupdate -expand -group DataPath -color Orange /Control_Unit_TB/Core1/D1/clk
add wave -noupdate -expand -group DataPath -color Aquamarine /Control_Unit_TB/Core1/D1/PC
add wave -noupdate -expand -group DataPath /Control_Unit_TB/Core1/D1/PC1/enable
add wave -noupdate -expand -group DataPath -color Orange /Control_Unit_TB/Core1/D1/SrcB
add wave -noupdate -expand -group DataPath -color Orange /Control_Unit_TB/Core1/D1/SrcA
add wave -noupdate -expand -group DataPath -color Orange /Control_Unit_TB/Core1/D1/ALUResult
add wave -noupdate -expand -group ProramMemory -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/clk
add wave -noupdate -expand -group ProramMemory -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/enable
add wave -noupdate -expand -group ProramMemory -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/rst
add wave -noupdate -expand -group ProramMemory -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/Addr_i
add wave -noupdate -expand -group TB /Control_Unit_TB/clk_tb
add wave -noupdate -expand -group TB /Control_Unit_TB/rst_tb
add wave -noupdate -expand -group TB /Control_Unit_TB/clk_o
add wave -noupdate -expand -group TB /Control_Unit_TB/en_tb
add wave -noupdate -expand -group TB /Control_Unit_TB/ALUOutput_tb
add wave -noupdate -expand -group TB /Control_Unit_TB/GPIO_i_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {450 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {449 ps} {503 ps}
