# UIM KDE/Qt Library for D

A comprehensive D language library providing bindings and high-level wrappers for KDE Plasma and Qt libraries.

## ⚠️ Important Note

This is a **foundation library** that provides the structure for Qt bindings in D. Full Qt integration requires:
- C++ wrapper library (Qt uses C++ ABI which D cannot directly call)
- Qt MOC (Meta-Object Compiler) integration for signals/slots
- Additional build tooling

This library demonstrates the architecture and API design for Qt/KDE integration with D.

## Features

- **Complete C++ Bindings Structure**: Framework for Qt C++ API access
- **Idiomatic D Wrappers**: High-level, type-safe D interfaces
- **Memory Management**: RAII wrappers for automatic resource cleanup
- **Type Safety**: Strong typing with D's type system
- **Clean API**: Qt-style property access adapted for D

## Structure

```
kde/
├── source/
│   └── uim/
│       └── kde/
│           ├── package.d          # Main module
│           ├── types.d            # Type definitions and conversions
│           ├── utils.d            # Utility functions
│           ├── c/                 # C++ bindings
│           │   ├── qtcore.d      # Qt Core C++ API
│           │   ├── qtwidgets.d   # Qt Widgets C++ API
│           │   └── qtgui.d       # Qt GUI C++ API
│           ├── qtcore.d          # Qt Core D wrappers
│           ├── qtwidgets.d       # Qt Widgets D wrappers
│           └── qtgui.d           # Qt GUI D wrappers
└── dub.sdl
```

## Installation

Add to your `dub.sdl`:

```sdl
dependency "uim-gui:kde" version="~>26.1.0"
```

### System Requirements

Install Qt development libraries:

**Ubuntu/Debian:**
```bash
sudo apt-get install qt6-base-dev libqt6core6 libqt6widgets6 libqt6gui6
```

**Fedora:**
```bash
sudo dnf install qt6-qtbase-devel
```

**Arch Linux:**
```bash
sudo pacman -S qt6-base
```

## API Overview

### Qt Core Classes

- `CoreApplication` - Core application functionality
- `Application` - GUI application
- `QtString` - String handling
- `QtObject` - Base for QObject wrappers
- `Timer` - Timer functionality

### Qt Widgets Classes

- `Widget` - Base widget
- `MainWindow` - Main application window
- `PushButton` - Push button
- `Label` - Text label
- `LineEdit` - Single-line text input
- `TextEdit` - Multi-line text editor
- `CheckBox` - Checkbox
- `ComboBox` - Dropdown list
- `VBoxLayout` / `HBoxLayout` - Layout managers
- `MessageBox` - Message dialogs

### Qt GUI Classes

- `Color` - Color representation
- `Font` - Font handling
- `Pixmap` / `Image` - Graphics

## Usage Example

```d
import uim.kde;

void main(string[] args) {
    // Create application
    auto app = new Application(args);
    
    // Create window
    auto window = new MainWindow();
    window.windowTitle = "Hello Qt!";
    window.resize(400, 300);
    
    // Create layout and widgets
    auto widget = new Widget();
    auto layout = new VBoxLayout();
    
    auto label = new Label("Welcome to Qt with D!");
    layout.addWidget(label);
    
    auto button = new PushButton("Click Me!");
    layout.addWidget(button);
    
    // Show window
    widget.widgetHandle.qt_QWidget_setLayout(layout.handle);
    window.setCentralWidget(widget);
    window.show();
    
    // Run event loop
    return app.exec();
}
```

## Architecture

The library uses a two-level architecture:

### 1. Low-Level C++ Bindings (`uim.kde.c.*`)
Extern(C++) declarations for Qt C++ API:

```d
import uim.kde.c.qtwidgets;

auto window = qt_QWidget_new(null);
qt_QWidget_show(window);
```

### 2. High-Level D Wrappers (`uim.kde.*`)
Idiomatic D interfaces with RAII:

```d
import uim.kde.qtwidgets;

auto window = new Widget();
window.show();
```

## Building a Complete Qt/D Integration

To create a fully functional Qt binding, you would need:

### 1. C++ Wrapper Library
Create a C wrapper library around Qt:

```cpp
extern "C" {
    QWidget* qt_QWidget_new(QWidget* parent) {
        return new QWidget(parent);
    }
    
    void qt_QWidget_show(QWidget* widget) {
        widget->show();
    }
    // ... more wrappers
}
```

### 2. Signal/Slot Support
Qt's signals/slots require MOC. Options:
- Wrap in C functions with callbacks
- Use QtScript/QML for scripting
- Create D-side event system

### 3. Build Integration
```sdl
// In dub.sdl
libs "qt_d_wrapper"  // Your C++ wrapper
lflags "-L/path/to/wrapper" "-lQt6Core" "-lQt6Widgets"
```

## Comparison with GNOME

| Feature | GNOME/GTK | KDE/Qt |
|---------|-----------|---------|
| Language | C | C++ |
| ABI | C ABI (direct D binding) | C++ ABI (needs wrapper) |
| Object Model | GObject | QObject with MOC |
| Signals | C function pointers | C++ signals/slots |
| Integration Complexity | Lower | Higher |

## Current Status

✅ **Implemented:**
- Complete API structure
- Type system and conversions
- Widget wrappers
- Layout management
- Basic examples

⚠️ **Requires Additional Work:**
- C++ wrapper library
- Signal/slot connection mechanism
- MOC integration
- Event handling system

## Alternative Approaches

For production Qt/D applications, consider:

1. **DQt** - Existing Qt bindings for D
2. **QtE5** - Another Qt5 binding project
3. **QML + D** - Use QML for UI, D for logic
4. **C++ Bridge** - Keep UI in C++/Qt, expose API to D

## Contributing

Contributions welcome! Areas needing work:
- C++ wrapper library implementation
- Signal/slot mechanism
- Build system integration
- More widget wrappers
- KDE Frameworks bindings

## License

Apache 2.0 License

## Copyright

Copyright © 2018-2026, Ozan Nurettin Süel (UI Manufaktur)

## Links

- [Qt Documentation](https://doc.qt.io/)
- [KDE Developer](https://develop.kde.org/)
- [D Language](https://dlang.org/)
- [Qt for Python](https://doc.qt.io/qtforpython/) - Similar binding approach
