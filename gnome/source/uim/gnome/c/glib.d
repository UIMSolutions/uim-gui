/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.c.glib;

import core.stdc.config;

extern(C) nothrow @nogc:

// GLib basic types
alias gboolean = int;
alias gchar = char;
alias guchar = ubyte;
alias gint = int;
alias guint = uint;
alias gshort = short;
alias gushort = ushort;
alias glong = c_long;
alias gulong = c_ulong;
alias gint8 = byte;
alias guint8 = ubyte;
alias gint16 = short;
alias guint16 = ushort;
alias gint32 = int;
alias guint32 = uint;
alias gint64 = long;
alias guint64 = ulong;
alias gfloat = float;
alias gdouble = double;
alias gsize = size_t;
alias gssize = ptrdiff_t;
alias goffset = long;
alias gintptr = ptrdiff_t;
alias guintptr = size_t;
alias gpointer = void*;
alias gconstpointer = const(void)*;

// GLib Constants
enum TRUE = 1;
enum FALSE = 0;

// GLib Data Structures
struct GList {
    gpointer data;
    GList* next;
    GList* prev;
}

struct GSList {
    gpointer data;
    GSList* next;
}

struct GString {
    gchar* str;
    gsize len;
    gsize allocated_len;
}

struct GHashTable;

struct GArray {
    gchar* data;
    guint len;
}

struct GPtrArray {
    gpointer* pdata;
    guint len;
}

struct GByteArray {
    guint8* data;
    guint len;
}

// GLib Error handling
struct GError {
    guint32 domain;
    gint code;
    gchar* message;
}

alias GQuark = guint32;

// GLib Memory allocation
gpointer g_malloc(gsize n_bytes);
gpointer g_malloc0(gsize n_bytes);
gpointer g_realloc(gpointer mem, gsize n_bytes);
void g_free(gpointer mem);
gpointer g_memdup(gconstpointer mem, guint byte_size);

// GLib String functions
gchar* g_strdup(const(gchar)* str);
gchar* g_strndup(const(gchar)* str, gsize n);
gchar* g_strdup_printf(const(gchar)* format, ...);
gchar* g_strdup_vprintf(const(gchar)* format, va_list args);
gchar* g_strconcat(const(gchar)* string1, ...);
gchar** g_strsplit(const(gchar)* string_, const(gchar)* delimiter, gint max_tokens);
void g_strfreev(gchar** str_array);
gchar* g_strjoinv(const(gchar)* separator, gchar** str_array);

// GLib List functions
GList* g_list_append(GList* list, gpointer data);
GList* g_list_prepend(GList* list, gpointer data);
GList* g_list_insert(GList* list, gpointer data, gint position);
GList* g_list_remove(GList* list, gconstpointer data);
GList* g_list_remove_link(GList* list, GList* llink);
GList* g_list_delete_link(GList* list, GList* link_);
GList* g_list_reverse(GList* list);
GList* g_list_copy(GList* list);
GList* g_list_nth(GList* list, guint n);
GList* g_list_find(GList* list, gconstpointer data);
guint g_list_length(GList* list);
void g_list_foreach(GList* list, GFunc func, gpointer user_data);
void g_list_free(GList* list);
void g_list_free_full(GList* list, GDestroyNotify free_func);

// GSList functions
GSList* g_slist_append(GSList* list, gpointer data);
GSList* g_slist_prepend(GSList* list, gpointer data);
GSList* g_slist_remove(GSList* list, gconstpointer data);
void g_slist_free(GSList* list);
void g_slist_free_full(GSList* list, GDestroyNotify free_func);
guint g_slist_length(GSList* list);

// GLib Hash table
alias GHashFunc = guint function(gconstpointer key);
alias GEqualFunc = gboolean function(gconstpointer a, gconstpointer b);
alias GHFunc = void function(gpointer key, gpointer value, gpointer user_data);
alias GDestroyNotify = void function(gpointer data);
alias GFunc = void function(gpointer data, gpointer user_data);

GHashTable* g_hash_table_new(GHashFunc hash_func, GEqualFunc key_equal_func);
GHashTable* g_hash_table_new_full(GHashFunc hash_func, GEqualFunc key_equal_func,
                                  GDestroyNotify key_destroy_func, GDestroyNotify value_destroy_func);
void g_hash_table_destroy(GHashTable* hash_table);
gboolean g_hash_table_insert(GHashTable* hash_table, gpointer key, gpointer value);
gboolean g_hash_table_replace(GHashTable* hash_table, gpointer key, gpointer value);
gboolean g_hash_table_remove(GHashTable* hash_table, gconstpointer key);
gpointer g_hash_table_lookup(GHashTable* hash_table, gconstpointer key);
gboolean g_hash_table_contains(GHashTable* hash_table, gconstpointer key);
guint g_hash_table_size(GHashTable* hash_table);
void g_hash_table_foreach(GHashTable* hash_table, GHFunc func, gpointer user_data);

// Hash functions
guint g_str_hash(gconstpointer v);
gboolean g_str_equal(gconstpointer v1, gconstpointer v2);
guint g_int_hash(gconstpointer v);
gboolean g_int_equal(gconstpointer v1, gconstpointer v2);
guint g_direct_hash(gconstpointer v);
gboolean g_direct_equal(gconstpointer v1, gconstpointer v2);

// GLib Error functions
GError* g_error_new(GQuark domain, gint code, const(gchar)* format, ...);
GError* g_error_copy(const(GError)* error);
void g_error_free(GError* error);
gboolean g_error_matches(const(GError)* error, GQuark domain, gint code);
void g_set_error(GError** err, GQuark domain, gint code, const(gchar)* format, ...);
void g_propagate_error(GError** dest, GError* src);
void g_clear_error(GError** err);

// GLib Main Loop
struct GMainLoop;
struct GMainContext;
struct GSource;

alias GSourceFunc = gboolean function(gpointer user_data);

GMainLoop* g_main_loop_new(GMainContext* context, gboolean is_running);
void g_main_loop_run(GMainLoop* loop);
void g_main_loop_quit(GMainLoop* loop);
gboolean g_main_loop_is_running(GMainLoop* loop);
void g_main_loop_unref(GMainLoop* loop);
GMainLoop* g_main_loop_ref(GMainLoop* loop);
GMainContext* g_main_loop_get_context(GMainLoop* loop);

GMainContext* g_main_context_new();
GMainContext* g_main_context_ref(GMainContext* context);
void g_main_context_unref(GMainContext* context);
GMainContext* g_main_context_default();
gboolean g_main_context_iteration(GMainContext* context, gboolean may_block);
gboolean g_main_context_pending(GMainContext* context);

// Timeout sources
guint g_timeout_add(guint interval, GSourceFunc function_, gpointer data);
guint g_timeout_add_seconds(guint interval, GSourceFunc function_, gpointer data);
gboolean g_source_remove(guint tag);

// Idle sources
guint g_idle_add(GSourceFunc function_, gpointer data);

// GLib File utilities
alias GFileTest = int;
enum : GFileTest {
    G_FILE_TEST_IS_REGULAR = 1 << 0,
    G_FILE_TEST_IS_SYMLINK = 1 << 1,
    G_FILE_TEST_IS_DIR = 1 << 2,
    G_FILE_TEST_IS_EXECUTABLE = 1 << 3,
    G_FILE_TEST_EXISTS = 1 << 4
}

gboolean g_file_test(const(gchar)* filename, GFileTest test);
gboolean g_file_get_contents(const(gchar)* filename, gchar** contents, gsize* length, GError** error);
gboolean g_file_set_contents(const(gchar)* filename, const(gchar)* contents, gssize length, GError** error);

// GLib utility functions
void g_print(const(gchar)* format, ...);
void g_printerr(const(gchar)* format, ...);
const(gchar)* g_get_user_name();
const(gchar)* g_get_home_dir();
const(gchar)* g_get_tmp_dir();
const(gchar)* g_get_current_dir();

// GLib Version information
extern __gshared const guint glib_major_version;
extern __gshared const guint glib_minor_version;
extern __gshared const guint glib_micro_version;
