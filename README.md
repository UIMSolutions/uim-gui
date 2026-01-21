# UIM GUI Library

A comprehensive GUI library collection for the D programming language, built over eight years of D language experience.

## Overview

UIM GUI provides high-quality, production-ready GUI bindings and frameworks for D applications. Currently includes:

- **GNOME/GTK** - Complete bindings for GNOME libraries (GLib, GObject, GTK4, GDK, GIO)

## Features

- **Type-Safe Bindings**: Full D language bindings to native GUI libraries
- **High-Level Wrappers**: Idiomatic D interfaces with automatic memory management
- **RAII Support**: Automatic resource cleanup using D's scope and destructors
- **Signal/Slot System**: Easy event handling with D delegates
- **Comprehensive**: Covers core functionality and common use cases

## Modules

### GNOME (`:gnome`)

Complete bindings for GNOME/GTK development:
- GLib - Core utilities and data structures
- GObject - Object system and type library
- GTK4 - Widget toolkit for graphical interfaces
- GDK - Drawing and windowing system
- GIO - File and application I/O

[See GNOME documentation](gnome/README.md)

## Installation

Add to your `dub.sdl`:

```sdl
dependency "uim-gui:gnome" version="~>26.1.0"
```

Or `dub.json`:

```json
{
    "dependencies": {
        "uim-gui:gnome": "~>26.1.0"
    }
}
```

## Quick Start

```d
import uim.gnome;

void main(string[] args) {
    initGTK();
    
    auto app = new Application("org.example.myapp");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Hello GNOME!";
        window.setDefaultSize(400, 300);
        
        auto button = new Button("Click Me!");
        button.onClicked(() {
            import std.stdio : writeln;
            writeln("Button clicked!");
        });
        
        window.setChild(button);
        window.present();
    });
    
    app.run(args);
}
```

## Requirements

### System Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get install libgtk-4-dev libglib2.0-dev
```

**Fedora:**
```bash
sudo dnf install gtk4-devel glib2-devel
```

**Arch Linux:**
```bash
sudo pacman -S gtk4 glib2
```

### D Compiler

- DMD 2.100+ or
- LDC 1.30+ or
- GDC 12+

## Examples

See the `gnome/examples/` directory for complete examples:

- `hello.d` - Simple hello world application
- `formgrid.d` - Form with grid layout
- `texteditor.d` - Basic text editor structure

## Building Examples

```bash
cd gnome/examples
dub build --single hello.d
./hello
```

## Documentation

- [GNOME Module Documentation](gnome/README.md)
- [API Reference](https://docs.uim-framework.org/) (coming soon)

## Architecture

The library is organized in layers:

1. **C Bindings** (`uim.gnome.c.*`) - Direct C API access
2. **D Wrappers** (`uim.gnome.*`) - Idiomatic D interfaces
3. **Utilities** (`uim.gnome.utils`) - Helper functions and RAII wrappers

This design allows you to:
- Use high-level D wrappers for most tasks
- Drop down to C bindings when needed for performance or features
- Extend the library easily with your own wrappers

## Contributing

Contributions are welcome! Please:

1. Follow D style guidelines
2. Add documentation for new features
3. Include examples for significant features
4. Write tests when applicable

## License

Apache 2.0 License

## Copyright

Copyright © 2018-2026, Ozan Nurettin Süel (UI Manufaktur)

## Links

- [D Language](https://dlang.org/)
- [GNOME Developer](https://developer.gnome.org/)
- [UIM Framework](https://www.sueel.de/uim/framework)
