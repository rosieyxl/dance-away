# Create a new work library
vlib work

# Compile the Verilog files
vlog PulseGenerator.v

# Start simulation
vsim PulseGenerator

# Configure simulation logs and waves
log {/*}
add wave {/*}

# Force initial values
force {clk} 0 0ns, 1 {5ns} -r 10ns
force signal 0
run 10ns

# Release reset
force signal 1
run 100 ns

# Release reset
force signal 0
run 100 ns


# Release reset
force signal 1
run 100 ns

# Release reset
force signal 0
run 100 ns

