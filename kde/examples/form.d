/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	Example: Form Application
**********************************************************************************************************/
import uim.kde;
import std.stdio;

void main(string[] args) {
    auto app = new Application(args);
    
    CoreApplication.applicationName = "Qt Form Example";
    
    auto window = new MainWindow();
    window.windowTitle = "Registration Form";
    window.resize(400, 300);
    
    auto centralWidget = new Widget();
    auto layout = new VBoxLayout();
    
    // Title
    auto titleLabel = new Label("User Registration");
    layout.addWidget(titleLabel);
    
    layout.addSpacing(20);
    
    // Name field
    auto nameLabel = new Label("Name:");
    layout.addWidget(nameLabel);
    auto nameEdit = new LineEdit();
    nameEdit.placeholderText = "Enter your name";
    layout.addWidget(nameEdit);
    
    // Email field
    auto emailLabel = new Label("Email:");
    layout.addWidget(emailLabel);
    auto emailEdit = new LineEdit();
    emailEdit.placeholderText = "your@email.com";
    layout.addWidget(emailEdit);
    
    // Checkbox
    auto newsCheckbox = new CheckBox("Subscribe to newsletter");
    layout.addWidget(newsCheckbox);
    
    layout.addSpacing(10);
    
    // Buttons
    auto buttonLayout = new HBoxLayout();
    auto submitButton = new PushButton("Submit");
    auto clearButton = new PushButton("Clear");
    
    buttonLayout.addWidget(submitButton);
    buttonLayout.addWidget(clearButton);
    buttonLayout.addStretch();
    
    // Note: In full implementation, buttons would be connected to handlers
    writeln("Form example - close window to exit");
    
    centralWidget.widgetHandle.qt_QWidget_setLayout(layout.handle);
    window.setCentralWidget(centralWidget);
    window.show();
    
    app.exec();
}
