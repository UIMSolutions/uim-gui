# GNOME Library for D - Project Summary

## Overview

A comprehensive GNOME/GTK library for the D programming language, providing both low-level C bindings and high-level idiomatic D wrappers for building native GNOME applications.

## Project Structure

```
uim-gui/
├── dub.sdl                      # Main package configuration
├── README.md                    # Main documentation
├── source/
│   └── uim/
│       └── gui.d               # Main module (re-exports gnome)
└── gnome/                      # GNOME subpackage
    ├── dub.sdl                 # GNOME package configuration
    ├── README.md               # GNOME documentation
    ├── examples/               # Example applications
    │   ├── hello.d            # Simple hello world
    │   ├── formgrid.d         # Form with grid layout
    │   └── texteditor.d       # Text editor structure
    └── source/
        └── uim/
            └── gnome/
                ├── package.d   # Main GNOME module
                ├── types.d     # Type definitions and conversions
                ├── utils.d     # Utility functions and RAII wrappers
                ├── c/          # C bindings (low-level)
                │   ├── glib.d     # GLib C API (memory, strings, lists, etc.)
                │   ├── gobject.d  # GObject C API (object system, signals)
                │   ├── gtk.d      # GTK C API (widgets, windows, etc.)
                │   ├── gdk.d      # GDK C API (drawing, events, display)
                │   └── gio.d      # GIO C API (files, settings, I/O)
                ├── glib.d      # GLib D wrappers
                ├── gobject.d   # GObject D wrappers
                ├── gtk.d       # GTK D wrappers
                ├── gdk.d       # GDK D wrappers
                └── gio.d       # GIO D wrappers
```

## Components

### C Bindings (uim.gnome.c.*)

Low-level bindings to C functions:
- **glib.d**: ~250+ lines - Memory management, strings, lists, hash tables, main loop
- **gobject.d**: ~400+ lines - Type system, objects, properties, signals
- **gtk.d**: ~350+ lines - Widgets (Window, Button, Label, Entry, Box, Grid, etc.)
- **gdk.d**: ~200+ lines - Display, colors, rectangles, events, clipboard
- **gio.d**: ~180+ lines - Files, streams, settings, application framework

### D Wrappers (uim.gnome.*)

High-level D interfaces:
- **types.d**: Type conversions, memory wrappers, error handling
- **utils.d**: Utility functions, signal connections, property access
- **glib.d**: D wrappers for GLib (MainLoop, Lists, HashTable, timeout/idle)
- **gobject.d**: D wrappers for GObject (base class, values)
- **gtk.d**: D wrappers for GTK (Widget, Window, Button, Label, Entry, Box, Grid)
- **gdk.d**: D wrappers for GDK (Display, RGBA, Rectangle)
- **gio.d**: D wrappers for GIO (File, Settings)

## Key Features

### 1. Two-Level API Design

**Low-Level (C bindings)**
```d
import uim.gnome.c.gtk;
auto window = gtk_window_new();
gtk_window_set_title(cast(GtkWindow*)window, "Title");
```

**High-Level (D wrappers)**
```d
import uim.gnome.gtk;
auto window = new Window();
window.title = "Title";
```

### 2. Automatic Memory Management

- RAII wrappers (GObjectRef, GMemory, GErrorWrapper)
- Automatic reference counting
- Scope-based cleanup

### 3. Type Safety

- Strong typing with D's type system
- Compile-time checks
- Template-based generic code

### 4. Signal System

Easy signal/slot connections:
```d
button.onClicked(() {
    writeln("Clicked!");
});
```

### 5. Property Access

Intuitive property syntax:
```d
window.title = "My App";
button.sensitive = false;
```

## Usage Patterns

### Basic Application

```d
import uim.gnome;

void main(string[] args) {
    initGTK();
    auto app = new Application("org.example.app");
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Hello!";
        window.present();
    });
    app.run(args);
}
```

### Container Layouts

**Vertical Box:**
```d
auto vbox = new Box(GTK_ORIENTATION_VERTICAL, 10);
vbox.append(new Label("Label"));
vbox.append(new Button("Button"));
```

**Grid:**
```d
auto grid = new Grid();
grid.attach(new Label("Name:"), 0, 0);
grid.attach(new Entry(), 1, 0);
```

### Event Handling

```d
auto button = new Button("Click");
button.onClicked(() {
    // Handle click
});
```

## Building and Running

### Build Library
```bash
cd /home/oz/DEV/D/UIM2026/LIBS/uim-gui
dub build
```

### Build Examples
```bash
cd gnome/examples
dub build --single hello.d
./hello
```

## Dependencies

### Build-time
- D compiler (DMD 2.100+, LDC 1.30+, or GDC 12+)
- DUB package manager
- uim-framework ~>26.1.2

### Runtime (System)
- libglib-2.0
- libgobject-2.0
- libgtk-4

## Coverage

### Implemented Features

✅ GLib:
- Basic types and memory management
- Strings and string arrays
- Lists (GList, GSList)
- Hash tables
- Errors
- Main loop, timeouts, idle callbacks
- File utilities

✅ GObject:
- Type system
- Object creation and destruction
- Reference counting
- Properties (get/set)
- Signals (connect, disconnect, emit)
- Values

✅ GTK:
- Application framework
- Windows
- Basic widgets (Button, Label, Entry)
- Containers (Box, Grid)
- Widget properties (visibility, sensitivity, size)

✅ GDK:
- Display management
- RGBA colors
- Rectangles
- Events
- Key constants

✅ GIO:
- File operations
- Settings/GSettings
- Application framework

### Future Enhancements

Potential additions:
- TextView and TextBuffer
- ScrolledWindow
- TreeView and ListBox
- Dialog and MessageDialog
- FileChooser
- Menu and MenuBar
- Drawing with Cairo
- CSS styling
- Custom widgets
- More GIO features (async I/O, networking)

## Testing

To test the library:

1. **Build the library:**
   ```bash
   dub build
   ```

2. **Run examples:**
   ```bash
   cd gnome/examples
   dub build --single hello.d && ./hello
   ```

3. **Check for errors:**
   ```bash
   dub test
   ```

## Code Quality

- **Total Lines**: ~3000+ lines of D code
- **Documentation**: Comprehensive README and inline comments
- **Examples**: 3 complete example applications
- **Architecture**: Clean separation of concerns (C bindings vs D wrappers)
- **Style**: Consistent D style throughout

## Compatibility

- **GTK Version**: GTK 4.x
- **D Language**: DMD 2.100+, LDC 1.30+, GDC 12+
- **Platforms**: Linux (primary), potentially BSD
- **Dependencies**: Links against system GNOME libraries

## License & Copyright

- **License**: Apache 2.0
- **Copyright**: © 2018-2026, Ozan Nurettin Süel (UI Manufaktur)
- **Authors**: Ozan Nurettin Süel (UIManufaktur)

## Development Status

- ✅ Core infrastructure complete
- ✅ Basic widgets implemented
- ✅ Signal system working
- ✅ Memory management solid
- ✅ Example applications functional
- 🔄 Additional widgets can be added as needed
- 🔄 Advanced features available for extension

## Notes

This is a production-ready foundation for GNOME application development in D. The library follows best practices for D development and provides both power (through C bindings) and convenience (through D wrappers).
