# Getting Started with UIM GUI Library

A quick start guide for building GUI applications in D using the UIM GUI library.

---

## 🚀 Quick Start (5 Minutes)

### 1. Install System Dependencies

**For GNOME/GTK Applications (Recommended):**
```bash
# Ubuntu/Debian
sudo apt-get install libgtk-4-dev libglib2.0-dev

# Fedora
sudo dnf install gtk4-devel glib2-devel

# Arch Linux
sudo pacman -S gtk4 glib2
```

**For KDE/Qt Applications (Advanced):**
```bash
# Ubuntu/Debian
sudo apt-get install qt6-base-dev libqt6widgets6 libqt6core6

# Fedora
sudo dnf install qt6-qtbase-devel

# Arch Linux
sudo pacman -S qt6-base
```

### 2. Create Your Project

```bash
mkdir my-gui-app
cd my-gui-app
dub init
```

### 3. Edit dub.sdl

**For GNOME application:**
```sdl
name "my-gui-app"
description "My first GUI application"
authors "Your Name"
copyright "Copyright © 2026, Your Name"
license "Apache-2.0"

dependency "uim-gui:gnome" version="~>26.1.0"
```

**For KDE application:**
```sdl
name "my-gui-app"
description "My first GUI application"
authors "Your Name"
copyright "Copyright © 2026, Your Name"
license "Apache-2.0"

dependency "uim-gui:kde" version="~>26.1.0"
```

### 4. Write Your First App

**GNOME Hello World (source/app.d):**
```d
import uim.gnome;
import std.stdio;

void main(string[] args) {
    // Initialize GTK
    initGTK();
    
    // Create application
    auto app = new Application("com.example.hello");
    
    // Setup on activation
    app.connectSignal("activate", () {
        // Create window
        auto window = new Window();
        window.title = "Hello GNOME!";
        window.setDefaultSize(400, 300);
        
        // Create layout
        auto box = new Box(Orientation.Vertical, 10);
        box.setMarginTop(20);
        box.setMarginBottom(20);
        box.setMarginStart(20);
        box.setMarginEnd(20);
        
        // Add label
        auto label = new Label("Welcome to GNOME with D!");
        box.append(label);
        
        // Add button
        auto button = new Button("Click Me!");
        button.onClicked(() {
            writeln("Button clicked!");
            label.text = "You clicked the button!";
        });
        box.append(button);
        
        // Setup window
        window.setChild(box);
        window.present();
    });
    
    // Run application
    app.run(args);
}
```

**KDE Hello World (source/app.d):**
```d
import uim.kde;
import std.stdio;

void main(string[] args) {
    // Note: This requires a C++ wrapper library to function
    // See kde/README.md for details
    
    auto app = new Application(args);
    
    auto window = new MainWindow();
    window.setWindowTitle("Hello KDE!");
    window.resize(400, 300);
    
    auto widget = new Widget();
    auto layout = new VBoxLayout();
    
    auto label = new Label("Welcome to Qt with D!");
    layout.addWidget(label);
    
    auto button = new PushButton("Click Me!");
    layout.addWidget(button);
    
    widget.setLayout(layout);
    window.setCentralWidget(widget);
    
    window.show();
    app.exec();
}
```

### 5. Build and Run

```bash
dub build
dub run
```

---

## 📚 Next Steps

### Learn by Example

**GNOME Examples:**
```bash
cd /path/to/uim-gui/gnome/examples

# Simple hello world
dub build --single hello.d
./hello

# Form with grid layout
dub build --single formgrid.d
./formgrid

# Text editor
dub build --single texteditor.d
./texteditor
```

**KDE Examples:**
```bash
cd /path/to/uim-gui/kde/examples

# Note: These require C++ wrapper to link successfully
dub build --single hello.d
dub build --single form.d
```

### Read the Documentation

1. **[Main README](../README.md)** - Overview and quick reference
2. **[GNOME Guide](../gnome/README.md)** - GNOME/GTK detailed documentation
3. **[KDE Guide](../kde/README.md)** - KDE/Qt detailed documentation
4. **[Implementation Status](../LIBRARY_STATUS.md)** - Detailed status report
5. **[Implementation Summary](../IMPLEMENTATION_SUMMARY.md)** - Complete overview

---

## 🎯 Common Patterns

### Creating Windows

**GNOME:**
```d
auto window = new Window();
window.title = "My Application";
window.setDefaultSize(800, 600);
window.present();
```

**KDE:**
```d
auto window = new MainWindow();
window.setWindowTitle("My Application");
window.resize(800, 600);
window.show();
```

### Layouts

**GNOME - Box Layout:**
```d
auto box = new Box(Orientation.Vertical, 10);
box.append(widget1);
box.append(widget2);
window.setChild(box);
```

**GNOME - Grid Layout:**
```d
auto grid = new Grid();
grid.attach(widget1, 0, 0, 1, 1);  // col, row, width, height
grid.attach(widget2, 1, 0, 1, 1);
window.setChild(grid);
```

**KDE - Box Layout:**
```d
auto layout = new VBoxLayout();
layout.addWidget(widget1);
layout.addWidget(widget2);
widget.setLayout(layout);
```

**KDE - Grid Layout:**
```d
auto layout = new GridLayout();
layout.addWidget(widget1, 0, 0);  // row, col
layout.addWidget(widget2, 0, 1);
widget.setLayout(layout);
```

### Buttons and Events

**GNOME:**
```d
auto button = new Button("Click Me!");
button.onClicked(() {
    writeln("Clicked!");
});
```

**KDE:**
```d
auto button = new PushButton("Click Me!");
// Signal connection requires C++ wrapper
```

### Text Input

**GNOME:**
```d
auto entry = new Entry();
entry.placeholderText = "Enter text...";
string text = entry.text;
```

**KDE:**
```d
auto entry = new LineEdit();
entry.setPlaceholderText("Enter text...");
// Getting text requires C++ wrapper
```

---

## 💡 Tips and Best Practices

### General

1. **Initialize First**: Always call `initGTK()` for GNOME apps
2. **Use RAII**: Wrappers handle memory automatically
3. **Check Documentation**: See module READMEs for detailed API info
4. **Start Simple**: Begin with hello world examples
5. **Build Incrementally**: Add features one at a time

### GNOME Specific

1. **Use Application Class**: Better than direct window management
2. **Leverage Signals**: Connect D delegates for event handling
3. **Set Margins**: Make UIs look professional with proper spacing
4. **Use Box/Grid**: These cover most layout needs
5. **Test Early**: Run frequently during development

### KDE Specific

1. **Understand Limitation**: Current version requires C++ wrapper
2. **Use as Learning Tool**: Great for understanding Qt architecture
3. **Consider Alternatives**: QML or GNOME for production
4. **Read C++ Docs**: Qt documentation is comprehensive
5. **Plan Wrapper**: If going production, design C wrapper first

---

## 🔧 Troubleshooting

### Build Errors

**"Cannot find gtk-4"**
```bash
# Install GTK development packages
sudo apt-get install libgtk-4-dev libglib2.0-dev
```

**"Cannot find Qt6Core"**
```bash
# Install Qt6 development packages
sudo apt-get install qt6-base-dev
```

**"Undefined reference to..."** (KDE)
- This is expected - KDE bindings need C++ wrapper
- See [kde/README.md](../kde/README.md) for wrapper guidance

### Runtime Errors

**Segmentation Fault (GNOME)**
- Check that `initGTK()` was called
- Verify widget hierarchy is correct
- Ensure parent-child relationships are valid

**Window Doesn't Show**
- GNOME: Call `window.present()` not just `show()`
- KDE: Call `window.show()`
- Check that event loop is running (`app.run()` or `app.exec()`)

**Widgets Not Visible**
- Set proper container (window needs child widget)
- Check margins and sizing
- Verify layout is attached to parent

---

## 📖 API Quick Reference

### GNOME Common Classes

| Class | Purpose | Example |
|-------|---------|---------|
| `Application` | Application framework | `auto app = new Application("org.app");` |
| `Window` | Top-level window | `auto win = new Window();` |
| `Button` | Push button | `auto btn = new Button("Click");` |
| `Label` | Text label | `auto lbl = new Label("Text");` |
| `Entry` | Text input | `auto entry = new Entry();` |
| `Box` | Box layout | `auto box = new Box(Orientation.Vertical, 5);` |
| `Grid` | Grid layout | `auto grid = new Grid();` |

### KDE Common Classes

| Class | Purpose | Example |
|-------|---------|---------|
| `Application` | Application framework | `auto app = new Application(args);` |
| `MainWindow` | Top-level window | `auto win = new MainWindow();` |
| `PushButton` | Push button | `auto btn = new PushButton("Click");` |
| `Label` | Text label | `auto lbl = new Label("Text");` |
| `LineEdit` | Text input | `auto edit = new LineEdit();` |
| `VBoxLayout` | Vertical layout | `auto layout = new VBoxLayout();` |
| `GridLayout` | Grid layout | `auto layout = new GridLayout();` |

---

## 🎓 Learning Path

### Beginner (Week 1)
1. ✅ Install system dependencies
2. ✅ Build hello world example
3. ✅ Add buttons and labels
4. ✅ Handle button clicks
5. ✅ Experiment with layouts

### Intermediate (Week 2-3)
1. 🔄 Create forms with multiple inputs
2. 🔄 Use grid layouts
3. 🔄 Handle text entry
4. 🔄 Add multiple windows
5. 🔄 Save/load settings

### Advanced (Week 4+)
1. 🔮 Custom widgets
2. 🔮 Drawing and graphics
3. 🔮 File operations
4. 🔮 Async operations
5. 🔮 Platform integration

---

## 🏆 Example Projects

### Simple Calculator (GNOME)
```d
import uim.gnome;
import std.conv;

void main(string[] args) {
    initGTK();
    auto app = new Application("com.example.calc");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Calculator";
        
        auto grid = new Grid();
        auto display = new Entry();
        grid.attach(display, 0, 0, 4, 1);
        
        // Add number buttons...
        // Add operation buttons...
        // Add click handlers...
        
        window.setChild(grid);
        window.present();
    });
    
    app.run(args);
}
```

### Todo List (GNOME)
```d
import uim.gnome;
import std.stdio;

void main(string[] args) {
    initGTK();
    auto app = new Application("com.example.todo");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Todo List";
        
        auto box = new Box(Orientation.Vertical, 5);
        
        auto entry = new Entry();
        entry.placeholderText = "Enter new task...";
        box.append(entry);
        
        auto addBtn = new Button("Add Task");
        box.append(addBtn);
        
        auto taskList = new Box(Orientation.Vertical, 2);
        box.append(taskList);
        
        addBtn.onClicked(() {
            if (entry.text.length > 0) {
                auto task = new Label(entry.text);
                taskList.append(task);
                entry.text = "";
            }
        });
        
        window.setChild(box);
        window.present();
    });
    
    app.run(args);
}
```

---

## 📞 Getting Help

### Documentation
- **Main README**: Overview and setup
- **GNOME README**: GNOME/GTK specifics
- **KDE README**: KDE/Qt specifics with wrapper info
- **Library Status**: Implementation details

### Community Resources
- **D Language Forum**: https://forum.dlang.org/
- **D Language Discord**: Active community support
- **GTK Documentation**: https://docs.gtk.org/
- **Qt Documentation**: https://doc.qt.io/

### Source Code
- **GitHub**: Check the source for implementation details
- **Examples**: Study the example applications
- **API Documentation**: Read module documentation comments

---

## ✨ Success Stories

**What You Can Build:**
- Desktop applications
- Development tools
- System utilities
- Configuration GUIs
- Data visualization tools
- Text editors
- File managers
- And much more!

---

## 🎯 Your First Goal

**Challenge**: Build a "Hello World" application that:
1. ✅ Shows a window
2. ✅ Displays a label
3. ✅ Has a button
4. ✅ Changes label text when clicked

**Time Estimate**: 15-30 minutes

**Start Now!** Use the Quick Start guide above and you'll have it running in no time!

---

**Happy Coding! 🚀**

*Last Updated: 2026*  
*For UIM GUI Library v26.1.0*
