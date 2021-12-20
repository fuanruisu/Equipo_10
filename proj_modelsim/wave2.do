onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Control_Unit_TB/Core1/clk
add wave -noupdate -radix hexadecimal /Control_Unit_TB/ALUOutput_tb
add wave -noupdate -radix hexadecimal /Control_Unit_TB/Core1/D1/RegF1/q9
add wave -noupdate -radix hexadecimal /Control_Unit_TB/Core1/D1/RegF1/q10
add wave -noupdate -radix hexadecimal /Control_Unit_TB/Core1/D1/RegF1/q11
add wave -noupdate -group TB /Control_Unit_TB/clk_tb
add wave -noupdate -group TB /Control_Unit_TB/rst_tb
add wave -noupdate -group TB /Control_Unit_TB/clk_o
add wave -noupdate -group TB -radix hexadecimal /Control_Unit_TB/ALUOutput_tb
add wave -noupdate -group TB -radix unsigned /Control_Unit_TB/GPIO_i_tb
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/clk
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/RegWrite
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/Opcode
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/ALUOp
add wave -noupdate -expand -group Control -color Yellow /Control_Unit_TB/Core1/CU1/ALUControl
add wave -noupdate /Control_Unit_TB/Core1/CU1/MainControl1/Ori
add wave -noupdate -expand -group ProramCounter -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/clk
add wave -noupdate -expand -group ProramCounter -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/enable
add wave -noupdate -expand -group ProramCounter -color {Cornflower Blue} /Control_Unit_TB/Core1/D1/PC1/rst
add wave -noupdate -expand -group ProramCounter -color {Cornflower Blue} -radix hexadecimal /Control_Unit_TB/Core1/D1/PC1/Addr_i
add wave -noupdate -expand -group ProramCounter /Control_Unit_TB/Core1/D1/PC1/Addr_o
add wave -noupdate -expand -group ROM -color {Medium Orchid} /Control_Unit_TB/Core1/D1/Mem1/ROM1/Instruction_o
add wave -noupdate -expand -group ROM /Control_Unit_TB/Core1/D1/Mem1/ROM1/Address_i
add wave -noupdate -expand -group RegisterFile /Control_Unit_TB/Core1/D1/RegF1/Read_Data_1_o
add wave -noupdate -expand -group RegisterFile /Control_Unit_TB/Core1/D1/RegF1/Read_Data_2_o
add wave -noupdate -expand -group DataPath -color Orange /Control_Unit_TB/Core1/D1/clk
add wave -noupdate -expand -group DataPath -color Aquamarine -radix hexadecimal /Control_Unit_TB/Core1/D1/PC
add wave -noupdate -expand -group DataPath /Control_Unit_TB/Core1/D1/PC1/enable
add wave -noupdate -expand -group DataPath -expand -group GPIO_IMM /Control_Unit_TB/Core1/D1/Ori
add wave -noupdate -expand -group DataPath -expand -group GPIO_IMM /Control_Unit_TB/Core1/D1/M3_1/sel
add wave -noupdate -expand -group DataPath -expand -group GPIO_IMM /Control_Unit_TB/Core1/D1/M3_1/in1
add wave -noupdate -expand -group DataPath -expand -group GPIO_IMM /Control_Unit_TB/Core1/D1/M3_1/in2
add wave -noupdate -expand -group DataPath -expand -group GPIO_IMM /Control_Unit_TB/Core1/D1/M3_1/regOut
add wave -noupdate -expand -group DataPath -expand -group SignEx /Control_Unit_TB/Core1/D1/SignExt/Imm
add wave -noupdate -expand -group DataPath -expand -group SignEx /Control_Unit_TB/Core1/D1/SignExt/SignExtImm
add wave -noupdate -expand -group DataPath -expand -group ALU -color Orange -radix hexadecimal /Control_Unit_TB/Core1/D1/SrcA
add wave -noupdate -expand -group DataPath -expand -group ALU -color Orange -radix hexadecimal /Control_Unit_TB/Core1/D1/SrcB
add wave -noupdate -expand -group DataPath -expand -group ALU -color Orange -radix hexadecimal /Control_Unit_TB/Core1/D1/ALUResult
add wave -noupdate -expand -group ALU -radix hexadecimal /Control_Unit_TB/Core1/D1/ALU1/y
add wave -noupdate -expand -group ALU /Control_Unit_TB/Core1/D1/ALU1/a
add wave -noupdate -expand -group ALU /Control_Unit_TB/Core1/D1/ALU1/b
add wave -noupdate -expand -group ALU -color {Medium Orchid} /Control_Unit_TB/Core1/D1/ALU1/select
add wave -noupdate -expand -group ALU /Control_Unit_TB/Core1/D1/ALU1/PC
add wave -noupdate -expand -group ALU /Control_Unit_TB/Core1/D1/ALU1/Imm
add wave -noupdate -expand -group ALU /Control_Unit_TB/Core1/D1/ALU1/PC4
add wave -noupdate -expand -group ALU /Control_Unit_TB/Core1/D1/ALU1/branchAddress
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {411 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 176
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
WaveRestoreZoom {405 ps} {440 ps}
