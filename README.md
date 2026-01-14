# Single-Cycle RISC-V Processor (RV32I Subset)

## Overview
This repository contains a **single-cycle RISC-V processor** implemented in **Verilog HDL**, supporting a subset of the **RV32I ISA**.  
Each instruction completes execution in **one clock cycle**, following a classic RISC datapath.

The design is modular, readable, and suitable for **RTL & Synthesis & Physical Design (PD)** flow.

---

## Supported Instructions (RV32I Subset)

### R-Type
- `add`
- `sub`
- `and`
- `or`
- `xor`
- `slt`

### I-Type
- `addi`
- `lw`

### S-Type
- `sw`

---

## Architecture

- **Processor Type**: Single-Cycle RISC-V CPU  
- **Execution Model**: One instruction per clock cycle  
- **Control Style**: Single main control unit  
- **Datapath**: Classic RISC datapath (Fetch ? Decode ? Execute ? Memory ? Write-back)

---

## Modules

| Module | Description |
|------|------------|
| `program_counter.v` | Program Counter logic |
| `inst_mem.v` | Instruction memory |
| `decoder.v` | Instruction field extraction |
| `control.v` | Control signal generation |
| `gpr.v` | 32×32 General Purpose Register File |
| `imm_gen.v` | Immediate sign extension |
| `alu_operand_mux.v` | ALU operand selection |
| `alu.v` | Arithmetic Logic Unit |
| `data_mem.v` | Data memory for LW / SW |
| `wb_mux.v` | Write-back mux |
| `top.v` | Top-level integration |
| `top_tb.v` | Testbench (simulation only) |

---


---

## Timing Model

- Single-cycle execution
- No pipelining
- No hazard detection
- Suitable for learning and front-end VLSI design practice

---

## Simulation Notes

- Instruction execution is controlled using an **instruction counter** in the testbench.
- PC wrap-around is avoided at the testbench level.
- Register file and data memory contents are dumped after execution for verification.

### Simulation-only system tasks:
```verilog
$readmemh
$writememh
$display
```
## How to run
irun -access +rwc -clean -top top_tb *.v

## Repository structure
+-- alu.v
+-- control.v
+-- decoder.v
+-- imm_gen.v
+-- alu_operand_mux.v
+-- wb_mux.v
+-- gpr.v
+-- data_mem.v
+-- inst_mem.v
+-- program_counter.v
+-- top.v
+-- top_tb.v
+-- gpr.hex        // simulation only
+-- data_mem.hex   // simulation only
+-- README.md


## Future Work

- Add branch instructions (B-type)
- Pipelined version
- Hazard detection and forwarding
- Cache integration
- Full RTL to GDSII flow

## Author

- Vinayak Venkappa Pujeri
- Final-Year ECE Student | VLSI Front-End & Digital Design
- Focus: RISC-V, Processor Architecture, Low-Power VLSI
