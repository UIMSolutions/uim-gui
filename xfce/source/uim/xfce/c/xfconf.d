/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.c.xfconf;

import core.stdc.config;
import uim.xfce.c.libxfce4util;

extern(C):

// Forward declarations
struct GObject;
struct GError;
struct GValue;

/**
 * XfconfChannel: Configuration channel for storing settings
 */
struct XfconfChannel;

// Xfconf initialization
gboolean xfconf_init(GError** error);
void xfconf_shutdown();

// Channel management
XfconfChannel* xfconf_channel_get(const(gchar)* channel_name);
XfconfChannel* xfconf_channel_new(const(gchar)* channel_name);
gboolean xfconf_channel_has_property(XfconfChannel* channel, const(gchar)* property);
void xfconf_channel_reset_property(XfconfChannel* channel, const(gchar)* property, gboolean recursive);

// Property getters
gboolean xfconf_channel_get_bool(XfconfChannel* channel, const(gchar)* property, gboolean default_value);
gint xfconf_channel_get_int(XfconfChannel* channel, const(gchar)* property, gint default_value);
guint xfconf_channel_get_uint(XfconfChannel* channel, const(gchar)* property, guint default_value);
double xfconf_channel_get_double(XfconfChannel* channel, const(gchar)* property, double default_value);
gchar* xfconf_channel_get_string(XfconfChannel* channel, const(gchar)* property, const(gchar)* default_value);
gchar** xfconf_channel_get_string_list(XfconfChannel* channel, const(gchar)* property);
gboolean xfconf_channel_get_property(XfconfChannel* channel, const(gchar)* property, GValue* value);

// Property setters
gboolean xfconf_channel_set_bool(XfconfChannel* channel, const(gchar)* property, gboolean value);
gboolean xfconf_channel_set_int(XfconfChannel* channel, const(gchar)* property, gint value);
gboolean xfconf_channel_set_uint(XfconfChannel* channel, const(gchar)* property, guint value);
gboolean xfconf_channel_set_double(XfconfChannel* channel, const(gchar)* property, double value);
gboolean xfconf_channel_set_string(XfconfChannel* channel, const(gchar)* property, const(gchar)* value);
gboolean xfconf_channel_set_string_list(XfconfChannel* channel, const(gchar)* property, const(gchar*)* value);
gboolean xfconf_channel_set_property(XfconfChannel* channel, const(gchar)* property, const(GValue)* value);

// Array property support
gboolean xfconf_channel_get_array(XfconfChannel* channel, const(gchar)* property, GType first_value_type, ...);
gboolean xfconf_channel_get_array_valist(XfconfChannel* channel, const(gchar)* property, GType first_value_type, va_list var_args);
gboolean xfconf_channel_set_array(XfconfChannel* channel, const(gchar)* property, GType first_value_type, ...);
gboolean xfconf_channel_set_array_valist(XfconfChannel* channel, const(gchar)* property, GType first_value_type, va_list var_args);

// Property monitoring
struct XfconfChannelPropertyChangedFunc;
alias XfconfChannelPropertyChangedCallback = void function(XfconfChannel* channel, const(gchar)* property, const(GValue)* value, gpointer user_data);

// List operations
gchar** xfconf_list_channels();
