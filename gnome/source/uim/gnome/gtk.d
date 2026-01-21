/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.gtk;

/**
 * D wrappers for GTK functionality
 * Provides idiomatic D interfaces to GTK C functions
 */

public import uim.gnome.c.gtk;
public import uim.gnome.gobject;
public import uim.gnome.types;

/**
 * Initialize GTK
 */
void initGTK() @trusted {
    gtk_init();
}

/**
 * Base widget wrapper
 */
class Widget : GObjectWrapper {
    this(GtkWidget* widget) @safe pure nothrow @nogc {
        super(cast(GObject*)widget);
    }
    
    @property GtkWidget* gtkWidget() @safe pure nothrow @nogc {
        return cast(GtkWidget*)_gobject;
    }
    
    void show() @trusted {
        gtk_widget_show(gtkWidget);
    }
    
    void hide() @trusted {
        gtk_widget_hide(gtkWidget);
    }
    
    @property bool visible() @trusted {
        return fromGBoolean(gtk_widget_get_visible(gtkWidget));
    }
    
    @property void visible(bool value) @trusted {
        gtk_widget_set_visible(gtkWidget, toGBoolean(value));
    }
    
    @property bool sensitive() @trusted {
        return fromGBoolean(gtk_widget_get_sensitive(gtkWidget));
    }
    
    @property void sensitive(bool value) @trusted {
        gtk_widget_set_sensitive(gtkWidget, toGBoolean(value));
    }
    
    void setSizeRequest(int width, int height) @trusted {
        gtk_widget_set_size_request(gtkWidget, width, height);
    }
}

/**
 * Window wrapper
 */
class Window : Widget {
    this() @trusted {
        super(gtk_window_new());
    }
    
    @property GtkWindow* gtkWindow() @safe pure nothrow @nogc {
        return cast(GtkWindow*)_gobject;
    }
    
    @property string title() @trusted {
        return fromGString(gtk_window_get_title(gtkWindow));
    }
    
    @property void title(string value) @trusted {
        gtk_window_set_title(gtkWindow, toGString(value));
    }
    
    void setDefaultSize(int width, int height) @trusted {
        gtk_window_set_default_size(gtkWindow, width, height);
    }
    
    void setChild(Widget child) @trusted {
        gtk_window_set_child(gtkWindow, child.gtkWidget);
    }
    
    void present() @trusted {
        gtk_window_present(gtkWindow);
    }
    
    void close() @trusted {
        gtk_window_close(gtkWindow);
    }
}

/**
 * Application wrapper
 */
class Application : GObjectWrapper {
    this(string applicationId, GApplicationFlags flags = G_APPLICATION_FLAGS_NONE) @trusted {
        auto app = gtk_application_new(toGString(applicationId), flags);
        super(cast(GObject*)app);
    }
    
    @property GtkApplication* gtkApplication() @safe pure nothrow @nogc {
        return cast(GtkApplication*)_gobject;
    }
    
    int run(string[] args) @trusted {
        import core.stdc.stdlib : malloc, free;
        import core.stdc.string : strlen;
        
        // Convert D args to C args
        char** cArgs = cast(char**)malloc(char*.sizeof * args.length);
        foreach (i, arg; args) {
            cArgs[i] = cast(char*)toGString(arg);
        }
        
        int result = g_application_run(gtkApplication, cast(int)args.length, cArgs);
        
        free(cArgs);
        return result;
    }
    
    void quit() @trusted {
        g_application_quit(gtkApplication);
    }
}

/**
 * Button wrapper
 */
class Button : Widget {
    this(string label = "") @trusted {
        if (label.length > 0) {
            super(gtk_button_new_with_label(toGString(label)));
        } else {
            super(gtk_button_new());
        }
    }
    
    @property GtkButton* gtkButton() @safe pure nothrow @nogc {
        return cast(GtkButton*)_gobject;
    }
    
    @property string label() @trusted {
        return fromGString(gtk_button_get_label(gtkButton));
    }
    
    @property void label(string value) @trusted {
        gtk_button_set_label(gtkButton, toGString(value));
    }
    
    ulong onClicked(void delegate() callback) @trusted {
        return connectSignal("clicked", callback);
    }
}

/**
 * Label wrapper
 */
class Label : Widget {
    this(string text = "") @trusted {
        super(gtk_label_new(toGString(text)));
    }
    
    @property GtkLabel* gtkLabel() @safe pure nothrow @nogc {
        return cast(GtkLabel*)_gobject;
    }
    
    @property string text() @trusted {
        return fromGString(gtk_label_get_text(gtkLabel));
    }
    
    @property void text(string value) @trusted {
        gtk_label_set_text(gtkLabel, toGString(value));
    }
    
    void setMarkup(string markup) @trusted {
        gtk_label_set_markup(gtkLabel, toGString(markup));
    }
}

/**
 * Entry (text input) wrapper
 */
class Entry : Widget {
    this() @trusted {
        super(gtk_entry_new());
    }
    
    @property GtkEntry* gtkEntry() @safe pure nothrow @nogc {
        return cast(GtkEntry*)_gobject;
    }
    
    @property string text() @trusted {
        return fromGString(gtk_entry_get_text(gtkEntry));
    }
    
    @property void text(string value) @trusted {
        gtk_entry_set_text(gtkEntry, toGString(value));
    }
    
    @property string placeholderText() @trusted {
        return fromGString(gtk_entry_get_placeholder_text(gtkEntry));
    }
    
    @property void placeholderText(string value) @trusted {
        gtk_entry_set_placeholder_text(gtkEntry, toGString(value));
    }
}

/**
 * Box container wrapper
 */
class Box : Widget {
    this(GtkOrientation orientation, int spacing = 0) @trusted {
        super(gtk_box_new(orientation, spacing));
    }
    
    @property GtkBox* gtkBox() @safe pure nothrow @nogc {
        return cast(GtkBox*)_gobject;
    }
    
    void append(Widget child) @trusted {
        gtk_box_append(gtkBox, child.gtkWidget);
    }
    
    void prepend(Widget child) @trusted {
        gtk_box_prepend(gtkBox, child.gtkWidget);
    }
    
    void remove(Widget child) @trusted {
        gtk_box_remove(gtkBox, child.gtkWidget);
    }
}

/**
 * Grid container wrapper
 */
class Grid : Widget {
    this() @trusted {
        super(gtk_grid_new());
    }
    
    @property GtkGrid* gtkGrid() @safe pure nothrow @nogc {
        return cast(GtkGrid*)_gobject;
    }
    
    void attach(Widget child, int column, int row, int width = 1, int height = 1) @trusted {
        gtk_grid_attach(gtkGrid, child.gtkWidget, column, row, width, height);
    }
    
    void remove(Widget child) @trusted {
        gtk_grid_remove(gtkGrid, child.gtkWidget);
    }
    
    @property void rowSpacing(uint spacing) @trusted {
        gtk_grid_set_row_spacing(gtkGrid, spacing);
    }
    
    @property void columnSpacing(uint spacing) @trusted {
        gtk_grid_set_column_spacing(gtkGrid, spacing);
    }
}
