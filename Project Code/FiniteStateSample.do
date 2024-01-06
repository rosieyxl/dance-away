vlib work

vlog FiniteStateSample.v
vlog DifficultySelector.v
vlog SongSelector.v
vlog Gameplay.v

vsim FiniteStateSample

log {/*}
add wave {/*}

force {clk} 0 0ns, 1 {5ns} -r 10ns

force btn_up 0
force btn_down 0
force btn_left 0
force btn_right 0

force rst 1
run 5ns

force rst 0
run 5 ns

force btn_left 1
run 5 ns

force btn_left 0
run 20 ns

# Difficulty


force btn_right 1
run 30 ns

force btn_right 0
run 30 ns


force btn_left 1
run 10 ns

force btn_left 0
run 10 ns

force btn_down 1
run 10 ns

force btn_down 0
run 40 ns

force btn_right 1
run 30 ns

force btn_right 0
run 30 ns


force btn_left 1
run 10 ns

force btn_left 0
run 30 ns

# Gameplay

force btn_down 1
run 30 ns

force btn_down 0
run 10 ns
