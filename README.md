# 🔤 Hello Kernel: A Step-by-Step Bare Metal OS Development Journey

> Learn how to write a minimal operating system kernel from scratch using x86 Assembly and C. This project documents my personal journey into low-level systems programming, starting with zero knowledge of Assembly or OS development.

🎯 **Goal**: Build a tiny but working bootable kernel that runs directly on the CPU without any operating system.

📁 **Each commit represents a working milestone**, and once a file works, it’s never changed again. That way, you can follow along step by step without breaking anything.

---

## 📚 Table of Contents

1. [What Is This?](#what-is-this)
2. [Why Build a Kernel?](#why-build-a-kernel)
3. [Prerequisites](#prerequisites)
4. [Getting Started](#getting-started)
5. [Directory Structure](#directory-structure)
6. [Step-by-Step Learning Path](#step-by-step-learning-path)
7. [Contributing / Questions](#contributing--questions)

---

## 🧠 What Is This?

This repository contains a collection of **small, standalone, working examples** of bare-metal code written in **x86 Assembly** that boots on real or emulated hardware.

You'll start with writing a basic "Hello, World!" bootloader and progress toward more advanced topics like:

- Switching to 32-bit protected mode
- Setting up a Global Descriptor Table (GDT)
- Enabling the A20 line
- Writing basic drivers
- Calling C functions from Assembly

All of this is done **without relying on any existing OS** — just raw machine code running on QEMU or real hardware.

---

## 🤔 Why Build a Kernel?

- Understand how computers **really work**
- Learn how **bootloaders**, **BIOS interrupts**, and **CPU modes** operate
- Gain appreciation for what modern operating systems do under the hood
- Challenge yourself with low-level programming

---

## 🛠 Prerequisites

Make sure you have these installed before proceeding:

| Tool | Purpose |
|------|---------|
| [NASM](https://www.nasm.us/ ) | Assembler for converting `.asm` files into binary |
| [QEMU](https://www.qemu.org/ ) | Emulator for testing your kernel without rebooting your PC |
| Git | Version control for tracking changes |
| Basic Shell Knowledge | For compiling and running |

On macOS (with Homebrew):

```bash
brew install nasm qemu git
```

## 🚀 Getting Started
1. Clone the Repository
```bash
git clone https://github.com/your-username/hello-kernel.git 
cd hello-kernel
```
## 3. Start at Step 1
Each folder or file corresponds to a specific stage:

- step-01-hello-bootsector/hello.asm – Your first bootloader!
- step-02-print-string/print.asm – Print message using BIOS interrupt
3. Build & Run
To assemble and run the first example:

```bash

nasm step-01-hello-bootsector/hello.asm -f bin -o hello.bin
qemu-system-x86_64 -drive format=raw,file=hello.bin
```

🗂️ Directory Structure

```
hello-kernel/
├── README.md
├── step-01-hello-bootsector/
│   ├── hello.asm         # First bootloader that prints 'Hello, World!'
│   └── run.sh            # Optional script to build and run
├── step-02-print-string/
│   ├── print.asm         # Improved string printing
│   └── utils.asm         # Optional utility functions
├── step-03-protected-mode/
│   ├── pm.asm            # Code to switch to 32-bit protected mode
│   └── gdt.asm           # Global Descriptor Table setup
└── tools/
    └── Makefile          # Automate builds across steps

```


## 🧭 Step-by-Step Learning Path
Here's how you'll progress in this repo:

## ✅ Step 1: Bootloader Basics
Write a 512-byte program that boots using BIOS
Use int 0x10 to print characters
Understand memory layout and segment registers
## ✅ Step 2: String Utilities
Create reusable functions like print_string
Learn about labels, function calls, and loops
## ✅ Step 3: Stack Setup
Initialize the stack manually
Call functions safely
## ✅ Step 4: Switch to Protected Mode
Understand CPU modes (real vs protected)
Set up GDT (Global Descriptor Table)
Jump to 32-bit code
## ✅ Step 5: Call C from Assembly
Set up C runtime environment
Move logic out of Assembly into readable C
## ✅ Step 6: Load More Sectors
Go beyond 512-byte limit
Read more data from disk using int 0x13
## ✅ Step 7: Add Basic Drivers
Keyboard input
VGA text output
Timer interrupts
## 💬 Contributing / Questions
Got stuck? Want to suggest a new step? Feel free to open an issue or discussion!

If you're sharing your journey online, tag me if you'd like — I'd love to see where this takes you!

## 🎉 Final Thoughts
This isn’t just a repository — it’s a learning journal , a personal playground , and the beginning of your deeper understanding of how computers really work.

Enjoy every step, and remember:

“Real programmers don’t fear the void; they write their own.” 😄 



## 📝 How to Use It

1. Save this as `README.md` in your repo root.
2. Commit and push it.
3. Add each working step in its own folder.
4. Never modify a working file — create a new one for each change.
