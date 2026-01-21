/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.c.gio;

import uim.gnome.c.glib;
import uim.gnome.c.gobject;

extern(C) nothrow @nogc:

// GIO Application
struct GApplication {
    GObject parent_instance;
}

struct GApplicationClass {
    GObjectClass parent_class;
    
    extern(C) void function(GApplication* application) startup;
    extern(C) void function(GApplication* application) activate;
    extern(C) void function(GApplication* application, void** files, gint n_files, const(gchar)* hint) open;
    extern(C) int function(GApplication* application, void* command_line) command_line;
    extern(C) gboolean function(GApplication* application) local_command_line;
    extern(C) void function(GApplication* application, void* connection, const(gchar)* sender,
                           const(gchar)* object_path, const(gchar)* interface_name,
                           const(gchar)* signal_name, void* parameters) before_emit;
    extern(C) void function(GApplication* application, void* connection, const(gchar)* sender,
                           const(gchar)* object_path, const(gchar)* interface_name,
                           const(gchar)* signal_name, void* parameters) after_emit;
    extern(C) void function(GApplication* application, void* platform_data) add_platform_data;
    extern(C) void function(GApplication* application) quit_mainloop;
    extern(C) void function(GApplication* application) run_mainloop;
    extern(C) void function(GApplication* application) shutdown;
    extern(C) gboolean function(GApplication* application, void** arguments, gint* exit_status) dbus_register;
    extern(C) void function(GApplication* application, void* connection, const(gchar)* object_path) dbus_unregister;
    extern(C) gint function(GApplication* application, void* options) handle_local_options;
    extern(C) gboolean function(GApplication* application) name_lost;
    
    gpointer[7] padding;
}

GType g_application_get_type();
GApplication* g_application_new(const(gchar)* application_id, GApplicationFlags flags);
const(gchar)* g_application_get_application_id(GApplication* application);
void g_application_set_application_id(GApplication* application, const(gchar)* application_id);
guint g_application_get_inactivity_timeout(GApplication* application);
void g_application_set_inactivity_timeout(GApplication* application, guint inactivity_timeout);
GApplicationFlags g_application_get_flags(GApplication* application);
void g_application_set_flags(GApplication* application, GApplicationFlags flags);
gboolean g_application_get_is_registered(GApplication* application);
gboolean g_application_get_is_remote(GApplication* application);
gboolean g_application_register(GApplication* application, void* cancellable, GError** error);
void g_application_activate(GApplication* application);
void g_application_open(GApplication* application, void** files, gint n_files, const(gchar)* hint);
int g_application_run(GApplication* application, int argc, char** argv);
void g_application_quit(GApplication* application);
void g_application_hold(GApplication* application);
void g_application_release(GApplication* application);

// GIO File
struct GFile;

GType g_file_get_type();
GFile* g_file_new_for_path(const(gchar)* path);
GFile* g_file_new_for_uri(const(gchar)* uri);
GFile* g_file_new_for_commandline_arg(const(gchar)* arg);
gchar* g_file_get_path(GFile* file);
gchar* g_file_get_uri(GFile* file);
gchar* g_file_get_basename(GFile* file);
GFile* g_file_get_parent(GFile* file);
gboolean g_file_query_exists(GFile* file, void* cancellable);
gboolean g_file_delete(GFile* file, void* cancellable, GError** error);
gboolean g_file_trash(GFile* file, void* cancellable, GError** error);
gboolean g_file_copy(GFile* source, GFile* destination, GFileCopyFlags flags,
                    void* cancellable, void* progress_callback, gpointer progress_callback_data,
                    GError** error);
gboolean g_file_move(GFile* source, GFile* destination, GFileCopyFlags flags,
                    void* cancellable, void* progress_callback, gpointer progress_callback_data,
                    GError** error);

alias GFileCopyFlags = int;
enum : GFileCopyFlags {
    G_FILE_COPY_NONE = 0,
    G_FILE_COPY_OVERWRITE = 1 << 0,
    G_FILE_COPY_BACKUP = 1 << 1,
    G_FILE_COPY_NOFOLLOW_SYMLINKS = 1 << 2,
    G_FILE_COPY_ALL_METADATA = 1 << 3,
    G_FILE_COPY_NO_FALLBACK_FOR_MOVE = 1 << 4,
    G_FILE_COPY_TARGET_DEFAULT_PERMS = 1 << 5
}

// GIO InputStream
struct GInputStream {
    GObject parent_instance;
}

struct GInputStreamClass {
    GObjectClass parent_class;
}

GType g_input_stream_get_type();
gssize g_input_stream_read(GInputStream* stream, void* buffer, gsize count,
                          void* cancellable, GError** error);
gboolean g_input_stream_read_all(GInputStream* stream, void* buffer, gsize count,
                                 gsize* bytes_read, void* cancellable, GError** error);
gboolean g_input_stream_close(GInputStream* stream, void* cancellable, GError** error);

// GIO OutputStream
struct GOutputStream {
    GObject parent_instance;
}

struct GOutputStreamClass {
    GObjectClass parent_class;
}

GType g_output_stream_get_type();
gssize g_output_stream_write(GOutputStream* stream, const(void)* buffer, gsize count,
                            void* cancellable, GError** error);
gboolean g_output_stream_write_all(GOutputStream* stream, const(void)* buffer, gsize count,
                                   gsize* bytes_written, void* cancellable, GError** error);
gboolean g_output_stream_close(GOutputStream* stream, void* cancellable, GError** error);
gboolean g_output_stream_flush(GOutputStream* stream, void* cancellable, GError** error);

// GIO FileInputStream
struct GFileInputStream {
    GInputStream parent_instance;
}

GType g_file_input_stream_get_type();

// GIO FileOutputStream
struct GFileOutputStream {
    GOutputStream parent_instance;
}

GType g_file_output_stream_get_type();

// File operations
GFileInputStream* g_file_read(GFile* file, void* cancellable, GError** error);
GFileOutputStream* g_file_create(GFile* file, GFileCreateFlags flags,
                                void* cancellable, GError** error);
GFileOutputStream* g_file_replace(GFile* file, const(gchar)* etag, gboolean make_backup,
                                 GFileCreateFlags flags, void* cancellable, GError** error);
GFileOutputStream* g_file_append_to(GFile* file, GFileCreateFlags flags,
                                   void* cancellable, GError** error);

alias GFileCreateFlags = int;
enum : GFileCreateFlags {
    G_FILE_CREATE_NONE = 0,
    G_FILE_CREATE_PRIVATE = 1 << 0,
    G_FILE_CREATE_REPLACE_DESTINATION = 1 << 1
}

// GIO Settings
struct GSettings {
    GObject parent_instance;
}

GType g_settings_get_type();
GSettings* g_settings_new(const(gchar)* schema_id);
GSettings* g_settings_new_with_path(const(gchar)* schema_id, const(gchar)* path);
gboolean g_settings_get_boolean(GSettings* settings, const(gchar)* key);
void g_settings_set_boolean(GSettings* settings, const(gchar)* key, gboolean value);
gint g_settings_get_int(GSettings* settings, const(gchar)* key);
void g_settings_set_int(GSettings* settings, const(gchar)* key, gint value);
guint g_settings_get_uint(GSettings* settings, const(gchar)* key);
void g_settings_set_uint(GSettings* settings, const(gchar)* key, guint value);
gdouble g_settings_get_double(GSettings* settings, const(gchar)* key);
void g_settings_set_double(GSettings* settings, const(gchar)* key, gdouble value);
gchar* g_settings_get_string(GSettings* settings, const(gchar)* key);
void g_settings_set_string(GSettings* settings, const(gchar)* key, const(gchar)* value);
gboolean g_settings_apply(GSettings* settings);
void g_settings_reset(GSettings* settings, const(gchar)* key);

// GIO Action
struct GAction;

GType g_action_get_type();
const(gchar)* g_action_get_name(GAction* action);
void g_action_activate(GAction* action, void* parameter);

// GIO SimpleAction
struct GSimpleAction {
    GObject parent_instance;
}

GType g_simple_action_get_type();
GSimpleAction* g_simple_action_new(const(gchar)* name, const(void)* parameter_type);
GSimpleAction* g_simple_action_new_stateful(const(gchar)* name, const(void)* parameter_type,
                                           void* state);
void g_simple_action_set_enabled(GSimpleAction* simple, gboolean enabled);
void g_simple_action_set_state(GSimpleAction* simple, void* value);

// GIO ActionMap
struct GActionMap;

GType g_action_map_get_type();
void g_action_map_add_action(GActionMap* action_map, GAction* action);
void g_action_map_remove_action(GActionMap* action_map, const(gchar)* action_name);
GAction* g_action_map_lookup_action(GActionMap* action_map, const(gchar)* action_name);

// GIO Menu
struct GMenu {
    GObject parent_instance;
}

GType g_menu_get_type();
GMenu* g_menu_new();
void g_menu_append(GMenu* menu, const(gchar)* label, const(gchar)* detailed_action);
void g_menu_prepend(GMenu* menu, const(gchar)* label, const(gchar)* detailed_action);
void g_menu_insert(GMenu* menu, gint position, const(gchar)* label, const(gchar)* detailed_action);
void g_menu_append_section(GMenu* menu, const(gchar)* label, void* section);
void g_menu_append_submenu(GMenu* menu, const(gchar)* label, void* submenu);
void g_menu_remove(GMenu* menu, gint position);
void g_menu_remove_all(GMenu* menu);
