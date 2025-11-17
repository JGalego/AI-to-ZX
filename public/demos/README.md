# Demo Programs

This directory contains compiled ZX Spectrum programs in TAP format.

## Available Demos

- **0-hello-world.tap** - A simple "Hello World" program demonstrating basic ZX BASIC output

## How to Load

1. Start the emulator on the main page
2. Select a demo from the dropdown menu and click "Load Demo"
3. In the emulator, type `LOAD ""` and press Enter
4. Press `R` to run the loaded program

## Adding New Demos

To add new demos:
1. Place your .tap files in this directory
2. The emulator will automatically detect them (or update the demo list in app.js)

## File Formats Supported

- .tap - Tape archive files
- .tzx - Extended tape files  
- .sna - Snapshot files
- .z80 - Compressed snapshot files