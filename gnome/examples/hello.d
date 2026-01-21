/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	Example: Simple Hello World GTK Application
**********************************************************************************************************/
import uim.gnome;
import std.stdio;

void main(string[] args) {
    // Initialize GTK
    initGTK();
    
    // Create application
    auto app = new Application("org.example.hello", G_APPLICATION_FLAGS_NONE);
    
    // Connect to the activate signal
    app.connectSignal("activate", () {
        writeln("Application activated!");
        
        // Create main window
        auto window = new Window();
        window.title = "Hello GNOME from D!";
        window.setDefaultSize(400, 300);
        
        // Create a vertical box container
        auto vbox = new Box(GTK_ORIENTATION_VERTICAL, 20);
        
        // Add a header label
        auto headerLabel = new Label("Welcome to GNOME with D!");
        headerLabel.setMarkup("<span size='xx-large' weight='bold'>Welcome to GNOME with D!</span>");
        vbox.append(headerLabel);
        
        // Add a description label
        auto descLabel = new Label("This is a simple GTK application written in D using uim-gnome library.");
        vbox.append(descLabel);
        
        // Add a button
        auto button = new Button("Click Me!");
        uint clickCount = 0;
        button.onClicked(() {
            clickCount++;
            writefln("Button clicked %d times!", clickCount);
            button.label = format("Clicked %d times!", clickCount);
        });
        vbox.append(button);
        
        // Add a quit button
        auto quitButton = new Button("Quit");
        quitButton.onClicked(() {
            writeln("Quitting application...");
            window.close();
        });
        vbox.append(quitButton);
        
        // Set the box as the window's child
        window.setChild(vbox);
        
        // Show the window
        window.present();
    });
    
    // Run the application
    int status = app.run(args);
    writefln("Application exited with status: %d", status);
}
