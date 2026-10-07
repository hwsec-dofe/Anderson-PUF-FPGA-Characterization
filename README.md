# Anderson-PUF-FPGA-Characterization
FPGA implementation and characterization of the Anderson Physical Unclonable Function (PUF)
## Overview
This repository contains the Verilog implementation of the Anderson PUF and the supporting files required for FPGA implementation and characterization.
The repository includes:
- 1-bit Anderson PUF implementation
- 128-bit Anderson PUF implementation
- UART communication modules
- FPGA constraint files
- Tcl scripts for controlled PUF placement
The design is implemented using Xilinx Vivado.
## Repository Structure
Anderson-PUF-FPGA-Characterization/
├── README.md
├── rtl/
│   ├── puf_1bit/
│   ├── puf_128bit/
│   └── uart/
├── constraints/
└── scripts/
    └── placement/
