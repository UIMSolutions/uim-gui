/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.c.libxfce4util;

import core.stdc.config;

extern(C):

// Basic types
alias GType = size_t;
alias gboolean = int;
alias gchar = char;
alias gint = int;
alias guint = uint;
alias gpointer = void*;

// XFCE version information
const XFCE_VERSION_MAJOR = 4;
const XFCE_VERSION_MINOR = 18;

/**
 * XfceKiosk: Desktop lockdown/kiosk mode support
 */
struct XfceKiosk;

XfceKiosk* xfce_kiosk_new(const(gchar)* module_);
void xfce_kiosk_free(XfceKiosk* kiosk);
gboolean xfce_kiosk_query(XfceKiosk* kiosk, const(gchar)* capability);

/**
 * XFCE resource lookup functions
 */
gchar* xfce_resource_lookup(int resource_type, const(gchar)* filename);
gchar* xfce_resource_lookup_all(int resource_type, const(gchar)* filename);
gchar* xfce_resource_save_location(int resource_type, const(gchar)* relpath, gboolean create_);

// Resource types
enum XfceResourceType {
    XFCE_RESOURCE_DATA = 0,
    XFCE_RESOURCE_CONFIG = 1,
    XFCE_RESOURCE_CACHE = 2,
    XFCE_RESOURCE_ICONS = 3,
    XFCE_RESOURCE_THEMES = 4
}

/**
 * XFCE miscellaneous utility functions
 */
gchar* xfce_get_homedir();
gchar* xfce_get_userdir();
gchar* xfce_get_dir_localized(const(gchar)* directory);
gchar* xfce_get_dir_localized_r(const(gchar)* directory, gchar* buffer, size_t length);

/**
 * XFCE version checking
 */
gchar* xfce_version_string();
gboolean xfce_check_version(guint required_major, guint required_minor, guint required_micro);

/**
 * XFCE Posix Signal Handler
 */
alias XfcePosixSignalHandler = void function(gint signal, gpointer user_data);

guint xfce_posix_signal_handler_init(void* reserved);
void xfce_posix_signal_handler_shutdown();
gint xfce_posix_signal_handler_set_handler(gint signal_, XfcePosixSignalHandler handler, gpointer user_data, void* handler_data_destroy);
void xfce_posix_signal_handler_restore_handler(gint signal_);

/**
 * Locale and translation helpers
 */
const(gchar)* xfce_get_language_name(const(gchar)* language);
gchar** xfce_get_language_names();

/**
 * Miscellaneous utility functions
 */
gchar* xfce_expand_variables(const(gchar)* command, gchar** envp);
gchar* xfce_unescape_uri_advanced(const(gchar)* uri, const(gchar)* reserved, gboolean allow_utf8);
void xfce_strip_context(const(gchar)* msgid, gchar* msgval, size_t msgval_len);
