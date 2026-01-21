/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.c.libxfce4ui;

import core.stdc.config;
import uim.xfce.c.libxfce4util;

extern(C):

// GTK forward declarations
struct GtkWidget;
struct GtkWindow;
struct GdkScreen;
struct GdkPixbuf;

/**
 * XfceTitledDialog: Dialog with title and subtitle
 */
struct XfceTitledDialog;

GType xfce_titled_dialog_get_type();
GtkWidget* xfce_titled_dialog_new();
GtkWidget* xfce_titled_dialog_new_with_buttons(const(gchar)* title, GtkWindow* parent, int flags, const(gchar)* first_button_text, ...);
GtkWidget* xfce_titled_dialog_new_with_mixed_buttons(const(gchar)* title, GtkWindow* parent, int flags, const(gchar)* first_button_icon_name, const(gchar)* first_button_text, ...);

void xfce_titled_dialog_set_subtitle(XfceTitledDialog* dialog, const(gchar)* subtitle);
const(gchar)* xfce_titled_dialog_get_subtitle(XfceTitledDialog* dialog);

/**
 * Xfce Dialogs
 */
void xfce_dialog_show_help(GtkWindow* parent, const(gchar)* component, const(gchar)* page, const(gchar)* offset);
void xfce_dialog_show_help_with_version(GtkWindow* parent, const(gchar)* component, const(gchar)* page, const(gchar)* offset, const(gchar)* version);

gint xfce_message_dialog(GtkWindow* parent, const(gchar)* title, const(gchar)* icon_name, const(gchar)* primary_text, const(gchar)* secondary_text, const(gchar)* first_button_text, ...);

void xfce_dialog_show_info(GtkWindow* parent, const(gchar)* secondary_text, const(gchar)* primary_format, ...);
void xfce_dialog_show_warning(GtkWindow* parent, const(gchar)* secondary_text, const(gchar)* primary_format, ...);
void xfce_dialog_show_error(GtkWindow* parent, const(gchar)* secondary_text, const(gchar)* primary_format, ...);
gint xfce_dialog_confirm(GtkWindow* parent, const(gchar)* stock_id, const(gchar)* confirm_label, const(gchar)* secondary_text, const(gchar)* primary_format, ...);

/**
 * Xfce Spawn Functions
 */
gboolean xfce_spawn_on_screen(GdkScreen* screen, const(gchar)* working_directory, gchar** argv, gchar** envp, int flags, gboolean startup_notify, guint32 startup_timestamp, const(gchar)* startup_icon_name, GError** error);

gboolean xfce_spawn_command_line_on_screen(GdkScreen* screen, const(gchar)* command_line, gboolean in_terminal, gboolean startup_notify, GError** error);

/**
 * Xfce GTK Extensions
 */
void xfce_gtk_menu_item_set_accel_label(GtkWidget* menu_item, const(gchar)* accel_label);
GtkWidget* xfce_gtk_image_menu_item_new(const(gchar)* label, const(gchar)* tooltip_text, const(gchar)* accel_path, void* callback, gpointer user_data, GtkWidget* menu);
GtkWidget* xfce_gtk_image_menu_item_new_from_icon_name(const(gchar)* label, const(gchar)* tooltip_text, const(gchar)* accel_path, void* callback, gpointer user_data, const(gchar)* icon_name, GtkWidget* menu);

void xfce_gtk_button_new_mixed(const(gchar)* icon_name, const(gchar)* label);
GtkWidget* xfce_gtk_frame_box_new(const(gchar)* label, GtkWidget** container_return);
void xfce_gtk_window_center_on_active_screen(GtkWindow* window);

/**
 * Xfce File Dialog
 */
gchar* xfce_filename_input_dialog(const(gchar)* title, const(gchar)* message, const(gchar)* default_filename, GtkWindow* parent);

/**
 * Xfce Icon Functions
 */
gchar* xfce_icon_name_from_desktop_id(const(gchar)* desktop_id);

/**
 * SM (Session Management) Client
 */
struct XfceSMClient;

enum XfceSMClientRestartStyle {
    XFCE_SM_CLIENT_RESTART_NORMAL = 0,
    XFCE_SM_CLIENT_RESTART_IMMEDIATELY = 1
}

enum XfceSMClientPriority {
    XFCE_SM_CLIENT_PRIORITY_HIGHEST = 0,
    XFCE_SM_CLIENT_PRIORITY_WM = 15,
    XFCE_SM_CLIENT_PRIORITY_CORE = 25,
    XFCE_SM_CLIENT_PRIORITY_DESKTOP = 35,
    XFCE_SM_CLIENT_PRIORITY_DEFAULT = 50,
    XFCE_SM_CLIENT_PRIORITY_LOWEST = 255
}

XfceSMClient* xfce_sm_client_get();
XfceSMClient* xfce_sm_client_get_with_argv(gint argc, gchar** argv, int restart_style, ubyte priority);
XfceSMClient* xfce_sm_client_get_full(int restart_style, ubyte priority, const(gchar)* resumed_client_id, const(gchar)* current_directory, const(gchar*)* restart_command, const(gchar)* desktop_file);

gboolean xfce_sm_client_connect(XfceSMClient* sm_client, GError** error);
void xfce_sm_client_disconnect(XfceSMClient* sm_client);

void xfce_sm_client_request_shutdown(XfceSMClient* sm_client, int shutdown_hint);
gboolean xfce_sm_client_is_connected(XfceSMClient* sm_client);
gboolean xfce_sm_client_is_resumed(XfceSMClient* sm_client);

void xfce_sm_client_set_desktop_file(XfceSMClient* sm_client, const(gchar)* desktop_file);
const(gchar)* xfce_sm_client_get_client_id(XfceSMClient* sm_client);
const(gchar)* xfce_sm_client_get_state_file(XfceSMClient* sm_client);
const(gchar)* xfce_sm_client_get_current_directory(XfceSMClient* sm_client);

enum XfceSMClientShutdownHint {
    XFCE_SM_CLIENT_SHUTDOWN_HINT_ASK = 0,
    XFCE_SM_CLIENT_SHUTDOWN_HINT_LOGOUT = 1,
    XFCE_SM_CLIENT_SHUTDOWN_HINT_HALT = 2,
    XFCE_SM_CLIENT_SHUTDOWN_HINT_REBOOT = 3
}
