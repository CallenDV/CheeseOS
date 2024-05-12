# Cheese Operating System (CheeseOS)

## Overview
CheeseOS is a minimalistic operating system built from scratch in Assembly language. It provides basic functionality such as a command prompt, file system simulation, and keyboard input handling. CheeseOS is designed for educational purposes to understand the fundamentals of operating system development.

## Features
- Bootloader: Loads the kernel from disk and initiates the OS.
- Kernel: Handles system initialization, keyboard input, command interpretation, and file system operations.
- File System Simulation: Simulates a basic file system structure with support for reading and writing files.
- Command Prompt: Provides a simple command prompt interface for user interaction.

## Installation
To run CheeseOS on a virtual machine, follow these steps:

1. **Clone the Repository:** Clone the CheeseOS repository to your local machine.
   ```
   git clone github.com/CallenDV/CheeseOS
   ```

2. **Build the Bootloader:** Assemble the bootloader code using NASM.
   ```
   nasm -f bin bootloader.asm -o bootloader.bin
   ```

3. **Build the Kernel:** Assemble the kernel code using NASM.
   ```
   nasm -f bin kernel.asm -o kernel.bin
   ```

4. **Create Disk Image:** Create a disk image containing the bootloader and kernel.
   ```
   cat bootloader.bin kernel.bin > os-image.img
   ```

5. **Run in Virtual Machine:** Create a virtual machine using software like VirtualBox or QEMU and boot the OS image (`os-image.img`) as the boot disk.

## Usage
Once CheeseOS is running, you will be presented with a simple command prompt. Here are some basic commands you can try:

- **echo <message>:** Echoes the provided message to the screen.
  ```
  echo Hello, World!
  ```

- **read <filename>:** Reads the content of the specified file from the simulated file system.
  ```
  read File1
  ```

- **write <filename>:** Writes to the specified file in the simulated file system.
  ```
  write File3
  ```

- **exit:** Exits the operating system and shuts down the virtual machine.

## Contributing
Contributions to CheeseOS are welcome! If you find any bugs or want to suggest improvements, feel free to open an issue or create a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
