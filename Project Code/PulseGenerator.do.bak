# Create a new work library
vlib work

# Compile the Verilog files
vlog DifficultySelector.v

# Start simulation
vsim DifficultySelector

# Configure simulation logs and waves
log {/*}
add wave {/*}

# Force initial values
force {clk} 0 0ns, 1 {5ns} -r 10ns
force btn_up 0
force btn_down 0
force btn_left 0
force btn_right 0
force enable 0
force rst 1
run 10ns

# Release reset
force rst 0
force enable 1
run 10ns

# Simulate btn_left press and release
force btn_left 1
run 10ns
force btn_left 0
run 20ns

# Simulate right press and release
force btn_right 1
run 10ns
force btn_right 0
run 30ns

# Simulate right press and release
force btn_right 1
run 10ns
force btn_right 0
run 30ns

force enable 0

# Simulate btn_left press and release
force btn_left 1
run 10ns
force btn_left 0
run 30ns

force enable 1

# Simulate btn_left press and release
force btn_left 1
run 10ns
force btn_left 0
run 30ns

# Simulate right press and release
force btn_right 1
run 10ns
force btn_right 0
run 30ns

