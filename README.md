Here's the updated README for CheeseOS with the current status and additional features:

# Cheese Operating System (CheeseOS)

## Overview
CheeseOS is a minimalistic operating system built from scratch in Assembly language. It provides basic functionality such as a command prompt, file system simulation, keyboard input handling, and mouse support. CheeseOS is designed for educational purposes to understand the fundamentals of operating system development.

## Features
- **Bootloader:** Loads the kernel from disk and initiates the OS.
- **Kernel:** Handles system initialization, keyboard and mouse input, command interpretation, and file system operations.
- **File System Simulation:** Simulates a basic file system structure with support for reading and writing files.
- **Command Prompt:** Provides a simple command prompt interface for user interaction.
- **Mouse Support:** Adds basic mouse input handling with a visible cursor.

## Installation
To run CheeseOS on a virtual machine, follow these steps:

1. **Clone the Repository:** Clone the CheeseOS repository to your local machine.
   ```sh
   git clone github.com/CallenDV/CheeseOS
   ```

2. **Build the Bootloader:** Assemble the bootloader code using NASM.
   ```sh
   nasm -f bin bootloader.asm -o bootloader.bin
   ```

3. **Build the Kernel:** Assemble the kernel code using NASM.
   ```sh
   nasm -f bin kernel.asm -o kernel.bin
   ```

4. **Build the Keyboard Handler:** Assemble the keyboard handler code using NASM.
   ```sh
   nasm -f bin keyboard.asm -o keyboard.bin
   ```

5. **Build the Mouse Handler:** Assemble the mouse handler code using NASM.
   ```sh
   nasm -f bin mouse.asm -o mouse.bin
   ```

6. **Create Disk Image:** Create a disk image containing the bootloader, kernel, keyboard, and mouse handlers.
   ```sh
   cat bootloader.bin kernel.bin keyboard.bin mouse.bin > os-image.img
   ```

7. **Run in Virtual Machine:** Create a virtual machine using software like VirtualBox or QEMU and boot the OS image (`os-image.img`) as the boot disk.

## Usage
Once CheeseOS is running, you will be presented with a simple command prompt. Here are some basic commands you can try:

- **echo <message>:** Echoes the provided message to the screen.
  ```sh
  echo Hello, World!
  ```

- **read <filename>:** Reads the content of the specified file from the simulated file system.
  ```sh
  read File1
  ```

- **write <filename>:** Writes to the specified file in the simulated file system.
  ```sh
  write File3
  ```

- **exit:** Exits the operating system and shuts down the virtual machine.

## Status
### Completed
- Basic bootloader and kernel loading
- Command prompt with basic commands
- Keyboard input handling
- Basic file system simulation
- Mouse input handling with a visible cursor

### In Progress
- Enhancing file system capabilities
- Expanding command set
- Improving mouse functionality
- Bug fixes and optimizations

## Contributing
Contributions to CheeseOS are welcome! If you find any bugs or want to suggest improvements, feel free to open an issue or create a pull request.

## License
This project is licensed under the Apache License. See the [LICENSE](LICENSE) file for details.