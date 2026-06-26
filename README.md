#Dual-Port RAM in Verilog
A synthesizable, high-performance **Dual-Port RAM** core designed in Verilog. This module supports completely independent concurrent read and write operations across two separate ports (Port A and Port B) sharing a single clock domain. 
The design is optimized for FPGA synthesis and includes a time-accurate, self-checking testbench modeled in picosecond (`ps`) resolution for waveform verification.
 🚀 Key Features
True Dual-Port Functionality:Dual independent address, data input, data output, and write enable channels.
Memory Architecture: Parameters configured for an 8-bit word width and a 64-word depth ($64 \times 8$-bit memory space).
Write-First / New-Data Mode: Synced directly to the rising clock edge (`posedge clk`). The design naturally maps to dedicated FPGA Block RAM (BRAM) primitives during synthesis.
Robust Verification:Testbench covers simultaneous cross-port access, multi-port reading/writing, and address collision simulation behavior.
📂 Project Structure
├── dual_port_ram.v     # Core True Dual-Port RAM hardware design module
├── dual_port_ram_tb.v  # Time-accurate validation testbench (Picosecond timescale)
└── README.md           # Documentation
1. Compile the Source Code
Open your terminal inside the project directory and run:
iverilog -o sim.vvp dual_port_ram_tb.v dual_port_ram.v
2. Execute the Simulation Runtime
Run the compiled design binary file using the VVP simulator engine:
vvp sim.vvp
3. View Waveforms in GTKWave
Open the VCD file to visualize the signal timelines:
gtkwave dump.vcd
