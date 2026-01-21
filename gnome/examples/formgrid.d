/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
	
	Example: Form with Grid Layout
**********************************************************************************************************/
import uim.gnome;
import std.stdio;

void main(string[] args) {
    initGTK();
    
    auto app = new Application("org.example.formgrid");
    
    app.connectSignal("activate", () {
        auto window = new Window();
        window.title = "Registration Form";
        window.setDefaultSize(500, 400);
        
        // Create main container
        auto mainBox = new Box(GTK_ORIENTATION_VERTICAL, 20);
        
        // Title
        auto titleLabel = new Label("User Registration");
        titleLabel.setMarkup("<span size='x-large' weight='bold'>User Registration</span>");
        mainBox.append(titleLabel);
        
        // Create grid for form
        auto grid = new Grid();
        grid.rowSpacing = 10;
        grid.columnSpacing = 10;
        
        // First Name
        grid.attach(new Label("First Name:"), 0, 0);
        auto firstNameEntry = new Entry();
        firstNameEntry.placeholderText = "Enter first name";
        grid.attach(firstNameEntry, 1, 0);
        
        // Last Name
        grid.attach(new Label("Last Name:"), 0, 1);
        auto lastNameEntry = new Entry();
        lastNameEntry.placeholderText = "Enter last name";
        grid.attach(lastNameEntry, 1, 1);
        
        // Email
        grid.attach(new Label("Email:"), 0, 2);
        auto emailEntry = new Entry();
        emailEntry.placeholderText = "user@example.com";
        grid.attach(emailEntry, 1, 2);
        
        // Username
        grid.attach(new Label("Username:"), 0, 3);
        auto usernameEntry = new Entry();
        usernameEntry.placeholderText = "Choose a username";
        grid.attach(usernameEntry, 1, 3);
        
        mainBox.append(grid);
        
        // Buttons
        auto buttonBox = new Box(GTK_ORIENTATION_HORIZONTAL, 10);
        
        auto submitButton = new Button("Submit");
        submitButton.onClicked(() {
            writeln("\n=== Registration Data ===");
            writefln("First Name: %s", firstNameEntry.text);
            writefln("Last Name: %s", lastNameEntry.text);
            writefln("Email: %s", emailEntry.text);
            writefln("Username: %s", usernameEntry.text);
            writeln("========================\n");
        });
        
        auto clearButton = new Button("Clear");
        clearButton.onClicked(() {
            firstNameEntry.text = "";
            lastNameEntry.text = "";
            emailEntry.text = "";
            usernameEntry.text = "";
            writeln("Form cleared!");
        });
        
        buttonBox.append(submitButton);
        buttonBox.append(clearButton);
        
        mainBox.append(buttonBox);
        
        window.setChild(mainBox);
        window.present();
    });
    
    app.run(args);
}
