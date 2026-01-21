/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	XFCE Resource Browser - demonstrates resource lookup and utility functions
**********************************************************************************************************/
import uim.xfce;
import std.stdio;

void main(string[] args) {
    initGTK();
    
    auto app = new Application("org.example.xfce-resources");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "XFCE Resource Browser";
        window.setDefaultSize(700, 500);
        
        auto box = new Box(Orientation.Vertical, 10);
        box.setMarginTop(15);
        box.setMarginBottom(15);
        box.setMarginStart(15);
        box.setMarginEnd(15);
        
        // Header
        auto headerLabel = new Label();
        headerLabel.setMarkup("<span size='x-large' weight='bold'>XFCE Resource Browser</span>");
        box.append(headerLabel);
        
        // System Information
        auto sysFrame = new Frame("System Information");
        auto sysBox = new Box(Orientation.Vertical, 5);
        sysBox.setMarginTop(10);
        sysBox.setMarginBottom(10);
        sysBox.setMarginStart(10);
        sysBox.setMarginEnd(10);
        
        sysBox.append(new Label("XFCE Version: " ~ getVersionString()));
        sysBox.append(new Label("Home Directory: " ~ getHomeDir()));
        sysBox.append(new Label("User Config Dir: " ~ getUserDir()));
        
        auto languages = getLanguageNames();
        if (languages.length > 0) {
            sysBox.append(new Label("Languages: " ~ languages[0]));
        }
        
        sysFrame.setChild(sysBox);
        box.append(sysFrame);
        
        // Resource Lookup
        auto resFrame = new Frame("Resource Locations");
        auto resBox = new Box(Orientation.Vertical, 5);
        resBox.setMarginTop(10);
        resBox.setMarginBottom(10);
        resBox.setMarginStart(10);
        resBox.setMarginEnd(10);
        
        // Data directory
        auto dataLoc = resourceSaveLocation(ResourceType.Data, "");
        resBox.append(new Label("Data: " ~ dataLoc));
        
        // Config directory
        auto configLoc = resourceSaveLocation(ResourceType.Config, "");
        resBox.append(new Label("Config: " ~ configLoc));
        
        // Cache directory
        auto cacheLoc = resourceSaveLocation(ResourceType.Cache, "");
        resBox.append(new Label("Cache: " ~ cacheLoc));
        
        resFrame.setChild(resBox);
        box.append(resFrame);
        
        // Localized Directories
        auto dirFrame = new Frame("Localized Directory Names");
        auto dirBox = new Box(Orientation.Vertical, 5);
        dirBox.setMarginTop(10);
        dirBox.setMarginBottom(10);
        dirBox.setMarginStart(10);
        dirBox.setMarginEnd(10);
        
        string[] commonDirs = ["Desktop", "Documents", "Downloads", "Music", 
                               "Pictures", "Videos", "Templates", "Public"];
        
        foreach (dir; commonDirs) {
            auto localized = getDirLocalized(dir);
            dirBox.append(new Label(dir ~ " → " ~ localized));
        }
        
        dirFrame.setChild(dirBox);
        box.append(dirFrame);
        
        // Action buttons
        auto btnBox = new Box(Orientation.Horizontal, 10);
        btnBox.setHalign(Align.Center);
        
        // Test variable expansion
        auto expandBtn = new Button("Test Variable Expansion");
        expandBtn.onClicked(() {
            auto testCommands = [
                "$HOME/test.txt",
                "$USER is the user",
                "Path: $PATH"
            ];
            
            writeln("\nVariable Expansion Test:");
            foreach (cmd; testCommands) {
                auto expanded = expandVariables(cmd);
                writeln("  ", cmd, " → ", expanded);
            }
            
            showInfo(window, "Variable Expansion", 
                    "Variables have been expanded.\nCheck console for results.");
        });
        btnBox.append(expandBtn);
        
        // Launch command
        auto launchBtn = new Button("Launch Terminal");
        launchBtn.onClicked(() {
            if (spawnCommand("xfce4-terminal", false, true)) {
                writeln("Launched terminal successfully");
            } else {
                showWarning(window, "Could not launch terminal", 
                           "Make sure xfce4-terminal is installed.");
            }
        });
        btnBox.append(launchBtn);
        
        // Test kiosk mode
        auto kioskBtn = new Button("Check Kiosk Mode");
        kioskBtn.onClicked(() {
            auto kiosk = new Kiosk("xfce4-panel");
            
            writeln("\nKiosk Mode Check:");
            writeln("  Panel customization allowed: ", kiosk.query("CustomizePanel"));
            writeln("  Adding applets allowed: ", kiosk.query("AddApplets"));
            
            showInfo(window, "Kiosk Mode", 
                    "Kiosk mode capabilities checked.\nSee console for details.");
        });
        btnBox.append(kioskBtn);
        
        // Close button
        auto closeBtn = new Button("Close");
        closeBtn.onClicked(() {
            window.close();
        });
        btnBox.append(closeBtn);
        
        box.append(btnBox);
        
        window.setChild(box);
        centerOnActiveScreen(window);
        window.present();
    });
    
    app.run(args);
}
