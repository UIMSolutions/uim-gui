/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	Example: Text Editor Application
**********************************************************************************************************/
import uim.gnome;
import std.stdio;
import std.file : readText, write;
import std.exception : ifThrown;

void main(string[] args) {
    initGTK();
    
    auto app = new Application("org.example.texteditor");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Simple Text Editor";
        window.setDefaultSize(800, 600);
        
        // Create main vertical box
        auto mainBox = new Box(GTK_ORIENTATION_VERTICAL, 0);
        
        // Create toolbar
        auto toolbar = new Box(GTK_ORIENTATION_HORIZONTAL, 5);
        
        auto openButton = new Button("Open");
        auto saveButton = new Button("Save");
        auto clearButton = new Button("Clear");
        
        toolbar.append(openButton);
        toolbar.append(saveButton);
        toolbar.append(clearButton);
        
        mainBox.append(toolbar);
        
        // Create text view with scrolling
        // Note: For a complete implementation, we'd need TextView and ScrolledWindow wrappers
        // This is a simplified example showing the structure
        
        auto textLabel = new Label("Text content would appear here...");
        textLabel.text = "Click Open to load a file, or start typing...";
        mainBox.append(textLabel);
        
        // Connect button signals
        openButton.onClicked(() {
            writeln("Open file dialog would appear here");
            // In a complete implementation:
            // - Show file chooser dialog
            // - Load file content
            // - Display in text view
        });
        
        saveButton.onClicked(() {
            writeln("Save file dialog would appear here");
            // In a complete implementation:
            // - Show file chooser dialog
            // - Save text view content to file
        });
        
        clearButton.onClicked(() {
            writeln("Clearing text");
            textLabel.text = "";
        });
        
        window.setChild(mainBox);
        window.present();
    });
    
    app.run(args);
}
