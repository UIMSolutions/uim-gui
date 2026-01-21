/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.c.gtk;

import uim.gnome.c.glib;
import uim.gnome.c.gobject;
import uim.gnome.c.gdk;

extern(C) nothrow @nogc:

// GTK Widget
struct GtkWidget {
    GObject parent_instance;
}

struct GtkWidgetClass {
    GObjectClass parent_class;
}

// GTK Window
struct GtkWindow {
    GtkWidget parent_instance;
}

struct GtkWindowClass {
    GtkWidgetClass parent_class;
}

// GTK Application
struct GtkApplication {
    GObject parent_instance;
}

struct GtkApplicationClass {
    GObjectClass parent_class;
}

// GTK Application Window
struct GtkApplicationWindow {
    GtkWindow parent_instance;
}

struct GtkApplicationWindowClass {
    GtkWindowClass parent_class;
}

// GTK Box
struct GtkBox {
    GtkWidget parent_instance;
}

struct GtkBoxClass {
    GtkWidgetClass parent_class;
}

// GTK Button
struct GtkButton {
    GtkWidget parent_instance;
}

struct GtkButtonClass {
    GtkWidgetClass parent_class;
}

// GTK Label
struct GtkLabel {
    GtkWidget parent_instance;
}

struct GtkLabelClass {
    GtkWidgetClass parent_class;
}

// GTK Entry
struct GtkEntry {
    GtkWidget parent_instance;
}

struct GtkEntryClass {
    GtkWidgetClass parent_class;
}

// GTK Grid
struct GtkGrid {
    GtkWidget parent_instance;
}

struct GtkGridClass {
    GtkWidgetClass parent_class;
}

// GTK Text View
struct GtkTextView {
    GtkWidget parent_instance;
}

struct GtkTextViewClass {
    GtkWidgetClass parent_class;
}

struct GtkTextBuffer {
    GObject parent_instance;
}

// GTK ScrolledWindow
struct GtkScrolledWindow {
    GtkWidget parent_instance;
}

struct GtkScrolledWindowClass {
    GtkWidgetClass parent_class;
}

// Orientation
alias GtkOrientation = int;
enum : GtkOrientation {
    GTK_ORIENTATION_HORIZONTAL = 0,
    GTK_ORIENTATION_VERTICAL = 1
}

// Align
alias GtkAlign = int;
enum : GtkAlign {
    GTK_ALIGN_FILL = 0,
    GTK_ALIGN_START = 1,
    GTK_ALIGN_END = 2,
    GTK_ALIGN_CENTER = 3,
    GTK_ALIGN_BASELINE = 4
}

// GTK Types
GType gtk_widget_get_type();
GType gtk_window_get_type();
GType gtk_application_get_type();
GType gtk_application_window_get_type();
GType gtk_box_get_type();
GType gtk_button_get_type();
GType gtk_label_get_type();
GType gtk_entry_get_type();
GType gtk_grid_get_type();
GType gtk_text_view_get_type();
GType gtk_text_buffer_get_type();
GType gtk_scrolled_window_get_type();

// GTK initialization
void gtk_init();
gboolean gtk_init_check();

// GTK Application functions
GtkApplication* gtk_application_new(const(gchar)* application_id, GApplicationFlags flags);
void g_application_run(GtkApplication* application, int argc, char** argv);
void g_application_quit(GtkApplication* application);

alias GApplicationFlags = int;
enum : GApplicationFlags {
    G_APPLICATION_FLAGS_NONE = 0,
    G_APPLICATION_HANDLES_OPEN = 1 << 0,
    G_APPLICATION_HANDLES_COMMAND_LINE = 1 << 1,
    G_APPLICATION_SEND_ENVIRONMENT = 1 << 2,
    G_APPLICATION_NON_UNIQUE = 1 << 3
}

// GTK Window functions
GtkWidget* gtk_window_new();
GtkWidget* gtk_application_window_new(GtkApplication* application);
void gtk_window_set_title(GtkWindow* window, const(gchar)* title);
const(gchar)* gtk_window_get_title(GtkWindow* window);
void gtk_window_set_default_size(GtkWindow* window, int width, int height);
void gtk_window_get_default_size(GtkWindow* window, int* width, int* height);
void gtk_window_set_child(GtkWindow* window, GtkWidget* child);
GtkWidget* gtk_window_get_child(GtkWindow* window);
void gtk_window_present(GtkWindow* window);
void gtk_window_close(GtkWindow* window);
void gtk_window_destroy(GtkWindow* window);
void gtk_window_set_resizable(GtkWindow* window, gboolean resizable);
gboolean gtk_window_get_resizable(GtkWindow* window);

// GTK Widget functions
void gtk_widget_show(GtkWidget* widget);
void gtk_widget_hide(GtkWidget* widget);
void gtk_widget_set_visible(GtkWidget* widget, gboolean visible);
gboolean gtk_widget_get_visible(GtkWidget* widget);
void gtk_widget_set_sensitive(GtkWidget* widget, gboolean sensitive);
gboolean gtk_widget_get_sensitive(GtkWidget* widget);
void gtk_widget_set_size_request(GtkWidget* widget, int width, int height);
void gtk_widget_get_size_request(GtkWidget* widget, int* width, int* height);
void gtk_widget_set_hexpand(GtkWidget* widget, gboolean expand);
gboolean gtk_widget_get_hexpand(GtkWidget* widget);
void gtk_widget_set_vexpand(GtkWidget* widget, gboolean expand);
gboolean gtk_widget_get_vexpand(GtkWidget* widget);
void gtk_widget_set_halign(GtkWidget* widget, GtkAlign align_);
GtkAlign gtk_widget_get_halign(GtkWidget* widget);
void gtk_widget_set_valign(GtkWidget* widget, GtkAlign align_);
GtkAlign gtk_widget_get_valign(GtkWidget* widget);
void gtk_widget_set_margin_start(GtkWidget* widget, int margin);
int gtk_widget_get_margin_start(GtkWidget* widget);
void gtk_widget_set_margin_end(GtkWidget* widget, int margin);
int gtk_widget_get_margin_end(GtkWidget* widget);
void gtk_widget_set_margin_top(GtkWidget* widget, int margin);
int gtk_widget_get_margin_top(GtkWidget* widget);
void gtk_widget_set_margin_bottom(GtkWidget* widget, int margin);
int gtk_widget_get_margin_bottom(GtkWidget* widget);

// GTK Box functions
GtkWidget* gtk_box_new(GtkOrientation orientation, int spacing);
void gtk_box_append(GtkBox* box, GtkWidget* child);
void gtk_box_prepend(GtkBox* box, GtkWidget* child);
void gtk_box_remove(GtkBox* box, GtkWidget* child);
void gtk_box_set_spacing(GtkBox* box, int spacing);
int gtk_box_get_spacing(GtkBox* box);
void gtk_box_set_homogeneous(GtkBox* box, gboolean homogeneous);
gboolean gtk_box_get_homogeneous(GtkBox* box);

// GTK Button functions
GtkWidget* gtk_button_new();
GtkWidget* gtk_button_new_with_label(const(gchar)* label);
GtkWidget* gtk_button_new_with_mnemonic(const(gchar)* label);
void gtk_button_set_label(GtkButton* button, const(gchar)* label);
const(gchar)* gtk_button_get_label(GtkButton* button);
void gtk_button_set_child(GtkButton* button, GtkWidget* child);
GtkWidget* gtk_button_get_child(GtkButton* button);

// GTK Label functions
GtkWidget* gtk_label_new(const(gchar)* str);
void gtk_label_set_text(GtkLabel* label, const(gchar)* str);
const(gchar)* gtk_label_get_text(GtkLabel* label);
void gtk_label_set_markup(GtkLabel* label, const(gchar)* str);
void gtk_label_set_use_markup(GtkLabel* label, gboolean setting);
gboolean gtk_label_get_use_markup(GtkLabel* label);
void gtk_label_set_wrap(GtkLabel* label, gboolean wrap);
gboolean gtk_label_get_wrap(GtkLabel* label);
void gtk_label_set_selectable(GtkLabel* label, gboolean setting);
gboolean gtk_label_get_selectable(GtkLabel* label);

// GTK Entry functions
GtkWidget* gtk_entry_new();
void gtk_entry_set_text(GtkEntry* entry, const(gchar)* text);
const(gchar)* gtk_entry_get_text(GtkEntry* entry);
void gtk_entry_set_placeholder_text(GtkEntry* entry, const(gchar)* text);
const(gchar)* gtk_entry_get_placeholder_text(GtkEntry* entry);
void gtk_entry_set_visibility(GtkEntry* entry, gboolean visible);
gboolean gtk_entry_get_visibility(GtkEntry* entry);
void gtk_entry_set_max_length(GtkEntry* entry, int max);
int gtk_entry_get_max_length(GtkEntry* entry);

// GTK Grid functions
GtkWidget* gtk_grid_new();
void gtk_grid_attach(GtkGrid* grid, GtkWidget* child, int column, int row, int width, int height);
void gtk_grid_remove(GtkGrid* grid, GtkWidget* child);
void gtk_grid_set_row_spacing(GtkGrid* grid, guint spacing);
guint gtk_grid_get_row_spacing(GtkGrid* grid);
void gtk_grid_set_column_spacing(GtkGrid* grid, guint spacing);
guint gtk_grid_get_column_spacing(GtkGrid* grid);
void gtk_grid_set_row_homogeneous(GtkGrid* grid, gboolean homogeneous);
gboolean gtk_grid_get_row_homogeneous(GtkGrid* grid);
void gtk_grid_set_column_homogeneous(GtkGrid* grid, gboolean homogeneous);
gboolean gtk_grid_get_column_homogeneous(GtkGrid* grid);

// GTK TextView functions
GtkWidget* gtk_text_view_new();
GtkWidget* gtk_text_view_new_with_buffer(GtkTextBuffer* buffer);
GtkTextBuffer* gtk_text_view_get_buffer(GtkTextView* text_view);
void gtk_text_view_set_buffer(GtkTextView* text_view, GtkTextBuffer* buffer);
void gtk_text_view_set_editable(GtkTextView* text_view, gboolean setting);
gboolean gtk_text_view_get_editable(GtkTextView* text_view);
void gtk_text_view_set_wrap_mode(GtkTextView* text_view, GtkWrapMode wrap_mode);
GtkWrapMode gtk_text_view_get_wrap_mode(GtkTextView* text_view);

alias GtkWrapMode = int;
enum : GtkWrapMode {
    GTK_WRAP_NONE = 0,
    GTK_WRAP_CHAR = 1,
    GTK_WRAP_WORD = 2,
    GTK_WRAP_WORD_CHAR = 3
}

// GTK TextBuffer functions
GtkTextBuffer* gtk_text_buffer_new(void* table);
void gtk_text_buffer_set_text(GtkTextBuffer* buffer, const(gchar)* text, int len);
gchar* gtk_text_buffer_get_text(GtkTextBuffer* buffer, const(GtkTextIter)* start,
                                const(GtkTextIter)* end, gboolean include_hidden_chars);
int gtk_text_buffer_get_char_count(GtkTextBuffer* buffer);
void gtk_text_buffer_get_start_iter(GtkTextBuffer* buffer, GtkTextIter* iter);
void gtk_text_buffer_get_end_iter(GtkTextBuffer* buffer, GtkTextIter* iter);
void gtk_text_buffer_insert(GtkTextBuffer* buffer, GtkTextIter* iter, const(gchar)* text, int len);

struct GtkTextIter {
    gpointer[14] dummy;
}

// GTK ScrolledWindow functions
GtkWidget* gtk_scrolled_window_new();
void gtk_scrolled_window_set_child(GtkScrolledWindow* scrolled_window, GtkWidget* child);
GtkWidget* gtk_scrolled_window_get_child(GtkScrolledWindow* scrolled_window);
void gtk_scrolled_window_set_policy(GtkScrolledWindow* scrolled_window,
                                    GtkPolicyType hscrollbar_policy,
                                    GtkPolicyType vscrollbar_policy);
void gtk_scrolled_window_get_policy(GtkScrolledWindow* scrolled_window,
                                    GtkPolicyType* hscrollbar_policy,
                                    GtkPolicyType* vscrollbar_policy);

alias GtkPolicyType = int;
enum : GtkPolicyType {
    GTK_POLICY_ALWAYS = 0,
    GTK_POLICY_AUTOMATIC = 1,
    GTK_POLICY_NEVER = 2,
    GTK_POLICY_EXTERNAL = 3
}

// GTK Dialog
struct GtkDialog {
    GtkWindow parent_instance;
}

struct GtkDialogClass {
    GtkWindowClass parent_class;
}

GType gtk_dialog_get_type();
GtkWidget* gtk_dialog_new();
void gtk_dialog_add_button(GtkDialog* dialog, const(gchar)* button_text, int response_id);
GtkWidget* gtk_dialog_get_content_area(GtkDialog* dialog);
int gtk_dialog_run(GtkDialog* dialog);

alias GtkResponseType = int;
enum : GtkResponseType {
    GTK_RESPONSE_NONE = -1,
    GTK_RESPONSE_REJECT = -2,
    GTK_RESPONSE_ACCEPT = -3,
    GTK_RESPONSE_DELETE_EVENT = -4,
    GTK_RESPONSE_OK = -5,
    GTK_RESPONSE_CANCEL = -6,
    GTK_RESPONSE_CLOSE = -7,
    GTK_RESPONSE_YES = -8,
    GTK_RESPONSE_NO = -9,
    GTK_RESPONSE_APPLY = -10,
    GTK_RESPONSE_HELP = -11
}

// GTK MessageDialog
struct GtkMessageDialog {
    GtkDialog parent_instance;
}

GType gtk_message_dialog_get_type();
GtkWidget* gtk_message_dialog_new(GtkWindow* parent, GtkDialogFlags flags,
                                  GtkMessageType type, GtkButtonsType buttons,
                                  const(gchar)* message_format, ...);

alias GtkDialogFlags = int;
enum : GtkDialogFlags {
    GTK_DIALOG_MODAL = 1 << 0,
    GTK_DIALOG_DESTROY_WITH_PARENT = 1 << 1,
    GTK_DIALOG_USE_HEADER_BAR = 1 << 2
}

alias GtkMessageType = int;
enum : GtkMessageType {
    GTK_MESSAGE_INFO = 0,
    GTK_MESSAGE_WARNING = 1,
    GTK_MESSAGE_QUESTION = 2,
    GTK_MESSAGE_ERROR = 3,
    GTK_MESSAGE_OTHER = 4
}

alias GtkButtonsType = int;
enum : GtkButtonsType {
    GTK_BUTTONS_NONE = 0,
    GTK_BUTTONS_OK = 1,
    GTK_BUTTONS_CLOSE = 2,
    GTK_BUTTONS_CANCEL = 3,
    GTK_BUTTONS_YES_NO = 4,
    GTK_BUTTONS_OK_CANCEL = 5
}
