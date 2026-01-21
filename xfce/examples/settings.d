/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	XFCE Settings Editor - demonstrates xfconf configuration system
**********************************************************************************************************/
import uim.xfce;
import std.stdio;

void main(string[] args) {
    initGTK();
    initXfconf();
    
    auto app = new Application("org.example.xfce-settings");
    
    app.connectSignal("activate", () {
        // Create titled dialog (XFCE-style)
        auto dialog = new TitledDialog("XFCE Settings Demo", null);
        dialog.setSubtitle("Configure application settings using xfconf");
        
        // Get window from dialog
        import uim.gnome.c.gtk : gtk_window_set_default_size, GTK_WINDOW;
        gtk_window_set_default_size(cast(GTK_WINDOW)dialog.cHandle(), 600, 400);
        
        // Create content area
        auto box = new Box(Orientation.Vertical, 15);
        box.setMarginTop(20);
        box.setMarginBottom(20);
        box.setMarginStart(20);
        box.setMarginEnd(20);
        
        // Instructions
        auto infoLabel = new Label();
        infoLabel.setMarkup("<b>Configuration Manager</b>\n\n" ~
                          "This demonstrates XFCE's configuration system (xfconf).\n" ~
                          "Settings are automatically saved and persisted.");
        box.append(infoLabel);
        
        // Get configuration channel
        auto channel = new Channel("xfce-settings-demo");
        
        // Theme setting
        auto themeBox = new Box(Orientation.Horizontal, 10);
        auto themeLabel = new Label("Theme:");
        themeLabel.setWidthChars(15);
        themeBox.append(themeLabel);
        
        auto themeEntry = new Entry();
        themeEntry.text = channel.getString("/appearance/theme", "default");
        themeEntry.placeholderText = "Enter theme name...";
        themeBox.append(themeEntry);
        box.append(themeBox);
        
        // Font size setting
        auto fontBox = new Box(Orientation.Horizontal, 10);
        auto fontLabel = new Label("Font Size:");
        fontLabel.setWidthChars(15);
        fontBox.append(fontLabel);
        
        auto fontEntry = new Entry();
        import std.conv : to;
        fontEntry.text = channel.getInt("/appearance/font-size", 10).to!string;
        fontEntry.placeholderText = "Font size...";
        fontBox.append(fontEntry);
        box.append(fontBox);
        
        // Enable notifications
        auto notifyBox = new Box(Orientation.Horizontal, 10);
        auto notifyLabel = new Label("Notifications:");
        notifyLabel.setWidthChars(15);
        notifyBox.append(notifyLabel);
        
        auto notifyCheck = new CheckButton();
        notifyCheck.active = channel.getBool("/behavior/notifications", true);
        notifyBox.append(notifyCheck);
        box.append(notifyBox);
        
        // Auto-save setting
        auto autoSaveBox = new Box(Orientation.Horizontal, 10);
        auto autoSaveLabel = new Label("Auto-save:");
        autoSaveLabel.setWidthChars(15);
        autoSaveBox.append(autoSaveLabel);
        
        auto autoSaveCheck = new CheckButton();
        autoSaveCheck.active = channel.getBool("/behavior/auto-save", false);
        autoSaveBox.append(autoSaveCheck);
        box.append(autoSaveBox);
        
        // Recent files limit
        auto recentBox = new Box(Orientation.Horizontal, 10);
        auto recentLabel = new Label("Recent Files:");
        recentLabel.setWidthChars(15);
        recentBox.append(recentLabel);
        
        auto recentEntry = new Entry();
        recentEntry.text = channel.getInt("/behavior/recent-limit", 10).to!string;
        recentEntry.placeholderText = "Number of recent files...";
        recentBox.append(recentEntry);
        box.append(recentBox);
        
        // Buttons
        auto buttonBox = new Box(Orientation.Horizontal, 10);
        buttonBox.setHalign(Align.Center);
        
        // Save button
        auto saveButton = new Button("Save Settings");
        saveButton.onClicked(() {
            import std.conv : to;
            
            // Save all settings
            channel.setString("/appearance/theme", themeEntry.text);
            
            try {
                channel.setInt("/appearance/font-size", fontEntry.text.to!int);
            } catch (Exception e) {
                writeln("Invalid font size, using default");
            }
            
            channel.setBool("/behavior/notifications", notifyCheck.active);
            channel.setBool("/behavior/auto-save", autoSaveCheck.active);
            
            try {
                channel.setInt("/behavior/recent-limit", recentEntry.text.to!int);
            } catch (Exception e) {
                writeln("Invalid recent limit, using default");
            }
            
            writeln("Settings saved to xfconf");
            showInfo(null, "Settings Saved", "Your configuration has been saved successfully!");
        });
        buttonBox.append(saveButton);
        
        // Reset button
        auto resetButton = new Button("Reset to Defaults");
        resetButton.onClicked(() {
            if (confirm(null, "Reset all settings to defaults?", 
                       "This will remove all custom settings.")) {
                // Reset all properties
                channel.resetProperty("/appearance", true);
                channel.resetProperty("/behavior", true);
                
                // Update UI
                themeEntry.text = "default";
                fontEntry.text = "10";
                notifyCheck.active = true;
                autoSaveCheck.active = false;
                recentEntry.text = "10";
                
                writeln("Settings reset to defaults");
                showInfo(null, "Settings Reset", "All settings have been reset to defaults.");
            }
        });
        buttonBox.append(resetButton);
        
        // List channels button
        auto listButton = new Button("List All Channels");
        listButton.onClicked(() {
            auto channels = listChannels();
            writeln("Available xfconf channels:");
            foreach (ch; channels) {
                writeln("  - ", ch);
            }
            showInfo(null, "Channel List", 
                    "Found " ~ channels.length.to!string ~ " configuration channels.\n" ~
                    "Check console for details.");
        });
        buttonBox.append(listButton);
        
        // Close button
        auto closeButton = new Button("Close");
        closeButton.onClicked(() {
            import uim.gnome.c.gtk : gtk_window_close, GTK_WINDOW;
            gtk_window_close(cast(GTK_WINDOW)dialog.cHandle());
        });
        buttonBox.append(closeButton);
        
        box.append(buttonBox);
        
        // Add content to dialog
        import uim.gnome.c.gtk : gtk_window_set_child, GTK_WINDOW;
        gtk_window_set_child(cast(GTK_WINDOW)dialog.cHandle(), box.cHandle());
        
        // Center and show
        centerOnActiveScreen(null);
        dialog.show();
    });
    
    app.run(args);
    shutdownXfconf();
}
