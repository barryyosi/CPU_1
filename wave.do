onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/x
add wave -noupdate /tb/y
add wave -noupdate /tb/s
add wave -noupdate /tb/sub
add wave -noupdate /tb/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {37548 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {12 ns} {140 ns}
