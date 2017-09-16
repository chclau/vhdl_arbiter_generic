onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_arb_gen/arb_inst/clk
add wave -noupdate /tb_arb_gen/arb_inst/gnt
add wave -noupdate /tb_arb_gen/arb_inst/req
add wave -noupdate /tb_arb_gen/arb_inst/rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
configure wave -timelineunits us
update
WaveRestoreZoom {904772 ps} {910276 ps}
