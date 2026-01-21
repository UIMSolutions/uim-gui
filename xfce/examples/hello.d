/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	Simple XFCE application demonstrating basic functionality
**********************************************************************************************************/
import uim.xfce;
import std.stdio;

void main(string[] args) {
    // Initialize GTK and xfconf
    initGTK();
    initXfconf();
    
    // Create application
    auto app = new Application("org.example.xfce-hello");
    
    app.connectSignal("activate", () {
        // Create main window
        auto window = new Window();
        window.title = "Hello XFCE!";
        window.setDefaultSize(500, 350);
        
        // Create layout
        auto box = new Box(Orientation.Vertical, 10);
        box.setMarginTop(20);
        box.setMarginBottom(20);
        box.setMarginStart(20);
        box.setMarginEnd(20);
        
        // Welcome label
        auto welcomeLabel = new Label("Welcome to XFCE with D!");
        welcomeLabel.setMarkup("<span size='large' weight='bold'>Welcome to XFCE with D!</span>");
        box.append(welcomeLabel);
        
        // Version info
        auto versionLabel = new Label("XFCE Version: " ~ getVersionString());
        box.append(versionLabel);
        
        // Home directory
        auto homeLabel = new Label("Home Directory: " ~ getHomeDir());
        box.append(homeLabel);
        
        // Language
        auto languages = getLanguageNames();
        if (languages.length > 0) {
            auto langLabel = new Label("Primary Language: " ~ languages[0]);
            box.append(langLabel);
        }
        
        // Configuration demo button
        auto configButton = new Button("Test Configuration");
        configButton.onClicked(() {
            // Create or get a config channel
            auto channel = new Channel("xfce-d-test");
            
            // Store some test values
            channel.setString("/test/message", "Hello from D!");
            channel.setInt("/test/counter", 42);
            channel.setBool("/test/enabled", true);
            
            // Read them back
            auto message = channel.getString("/test/message");
            auto counter = channel.getInt("/test/counter");
            auto enabled = channel.getBool("/test/enabled");
            
            writeln("Configuration test:");
            writeln("  Message: ", message);
            writeln("  Counter: ", counter);
            writeln("  Enabled: ", enabled);
            
            showInfo(window, "Configuration Saved", 
                    "Test configuration has been saved to xfconf.");
        });
        box.append(configButton);
        
        // Show info dialog button
        auto infoButton = new Button("Show Info Dialog");
        infoButton.onClicked(() {
            showInfo(window, "This is an XFCE-style information dialog!", 
                    "Additional details can be shown here.");
        });
        box.append(infoButton);
        
        // Show warning dialog button
        auto warnButton = new Button("Show Warning Dialog");
        warnButton.onClicked(() {
            showWarning(window, "This is an XFCE-style warning!", 
                       "Please be careful with this action.");
        });
        box.append(warnButton);
        
        // Confirm dialog button
        auto confirmButton = new Button("Show Confirm Dialog");
        confirmButton.onClicked(() {
            if (confirm(window, "Do you want to proceed?", 
                       "This will perform an important action.")) {
                writeln("User confirmed the action");
                showInfo(window, "Confirmed", "You clicked Yes!");
            } else {
                writeln("User cancelled the action");
            }
        });
        box.append(confirmButton);
        
        // Quit button
        auto quitButton = new Button("Quit");
        quitButton.onClicked(() {
            window.close();
        });
        box.append(quitButton);
        
        // Set up window
        window.setChild(box);
        
        // Center on screen
        centerOnActiveScreen(window);
        
        window.present();
    });
    
    // Run application
    auto exitCode = app.run(args);
    
    // Cleanup
    shutdownXfconf();
}
