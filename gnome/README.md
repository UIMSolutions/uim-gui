# UIM GNOME Library for D

A comprehensive D language library providing bindings and high-level wrappers for GNOME libraries including GLib, GObject, GTK4, GDK, and GIO.

## Features

- **Complete C Bindings**: Direct access to GNOME C APIs
- **Idiomatic D Wrappers**: High-level, type-safe D interfaces
- **Memory Management**: RAII wrappers for automatic resource cleanup
- **Signal System**: Easy-to-use signal/slot connections with D delegates
- **Type Safety**: Strong typing with D's type system

## Structure

```
gnome/
├── source/
│   └── uim/
│       └── gnome/
│           ├── package.d          # Main module
│           ├── types.d            # Type definitions and conversions
│           ├── utils.d            # Utility functions
│           ├── c/                 # C bindings
│           │   ├── glib.d        # GLib C API
│           │   ├── gobject.d     # GObject C API
│           │   ├── gtk.d         # GTK C API
│           │   ├── gdk.d         # GDK C API
│           │   └── gio.d         # GIO C API
│           ├── glib.d            # GLib D wrappers
│           ├── gobject.d         # GObject D wrappers
│           ├── gtk.d             # GTK D wrappers
│           ├── gdk.d             # GDK D wrappers
│           └── gio.d             # GIO D wrappers
└── dub.sdl
```

## Installation

Add to your `dub.sdl`:

```sdl
dependency "uim-gui:gnome" version="~>26.1.0"
```

Or add to your `dub.json`:

```json
{
    "dependencies": {
        "uim-gui:gnome": "~>26.1.0"
    }
}
```

### System Requirements

Install GNOME development libraries:

**Ubuntu/Debian:**
```bash
sudo apt-get install libgtk-4-dev libglib2.0-dev libgobject-2.0-dev
```

**Fedora:**
```bash
sudo dnf install gtk4-devel glib2-devel gobject-introspection-devel
```

**Arch Linux:**
```bash
sudo pacman -S gtk4 glib2
```

## Usage Examples

### Basic GTK Application

```d
import uim.gnome;

void main(string[] args) {
    // Initialize GTK
    initGTK();
    
    // Create application
    auto app = new Application("org.example.MyApp");
    
    // Connect activate signal
    app.connectSignal("activate", () {
        // Create window
        auto window = new Window();
        window.title = "Hello GNOME";
        window.setDefaultSize(400, 300);
        
        // Create button
        auto button = new Button("Click Me!");
        button.onClicked(() {
            import std.stdio : writeln;
            writeln("Button clicked!");
        });
        
        window.setChild(button);
        window.present();
    });
    
    // Run application
    app.run(args);
}
```

### Using Box Container

```d
import uim.gnome;

void createUI() {
    auto window = new Window();
    window.title = "Box Example";
    window.setDefaultSize(300, 200);
    
    // Create vertical box
    auto vbox = new Box(GTK_ORIENTATION_VERTICAL, 10);
    
    // Add widgets
    vbox.append(new Label("Enter your name:"));
    
    auto entry = new Entry();
    entry.placeholderText = "Name here...";
    vbox.append(entry);
    
    auto button = new Button("Submit");
    button.onClicked(() {
        import std.stdio : writefln;
        writefln("Name: %s", entry.text);
    });
    vbox.append(button);
    
    window.setChild(vbox);
    window.present();
}
```

### Using Grid Layout

```d
import uim.gnome;

void createGridUI() {
    auto window = new Window();
    window.title = "Grid Example";
    
    auto grid = new Grid();
    grid.rowSpacing = 10;
    grid.columnSpacing = 10;
    
    // Add labels and entries in a form layout
    grid.attach(new Label("First Name:"), 0, 0);
    grid.attach(new Entry(), 1, 0);
    
    grid.attach(new Label("Last Name:"), 0, 1);
    grid.attach(new Entry(), 1, 1);
    
    grid.attach(new Label("Email:"), 0, 2);
    grid.attach(new Entry(), 1, 2);
    
    auto submitBtn = new Button("Submit");
    grid.attach(submitBtn, 1, 3);
    
    window.setChild(grid);
    window.present();
}
```

### Working with GLib Lists

```d
import uim.gnome;

void testLists() {
    auto list = new GLibList!int();
    
    // Add items
    list.append(10);
    list.append(20);
    list.append(30);
    
    // Iterate
    foreach (item; list) {
        import std.stdio : writeln;
        writeln(item);
    }
    
    // Access by index
    writeln("Second item: ", list[1]);
}
```

### Using GLib Main Loop

```d
import uim.gnome;

void testMainLoop() {
    auto loop = new MainLoop();
    
    // Add timeout (1000ms)
    addTimeout(1000, () {
        import std.stdio : writeln;
        writeln("Timeout triggered!");
        return true; // Return true to continue
    });
    
    // Add idle callback
    addIdle(() {
        import std.stdio : writeln;
        writeln("Idle callback");
        return false; // Return false to remove
    });
    
    loop.run();
}
```

### Working with Files (GIO)

```d
import uim.gnome;

void testFiles() {
    auto file = File.forPath("/tmp/test.txt");
    
    if (file.exists()) {
        writeln("File exists: ", file.path);
        writeln("URI: ", file.uri);
        writeln("Basename: ", file.basename);
    }
}
```

### Using GSettings

```d
import uim.gnome;

void testSettings() {
    auto settings = new Settings("org.example.myapp");
    
    // Read settings
    auto darkMode = settings.getBool("dark-mode");
    auto fontSize = settings.getInt("font-size");
    auto userName = settings.getString("user-name");
    
    // Write settings
    settings.setBool("dark-mode", true);
    settings.setInt("font-size", 12);
    settings.setString("user-name", "John Doe");
}
```

### Working with Colors (GDK)

```d
import uim.gnome;

void testColors() {
    // Create color from values
    auto red = RGBA(1.0, 0.0, 0.0, 1.0);
    
    // Parse color from string
    auto blue = RGBA.parse("#0000FF");
    auto green = RGBA.parse("rgb(0, 255, 0)");
    
    // Convert to string
    writeln("Color: ", red.toString());
}
```

### Signal Connections

```d
import uim.gnome;

void testSignals() {
    auto button = new Button("Click Me");
    
    // Connect signal
    ulong handlerId = button.connectSignal("clicked", () {
        import std.stdio : writeln;
        writeln("Button was clicked!");
    });
    
    // Disconnect signal later
    button.disconnectSignal(handlerId);
}
```

## API Levels

The library provides two API levels:

### 1. Low-Level C Bindings (`uim.gnome.c.*`)
Direct access to C functions for when you need complete control:

```d
import uim.gnome.c.gtk;

auto window = gtk_window_new();
gtk_window_set_title(cast(GtkWindow*)window, "Title");
```

### 2. High-Level D Wrappers (`uim.gnome.*`)
Idiomatic D interfaces with automatic memory management:

```d
import uim.gnome.gtk;

auto window = new Window();
window.title = "Title";
```

## Memory Management

The library uses RAII for automatic resource cleanup:

- **GObjectRef**: RAII wrapper for GObject reference counting
- **GMemory**: RAII wrapper for GLib memory allocation
- **GErrorWrapper**: RAII wrapper for GError handling

```d
import uim.gnome;

{
    auto obj = GObjectRef!GtkWidget(widget);
    // Object is automatically unreferenced when scope exits
}
```

## Error Handling

GLib errors are converted to D exceptions:

```d
import uim.gnome;

try {
    auto file = File.forPath("/nonexistent/file");
    file.delete_();
} catch (GNOMEException e) {
    writefln("Error: %s (code: %d)", e.msg, e.errorCode);
}
```

## Thread Safety

GLib and GTK have specific threading requirements:
- GTK functions must be called from the main thread
- Use GLib thread primitives for multi-threading
- Use `g_idle_add` to schedule callbacks on the main thread

## Contributing

Contributions are welcome! Please ensure:
- Code follows D style guidelines
- New features include documentation
- Examples are provided for new functionality

## License

Apache 2.0 License

## Copyright

Copyright © 2018-2026, Ozan Nurettin Süel (UI Manufaktur)

## Links

- [GNOME Developer Documentation](https://developer.gnome.org/)
- [GTK Documentation](https://docs.gtk.org/gtk4/)
- [GLib Documentation](https://docs.gtk.org/glib/)
- [D Language](https://dlang.org/)
