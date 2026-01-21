/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.ui;

import uim.xfce.c.libxfce4ui;
import uim.xfce.c.libxfce4util;
import uim.gnome; // XFCE UI is built on GTK
import std.string : toStringz, fromStringz;

/**
 * XFCE Titled Dialog
 * 
 * A dialog with a title area (title + optional subtitle) and content area.
 * Common pattern in XFCE applications.
 */
class TitledDialog {
    private XfceTitledDialog* _dialog;
    private bool _owned = true;

    /**
     * Create a new titled dialog
     */
    this() {
        auto widget = xfce_titled_dialog_new();
        _dialog = cast(XfceTitledDialog*)widget;
    }

    /**
     * Create a titled dialog with buttons
     * Params:
     *   title = Dialog title
     *   parent = Parent window (can be null)
     */
    this(string title, Window parent = null) {
        import uim.gnome.c.gtk : GtkDialogFlags;
        auto parentWidget = parent ? parent.cHandle() : null;
        auto widget = xfce_titled_dialog_new_with_buttons(
            toStringz(title),
            cast(GtkWindow*)parentWidget,
            GtkDialogFlags.GTK_DIALOG_MODAL | GtkDialogFlags.GTK_DIALOG_DESTROY_WITH_PARENT,
            null
        );
        _dialog = cast(XfceTitledDialog*)widget;
    }

    ~this() {
        // Dialog is a GTK widget, managed by GTK's reference counting
    }

    /**
     * Set the dialog subtitle
     */
    void setSubtitle(string subtitle) {
        xfce_titled_dialog_set_subtitle(_dialog, toStringz(subtitle));
    }

    /**
     * Get the dialog subtitle
     */
    string getSubtitle() {
        auto cstr = xfce_titled_dialog_get_subtitle(_dialog);
        if (cstr is null) return "";
        return fromStringz(cstr).idup;
    }

    /**
     * Show the dialog
     */
    void show() {
        import uim.gnome.c.gtk : gtk_widget_show;
        gtk_widget_show(cast(GtkWidget*)_dialog);
    }

    /**
     * Get the underlying GTK widget pointer
     */
    GtkWidget* cHandle() {
        return cast(GtkWidget*)_dialog;
    }
}

/**
 * Show an XFCE-style information dialog
 * Params:
 *   parent = Parent window (can be null)
 *   primary = Primary message text
 *   secondary = Secondary message text (can be null)
 */
void showInfo(Window parent, string primary, string secondary = null) {
    import core.stdc.stdarg : va_list;
    auto parentWidget = parent ? cast(GtkWindow*)parent.cHandle() : null;
    
    if (secondary) {
        xfce_dialog_show_info(parentWidget, toStringz(secondary), toStringz(primary));
    } else {
        xfce_dialog_show_info(parentWidget, null, toStringz(primary));
    }
}

/**
 * Show an XFCE-style warning dialog
 */
void showWarning(Window parent, string primary, string secondary = null) {
    auto parentWidget = parent ? cast(GtkWindow*)parent.cHandle() : null;
    
    if (secondary) {
        xfce_dialog_show_warning(parentWidget, toStringz(secondary), toStringz(primary));
    } else {
        xfce_dialog_show_warning(parentWidget, null, toStringz(primary));
    }
}

/**
 * Show an XFCE-style error dialog
 */
void showError(Window parent, string primary, string secondary = null) {
    auto parentWidget = parent ? cast(GtkWindow*)parent.cHandle() : null;
    
    if (secondary) {
        xfce_dialog_show_error(parentWidget, toStringz(secondary), toStringz(primary));
    } else {
        xfce_dialog_show_error(parentWidget, null, toStringz(primary));
    }
}

/**
 * Show a confirmation dialog
 * Returns: true if user confirmed, false otherwise
 */
bool confirm(Window parent, string primary, string secondary = null, string confirmLabel = "Confirm") {
    import uim.gnome.c.gtk : GtkResponseType;
    auto parentWidget = parent ? cast(GtkWindow*)parent.cHandle() : null;
    
    auto response = xfce_dialog_confirm(
        parentWidget,
        null, // stock_id
        toStringz(confirmLabel),
        secondary ? toStringz(secondary) : null,
        toStringz(primary)
    );
    
    return response == GtkResponseType.GTK_RESPONSE_YES || 
           response == GtkResponseType.GTK_RESPONSE_OK;
}

/**
 * Show a file name input dialog
 * Params:
 *   title = Dialog title
 *   message = Message to display
 *   defaultFilename = Default filename
 *   parent = Parent window
 * Returns: Selected filename, or null if cancelled
 */
string filenameInput(string title, string message, string defaultFilename = "", Window parent = null) {
    auto parentWidget = parent ? cast(GtkWindow*)parent.cHandle() : null;
    
    auto cstr = xfce_filename_input_dialog(
        toStringz(title),
        toStringz(message),
        toStringz(defaultFilename),
        parentWidget
    );
    
    if (cstr is null) return null;
    return fromStringz(cstr).idup;
}

/**
 * Spawn a command on a specific screen
 * Params:
 *   command = Command to execute
 *   inTerminal = Whether to run in a terminal
 *   startupNotify = Whether to use startup notification
 * Returns: true on success
 */
bool spawnCommand(string command, bool inTerminal = false, bool startupNotify = true) {
    import uim.gnome.c.glib : GError;
    import uim.gnome.c.gdk : gdk_screen_get_default;
    
    GError* error = null;
    auto screen = gdk_screen_get_default();
    
    auto result = xfce_spawn_command_line_on_screen(
        screen,
        toStringz(command),
        inTerminal ? 1 : 0,
        startupNotify ? 1 : 0,
        &error
    );
    
    return result != 0;
}

/**
 * Center a window on the active screen
 */
void centerOnActiveScreen(Window window) {
    xfce_gtk_window_center_on_active_screen(cast(GtkWindow*)window.cHandle());
}

/**
 * Get icon name from desktop ID
 * Params:
 *   desktopId = Desktop file ID (e.g., "xfce4-terminal")
 * Returns: Icon name
 */
string iconNameFromDesktopId(string desktopId) {
    auto cstr = xfce_icon_name_from_desktop_id(toStringz(desktopId));
    if (cstr is null) return "";
    return fromStringz(cstr).idup;
}
