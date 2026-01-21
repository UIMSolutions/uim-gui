/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	Example: Simple Hello World Qt Application
**********************************************************************************************************/
import uim.kde;
import std.stdio;

void main(string[] args) {
    // Create Qt application
    auto app = new Application(args);
    
    // Set application properties
    CoreApplication.applicationName = "Hello Qt";
    CoreApplication.applicationVersion = "1.0";
    
    // Create main window
    auto window = new MainWindow();
    window.windowTitle = "Hello KDE/Qt from D!";
    window.resize(400, 300);
    
    // Create central widget and layout
    auto centralWidget = new Widget();
    auto layout = new VBoxLayout();
    
    // Create and add widgets
    auto label = new Label("Welcome to KDE/Qt with D!");
    label.wordWrap = true;
    layout.addWidget(label);
    
    auto button = new PushButton("Click Me!");
    layout.addWidget(button);
    
    auto infoLabel = new Label("Button not clicked yet");
    layout.addWidget(infoLabel);
    
    layout.addStretch();
    
    // Note: Full signal/slot support would require MOC integration
    // This is a placeholder for the intended API
    writeln("Application started. Close window to exit.");
    
    // Set layout and show
    centralWidget.widgetHandle.qt_QWidget_setLayout(layout.handle);
    window.setCentralWidget(centralWidget);
    window.show();
    
    // Run event loop
    int result = app.exec();
    writefln("Application exited with code: %d", result);
}
