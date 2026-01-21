# UIM XFCE Library for D

Complete D language bindings for the XFCE desktop environment.

## Overview

This library provides D bindings for XFCE desktop environment components:

- **xfconf** - Configuration system for storing application settings
- **libxfce4util** - Utility functions and resource management
- **libxfce4ui** - UI helpers, dialogs, and XFCE-specific widgets
- **Session Management** - Integration with XFCE session manager

Since XFCE is built on GTK, this library extends the [uim-gnome](../gnome/README.md) GTK bindings with XFCE-specific functionality.

## Features

- ✅ **Configuration System** (xfconf) - Type-safe configuration storage
- ✅ **Resource Lookup** - Find data, config, cache, icons, and themes
- ✅ **XFCE Dialogs** - Titled dialogs and standard XFCE-style messages
- ✅ **Session Management** - Save/restore application state across sessions
- ✅ **Utility Functions** - Directory localization, variable expansion, etc.
- ✅ **Kiosk Mode Support** - Desktop lockdown capabilities
- ✅ **Application Launching** - Spawn commands with proper XFCE integration

## Installation

### System Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get install libxfce4util-dev libxfce4ui-2-dev libxfconf-0-dev
sudo apt-get install libgtk-4-dev libglib2.0-dev  # GTK dependencies
```

**Fedora:**
```bash
sudo dnf install xfce4-dev-tools libxfce4util-devel libxfce4ui-devel xfconf-devel
sudo dnf install gtk4-devel glib2-devel
```

**Arch Linux:**
```bash
sudo pacman -S xfce4-dev-tools libxfce4util libxfce4ui xfconf
sudo pacman -S gtk4 glib2
```

### DUB Dependency

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

```d
import uim.xfce;

void main(string[] args) {
    // Initialize GTK and xfconf
    initGTK();
    initXfconf();
    
    // Create application
    auto app = new Application("org.example.myapp");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "XFCE Application";
        window.setDefaultSize(600, 400);
        
        // Use xfconf for configuration
        auto config = new Channel("myapp");
        config.setString("/window/theme", "dark");
        
        // Create XFCE-style UI
        auto box = new Box(Orientation.Vertical, 10);
        
        auto button = new Button("Click Me!");
        button.onClicked(() {
            showInfo(window, "Button Clicked!", 
                    "This is an XFCE-style dialog.");
        });
        
        box.append(button);
        window.setChild(box);
        window.present();
    });
    
    app.run(args);
    shutdownXfconf();
}
```

## Architecture

```
uim.xfce
├── C Bindings (uim.xfce.c.*)
│   ├── libxfce4util    - Utility functions
│   ├── libxfce4ui      - UI components
│   └── xfconf          - Configuration system
│
└── D Wrappers (uim.xfce.*)
    ├── util           - Resource and utility wrappers
    ├── ui             - Dialog and UI helpers
    ├── xfconf         - Configuration channel wrapper
    └── sm             - Session management
```

## API Guide

### Configuration System (xfconf)

Xfconf is XFCE's configuration storage system. Configuration is organized in channels and properties:

```d
import uim.xfce;

// Initialize xfconf
initXfconf();

// Get/create a configuration channel
auto channel = new Channel("xfce4-desktop");

// String properties
channel.setString("/backdrop/screen0/workspace0/last-image", "/path/to/wallpaper.jpg");
auto wallpaper = channel.getString("/backdrop/screen0/workspace0/last-image");

// Integer properties
channel.setInt("/backdrop/brightness", 50);
auto brightness = channel.getInt("/backdrop/brightness", 100); // default: 100

// Boolean properties
channel.setBool("/backdrop/show-thumbnails", true);
auto showThumbs = channel.getBool("/backdrop/show-thumbnails", false);

// Double properties
channel.setDouble("/backdrop/opacity", 0.85);
auto opacity = channel.getDouble("/backdrop/opacity", 1.0);

// String list properties
channel.setStringList("/desktop/search-paths", ["/home/user/Desktop", "/usr/share"]);
auto paths = channel.getStringList("/desktop/search-paths");

// Check if property exists
if (channel.hasProperty("/backdrop/screen0/monitor0/workspace0/last-image")) {
    // Property exists
}

// Reset property to default
channel.resetProperty("/backdrop/screen0/workspace0", false); // non-recursive
channel.resetProperty("/backdrop", true); // recursive - resets all child properties

// List all channels
auto channels = listChannels();
foreach (ch; channels) {
    writeln("Channel: ", ch);
}

// Cleanup
shutdownXfconf();
```

**Common XFCE Configuration Channels:**
- `xfce4-desktop` - Desktop settings (wallpaper, icons)
- `xfce4-panel` - Panel configuration
- `xfce4-session` - Session management settings
- `xfce4-keyboard-shortcuts` - Keyboard shortcuts
- `xfwm4` - Window manager settings
- `xfce4-power-manager` - Power management
- `xfce4-notifyd` - Notification daemon
- `thunar` - File manager settings

### Resource Lookup

XFCE provides standardized locations for different resource types:

```d
import uim.xfce;

// Look up resources
auto iconPath = resourceLookup(ResourceType.Icons, "preferences-desktop.png");
auto themePath = resourceLookup(ResourceType.Themes, "mytheme/index.theme");

// Get save locations
auto dataDir = resourceSaveLocation(ResourceType.Data, "myapp/", true);
auto configDir = resourceSaveLocation(ResourceType.Config, "myapp/", true);
auto cacheDir = resourceSaveLocation(ResourceType.Cache, "myapp/", true);

// Directory utilities
auto homeDir = getHomeDir();           // /home/username
auto userDir = getUserDir();           // /home/username/.config/xfce4

// Localized directory names
auto desktop = getDirLocalized("Desktop");     // "Desktop" or localized
auto documents = getDirLocalized("Documents"); // "Documents" or localized
auto downloads = getDirLocalized("Downloads"); // "Downloads" or localized
```

**Resource Types:**
- `ResourceType.Data` - Application data
- `ResourceType.Config` - Configuration files
- `ResourceType.Cache` - Cache files
- `ResourceType.Icons` - Icon files
- `ResourceType.Themes` - Theme files

### XFCE Dialogs

XFCE provides consistent, themed dialogs:

```d
import uim.xfce;

// Information dialog
showInfo(parentWindow, "Operation Complete", 
         "The file has been saved successfully.");

// Warning dialog
showWarning(parentWindow, "Disk Space Low", 
           "You have less than 10% disk space remaining.");

// Error dialog
showError(parentWindow, "Could Not Save File", 
         "Permission denied: /etc/protected.conf");

// Confirmation dialog
if (confirm(parentWindow, "Delete File?", 
           "This action cannot be undone.", "Delete")) {
    // User confirmed
    deleteFile();
}

// Filename input dialog
auto filename = filenameInput("Save As", 
                             "Enter filename:", 
                             "untitled.txt",
                             parentWindow);
if (filename !is null) {
    // User entered a filename
    saveFile(filename);
}

// Titled dialog (XFCE-style)
auto dialog = new TitledDialog("Settings", parentWindow);
dialog.setSubtitle("Configure application preferences");
// Add widgets to dialog...
dialog.show();
```

### Utility Functions

```d
import uim.xfce;

// Version information
auto version = getVersionString();  // e.g., "4.18.0"
bool compatible = checkVersion(4, 18, 0);

// Variable expansion
auto expanded = expandVariables("$HOME/documents");  // /home/user/documents
auto withPath = expandVariables("$PATH");

// Language information
auto languages = getLanguageNames();  // ["en_US", "en", "C"]
auto langName = getLanguageName("de");  // "German"

// Center window on active screen
centerOnActiveScreen(window);

// Get icon name from desktop ID
auto icon = iconNameFromDesktopId("xfce4-terminal");
```

### Application Launching

```d
import uim.xfce;

// Spawn a command
bool success = spawnCommand("xfce4-terminal", 
                           false,  // inTerminal
                           true);  // startupNotify

// Launch in terminal
spawnCommand("htop", true, false);

// Launch with custom command
spawnCommand("firefox https://xfce.org", false, true);
```

### Session Management

Integrate with XFCE session manager to save/restore application state:

```d
import uim.xfce;

// Get session management client
auto smClient = SMClient.get();

// Connect to session manager
if (smClient.connect()) {
    writeln("Connected to session manager");
    writeln("Client ID: ", smClient.getClientId());
}

// Set desktop file for proper session restoration
smClient.setDesktopFile("/usr/share/applications/myapp.desktop");

// Check if this is a resumed session
if (smClient.isResumed()) {
    // Restore application state
    auto stateFile = smClient.getStateFile();
    if (stateFile) {
        restoreState(stateFile);
    }
}

// Request shutdown
smClient.requestShutdown(ShutdownHint.Logout);

// Priorities for startup order
auto smClient = SMClient.getWithArgv(
    args,
    RestartStyle.Normal,
    Priority.Default  // or Priority.Core, Priority.Desktop, etc.
);
```

**Session Management Priorities:**
- `Priority.Highest` (0) - Highest priority
- `Priority.WindowManager` (15) - Window manager
- `Priority.Core` (25) - Core services
- `Priority.Desktop` (35) - Desktop components
- `Priority.Default` (50) - Default applications
- `Priority.Lowest` (255) - Lowest priority

### Kiosk Mode

Implement desktop lockdown features:

```d
import uim.xfce;

auto kiosk = new Kiosk("xfce4-panel");

// Check if users can customize the panel
if (kiosk.query("CustomizePanel")) {
    // Allow customization
    showCustomizeDialog();
} else {
    // Customization is locked down
    showInfo(null, "Feature Disabled", 
            "Panel customization has been disabled by your administrator.");
}

// Common capabilities to query:
// - "CustomizePanel" - Panel customization
// - "AddApplets" - Adding panel applets
// - "RemoveApplets" - Removing panel applets
// - "LockScreen" - Lock screen capability
// - "Logout" - Logout capability
```

## Examples

### Basic Application

See [examples/hello.d](examples/hello.d) - Demonstrates:
- GTK window creation
- Xfconf configuration
- XFCE dialogs (info, warning, confirm)
- Resource utilities

### Settings Editor

See [examples/settings.d](examples/settings.d) - Demonstrates:
- Titled dialog
- Configuration channel management
- Type-safe property access
- Resetting to defaults
- Listing channels

### Resource Browser

See [examples/resources.d](examples/resources.d) - Demonstrates:
- Resource lookup
- Directory localization
- System information
- Variable expansion
- Kiosk mode checking
- Command launching

## Building Examples

```bash
cd xfce/examples

# Hello world
dub build --single hello.d
./hello

# Settings editor
dub build --single settings.d
./settings

# Resource browser
dub build --single resources.d
./resources
```

## Common Patterns

### Persistent Application Settings

```d
class MyApp {
    private Channel config;
    
    this() {
        initXfconf();
        config = new Channel("myapp");
    }
    
    void saveWindowGeometry(int x, int y, int width, int height) {
        config.setInt("/window/x", x);
        config.setInt("/window/y", y);
        config.setInt("/window/width", width);
        config.setInt("/window/height", height);
    }
    
    void restoreWindowGeometry(out int x, out int y, out int width, out int height) {
        x = config.getInt("/window/x", 100);
        y = config.getInt("/window/y", 100);
        width = config.getInt("/window/width", 800);
        height = config.getInt("/window/height", 600);
    }
    
    ~this() {
        shutdownXfconf();
    }
}
```

### XFCE-Style Preferences Dialog

```d
void showPreferences(Window parent) {
    auto dialog = new TitledDialog("Preferences", parent);
    dialog.setSubtitle("Configure application settings");
    
    auto notebook = new Notebook();
    
    // General tab
    auto generalBox = new Box(Orientation.Vertical, 10);
    generalBox.setMarginTop(10);
    generalBox.setMarginBottom(10);
    // ... add widgets ...
    notebook.appendPage(generalBox, new Label("General"));
    
    // Appearance tab
    auto appearanceBox = new Box(Orientation.Vertical, 10);
    // ... add widgets ...
    notebook.appendPage(appearanceBox, new Label("Appearance"));
    
    // Add notebook to dialog...
    dialog.show();
}
```

## Integration with GNOME Library

Since XFCE uses GTK, you have full access to all GTK widgets from the GNOME library:

```d
import uim.xfce;  // Includes uim.gnome

// Use GTK widgets
auto button = new Button("Click Me");
auto label = new Label("Hello");
auto entry = new Entry();
auto grid = new Grid();

// Use XFCE-specific features
auto config = new Channel("myapp");
showInfo(null, "Hello", "World");
```

## Requirements

- **D Compiler**: DMD 2.100+, LDC 1.30+, or GDC 12+
- **XFCE Libraries**: 4.16 or later (4.18 recommended)
- **GTK**: 4.0 or later
- **GLib**: 2.0 or later

## Comparison with GNOME Library

| Feature | GNOME Library | XFCE Library |
|---------|---------------|--------------|
| **Base Toolkit** | GTK4 | GTK4 |
| **Configuration** | GSettings/dconf | xfconf |
| **Dialogs** | GTK dialogs | XFCE-themed dialogs |
| **Session Management** | GNOME Session | XFCE Session |
| **Resource Lookup** | GIO/GResource | XFCE resource system |
| **Desktop Integration** | GNOME-specific | XFCE-specific |

**When to use XFCE library:**
- Targeting XFCE desktop users
- Need xfconf configuration system
- Want XFCE-consistent look and feel
- Lightweight desktop environment

**When to use GNOME library:**
- Targeting GNOME desktop users
- Modern GTK4 applications
- Need GSettings/dconf
- Full GNOME stack integration

## Troubleshooting

### Build Errors

**"Cannot find xfconf-0"**
```bash
sudo apt-get install libxfconf-0-dev  # Ubuntu/Debian
sudo dnf install xfconf-devel         # Fedora
sudo pacman -S xfconf                  # Arch
```

**"Cannot find libxfce4ui-2"**
```bash
sudo apt-get install libxfce4ui-2-dev  # Ubuntu/Debian
```

### Runtime Errors

**"Failed to init xfconf"**
- Make sure D-Bus is running
- Check that xfconfd is running: `ps aux | grep xfconfd`
- Try starting it: `xfconfd`

**"Cannot connect to session manager"**
- Only works when running under XFCE session
- For testing outside XFCE, session management functions will return false/null

## Status

✅ **Production-Ready**

All major XFCE libraries are implemented and tested:
- libxfce4util - Complete
- libxfce4ui - Complete
- xfconf - Complete
- Session management - Complete

## Contributing

Contributions welcome! Areas for expansion:
- Additional xfce4-panel bindings
- Thunar (file manager) integration
- More xfce4-terminal integration
- Additional examples

## License

Apache 2.0

## Copyright

Copyright © 2018-2026, Ozan Nurettin Süel (UI Manufaktur)

## Links

- [XFCE Website](https://www.xfce.org/)
- [XFCE Documentation](https://docs.xfce.org/)
- [GTK Documentation](https://docs.gtk.org/)
- [D Language](https://dlang.org/)
