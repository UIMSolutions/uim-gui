# UIM GUI Library

A comprehensive GUI library collection for the D programming language, built over eight years of D language experience.

## Overview

UIM GUI provides high-quality, production-ready GUI bindings and frameworks for D applications. Supporting all major Linux desktop environments:

- **GNOME/GTK** - Complete bindings for GNOME libraries (GLib, GObject, GTK4, GDK, GIO)
- **KDE/Qt** - Qt6 framework bindings for KDE Plasma applications
- **XFCE** - Complete bindings for XFCE desktop environment (xfconf, libxfce4util, libxfce4ui)

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

**Status:** ✅ Production-ready

[See GNOME documentation](gnome/README.md)

### KDE/Qt (`:kde`)

Qt framework bindings for KDE Plasma development:
- Qt Core - Core non-GUI functionality
- Qt Widgets - Widget toolkit for desktop applications
- Qt GUI - Graphics and windowing

**Status:** ⚠️ Foundation/Architecture (requires C++ wrapper for production use)

[See KDE documentation](kde/README.md)

### XFCE (`:xfce`)

XFCE desktop environment bindings:
- xfconf - Configuration system
- libxfce4util - Utility functions and resource management
- libxfce4ui - UI helpers and XFCE-specific widgets
- Session management support

**Status:** ✅ Production-ready

[See XFCE documentation](xfce/README.md)

## Installation

### GNOME Library

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

### KDE Library

Add to your `dub.sdl`:

```sdl
dependency "uim-gui:kde" version="~>26.1.0"
```

Or `dub.json`:

```json
{
    "dependencies": {
        "uim-gui:kde": "~>26.1.0"
    }
}
```

### XFCE Library

Add to your `dub.sdl`:

```sdl
dependency "uim-gui:xfce" version="~>26.1.0"
```

Or `dub.json`:

```json
{
    "dependencies": {
        "uim-gui:xfce": "~>26.1.0"
    }
}
```

## Quick Start

### GNOME Application

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

### KDE/Qt Application

```d
import uim.kde;

void main(string[] args) {
    auto app = new Application(args);
    
    auto window = new MainWindow();
    window.setWindowTitle("Hello KDE!");
    window.resize(400, 300);
    
    auto button = new PushButton("Click Me!");
    window.setCentralWidget(button);
    
    window.show();
    app.exec();
}
```

**Note:** KDE example requires a C++ wrapper library. See [KDE README](kde/README.md) for details.

### XFCE Application

```d
import uim.xfce;

void main(string[] args) {
    initGTK();
    initXfconf();
    
    auto app = new Application("org.example.app");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Hello XFCE!";
        window.setDefaultSize(400, 300);
        
        // Use xfconf for configuration
        auto config = new Channel("myapp");
        config.setString("/window/theme", "default");
        
        auto button = new Button("Click Me!");
        button.onClicked(() {
            showInfo(window, "Button Clicked!", 
                    "This is an XFCE-style dialog.");
        });
        
        window.setChild(button);
        window.present();
    });
    
    app.run(args);
    shutdownXfconf();
}
```

## Requirements

### System Dependencies

**GNOME (Ubuntu/Debian):**
```bash
sudo apt-get install libgtk-4-dev libglib2.0-dev
```

**GNOME (Fedora):**
```bash
sudo dnf install gtk4-devel glib2-devel
```

**GNOME (Arch Linux):**
```bash
sudo pacman -S gtk4 glib2
```

**KDE (Ubuntu/Debian):**
```bash
sudo apt-get install qt6-base-dev libqt6widgets6 libqt6core6
```

**KDE (Fedora):**
```bash
sudo dnf install qt6-qtbase-devel
```

**KDE (Arch Linux):**
```bash
sudo pacman -S qt6-base
```

**XFCE (Ubuntu/Debian):**
```bash
sudo apt-get install libxfce4util-dev libxfce4ui-2-dev libxfconf-0-dev
sudo apt-get install libgtk-4-dev libglib2.0-dev
```

**XFCE (Fedora):**
```bash
sudo dnf install xfce4-dev-tools libxfce4util-devel libxfce4ui-devel xfconf-devel
sudo dnf install gtk4-devel glib2-devel
```

**XFCE (Arch Linux):**
```bash
sudo pacman -S xfce4-dev-tools libxfce4util libxfce4ui xfconf
sudo pacman -S gtk4 glib2
```

### D Compiler

- DMD 2.100+ or
- LDC 1.30+ or
- GDC 12+

## Examples

### GNOME Examples

See the `gnome/examples/` directory:

- `hello.d` - Simple hello world application
- `formgrid.d` - Form with grid layout
- `texteditor.d` - Basic text editor structure

### KDE Examples

See the `kde/examples/` directory:

- `hello.d` - Simple Qt application
- `form.d` - Registration form with layouts

### XFCE Examples

See the `xfce/examples/` directory:

- `hello.d` - XFCE application with dialogs and configuration
- `settings.d` - Settings editor using xfconf
- `resources.d` - Resource browser and utilities

## Building Examples

**GNOME:**
```bash
cd gnome/examples
dub build --single hello.d
./hello
```

**KDE:**
```bash
cd kde/examples
# Note: Requires C++ wrapper library (see kde/README.md)
dub build --single hello.d
./hello
```

**XFCE:**
```bash
cd xfce/examples
dub build --single hello.d
./hello
```

## Documentation

- [GNOME Module Documentation](gnome/README.md)
- [KDE Module Documentation](kde/README.md)
- [XFCE Module Documentation](xfce/README.md)
- [API Reference](https://docs.uim-framework.org/) (coming soon)

## Architecture

The library is organized in layers:

### GNOME Architecture

1. **C Bindings** (`uim.gnome.c.*`) - Direct C API access
2. **D Wrappers** (`uim.gnome.*`) - Idiomatic D interfaces
3. **Utilities** (`uim.gnome.utils`) - Helper functions and RAII wrappers

### KDE Architecture

1. **C++ Bindings** (`uim.kde.c.*`) - Direct C++ API access (via extern(C++))
2. **D Wrappers** (`uim.kde.*`) - Idiomatic D interfaces
3. **Utilities** (`uim.kde.utils`) - Helper functions and type conversions

This design allows you to:
- Use high-level D wrappers for most tasks
- Drop down to lower-level bindings when needed for performance or features
- Extend the library easily with your own wrappers

## Choosing Between GNOME and KDE

| Feature | GNOME/GTK | KDE/Qt |
|---------|-----------|--------|
| **Status** | ✅ Production-ready | ⚠️ Requires C++ wrapper |
| **ABI** | C (stable) | C++ (complex) |
| **Integration** | Direct D binding | Requires intermediate layer |
| **Desktop** | GNOME, Pantheon | KDE Plasma, LXQt |
| **Style** | Modern, flat | Flexible theming |
| **Use Case** | Ready for production | Architecture/testing only |

**Recommendation:** Use GNOME bindings for production applications. KDE bindings are architectural foundations that require additional C++ wrapper development.

## Contributing

Contributions are welcome! Please:

1. Follow D style guidelines
2. Add documentation for new features
3. Include examples for significant features
4. Write tests when applicable
Qt Documentation](https://doc.qt.io/)
- [KDE Developer](https://develop.kde.org/)
- [
## License

Apache 2.0 License

## Copyright

Copyright © 2018-2026, Ozan Nurettin Süel (UI Manufaktur)

## Links

- [D Language](https://dlang.org/)
- [GNOME Developer](https://developer.gnome.org/)
- [UIM Framework](https://www.sueel.de/uim/framework)
