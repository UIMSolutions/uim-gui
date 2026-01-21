/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.c.gobject;

import uim.gnome.c.glib;

extern(C) nothrow @nogc:

// GObject basic types
alias GType = size_t;

// Fundamental types
enum : GType {
    G_TYPE_INVALID = 0 << 2,
    G_TYPE_NONE = 1 << 2,
    G_TYPE_INTERFACE = 2 << 2,
    G_TYPE_CHAR = 3 << 2,
    G_TYPE_UCHAR = 4 << 2,
    G_TYPE_BOOLEAN = 5 << 2,
    G_TYPE_INT = 6 << 2,
    G_TYPE_UINT = 7 << 2,
    G_TYPE_LONG = 8 << 2,
    G_TYPE_ULONG = 9 << 2,
    G_TYPE_INT64 = 10 << 2,
    G_TYPE_UINT64 = 11 << 2,
    G_TYPE_ENUM = 12 << 2,
    G_TYPE_FLAGS = 13 << 2,
    G_TYPE_FLOAT = 14 << 2,
    G_TYPE_DOUBLE = 15 << 2,
    G_TYPE_STRING = 16 << 2,
    G_TYPE_POINTER = 17 << 2,
    G_TYPE_BOXED = 18 << 2,
    G_TYPE_PARAM = 19 << 2,
    G_TYPE_OBJECT = 20 << 2,
    G_TYPE_VARIANT = 21 << 2
}

// GObject structures
struct GObject {
    GTypeInstance g_type_instance;
    guint ref_count;
    GData* qdata;
}

struct GObjectClass {
    GTypeClass g_type_class;
    GSList* construct_properties;
    
    // Virtual functions
    extern(C) GObject* function(GType type, guint n_construct_properties,
                                 GObjectConstructParam* construct_properties) constructor;
    extern(C) void function(GObject* object, guint property_id, const(GValue)* value,
                            GParamSpec* pspec) set_property;
    extern(C) void function(GObject* object, guint property_id, GValue* value,
                            GParamSpec* pspec) get_property;
    extern(C) void function(GObject* object) dispose;
    extern(C) void function(GObject* object) finalize;
    extern(C) void function(GObject* object, guint n_pspecs, GParamSpec** pspecs) dispatch_properties_changed;
    extern(C) void function(GObject* object, GParamSpec* pspec) notify;
    extern(C) void function(GObject* object) constructed;
    
    gsize flags;
    gpointer[6] pdummy;
}

struct GTypeInstance {
    GTypeClass* g_class;
}

struct GTypeClass {
    GType g_type;
}

struct GObjectConstructParam {
    GParamSpec* pspec;
    GValue* value;
}

struct GData;

// GValue
struct GValue {
    GType g_type;
    union Data {
        gint v_int;
        guint v_uint;
        glong v_long;
        gulong v_ulong;
        gint64 v_int64;
        guint64 v_uint64;
        gfloat v_float;
        gdouble v_double;
        gpointer v_pointer;
    }
    Data[2] data;
}

// GParamSpec
struct GParamSpec {
    GTypeInstance g_type_instance;
    const(gchar)* name;
    GParamFlags flags;
    GType value_type;
    GType owner_type;
    
    gchar* _nick;
    gchar* _blurb;
    GData* qdata;
    guint ref_count;
    guint param_id;
}

alias GParamFlags = int;
enum : GParamFlags {
    G_PARAM_READABLE = 1 << 0,
    G_PARAM_WRITABLE = 1 << 1,
    G_PARAM_READWRITE = G_PARAM_READABLE | G_PARAM_WRITABLE,
    G_PARAM_CONSTRUCT = 1 << 2,
    G_PARAM_CONSTRUCT_ONLY = 1 << 3,
    G_PARAM_LAX_VALIDATION = 1 << 4,
    G_PARAM_STATIC_NAME = 1 << 5,
    G_PARAM_STATIC_NICK = 1 << 6,
    G_PARAM_STATIC_BLURB = 1 << 7
}

// GObject functions
GObject* g_object_new(GType object_type, const(gchar)* first_property_name, ...);
GObject* g_object_newv(GType object_type, guint n_parameters, GParameter* parameters);
gpointer g_object_ref(gpointer object);
void g_object_unref(gpointer object);
gpointer g_object_ref_sink(gpointer object);

void g_object_set(gpointer object, const(gchar)* first_property_name, ...);
void g_object_get(gpointer object, const(gchar)* first_property_name, ...);
void g_object_set_property(GObject* object, const(gchar)* property_name, const(GValue)* value);
void g_object_get_property(GObject* object, const(gchar)* property_name, GValue* value);

void g_object_freeze_notify(GObject* object);
void g_object_notify(GObject* object, const(gchar)* property_name);
void g_object_thaw_notify(GObject* object);

gpointer g_object_get_data(GObject* object, const(gchar)* key);
void g_object_set_data(GObject* object, const(gchar)* key, gpointer data);
void g_object_set_data_full(GObject* object, const(gchar)* key, gpointer data, GDestroyNotify destroy);

struct GParameter {
    const(gchar)* name;
    GValue value;
}

// GType functions
GType g_type_register_static(GType parent_type, const(gchar)* type_name,
                             const(GTypeInfo)* info, GTypeFlags flags);
GType g_type_register_static_simple(GType parent_type, const(gchar)* type_name,
                                    guint class_size, GClassInitFunc class_init,
                                    guint instance_size, GInstanceInitFunc instance_init,
                                    GTypeFlags flags);

const(gchar)* g_type_name(GType type);
GType g_type_from_name(const(gchar)* name);
GType g_type_parent(GType type);
guint g_type_depth(GType type);
GType g_type_next_base(GType leaf_type, GType root_type);
gboolean g_type_is_a(GType type, GType is_a_type);

gpointer g_type_class_ref(GType type);
gpointer g_type_class_peek(GType type);
gpointer g_type_class_peek_static(GType type);
void g_type_class_unref(gpointer g_class);
gpointer g_type_class_peek_parent(gpointer g_class);

void g_type_init();
void g_type_init_with_debug_flags(GTypeDebugFlags debug_flags);

struct GTypeInfo {
    guint16 class_size;
    GBaseInitFunc base_init;
    GBaseFinalizeFunc base_finalize;
    GClassInitFunc class_init;
    GClassFinalizeFunc class_finalize;
    gconstpointer class_data;
    guint16 instance_size;
    guint16 n_preallocs;
    GInstanceInitFunc instance_init;
    const(GTypeValueTable)* value_table;
}

struct GTypeValueTable {
    extern(C) void function(GValue* value) value_init;
    extern(C) void function(GValue* value) value_free;
    extern(C) void function(const(GValue)* src_value, GValue* dest_value) value_copy;
    extern(C) gpointer function(const(GValue)* value) value_peek_pointer;
    const(gchar)* collect_format;
    extern(C) gchar* function(GValue* value, guint n_collect_values,
                               GTypeCValue* collect_values, guint collect_flags) collect_value;
    const(gchar)* lcopy_format;
    extern(C) gchar* function(const(GValue)* value, guint n_collect_values,
                              GTypeCValue* collect_values, guint collect_flags) lcopy_value;
}

struct GTypeCValue {
    union {
        gint v_int;
        glong v_long;
        gint64 v_int64;
        gdouble v_double;
        gpointer v_pointer;
    }
}

alias GTypeFlags = int;
enum : GTypeFlags {
    G_TYPE_FLAG_ABSTRACT = 1 << 4,
    G_TYPE_FLAG_VALUE_ABSTRACT = 1 << 5
}

alias GTypeDebugFlags = int;
enum : GTypeDebugFlags {
    G_TYPE_DEBUG_NONE = 0,
    G_TYPE_DEBUG_OBJECTS = 1 << 0,
    G_TYPE_DEBUG_SIGNALS = 1 << 1,
    G_TYPE_DEBUG_MASK = 0x03
}

alias GBaseInitFunc = extern(C) void function(gpointer g_class);
alias GBaseFinalizeFunc = extern(C) void function(gpointer g_class);
alias GClassInitFunc = extern(C) void function(gpointer g_class, gpointer class_data);
alias GClassFinalizeFunc = extern(C) void function(gpointer g_class, gpointer class_data);
alias GInstanceInitFunc = extern(C) void function(GTypeInstance* instance, gpointer g_class);

// GValue functions
GValue* g_value_init(GValue* value, GType g_type);
void g_value_copy(const(GValue)* src_value, GValue* dest_value);
GValue* g_value_reset(GValue* value);
void g_value_unset(GValue* value);
void g_value_set_instance(GValue* value, gpointer instance);

// GValue type-specific setters
void g_value_set_boolean(GValue* value, gboolean v_boolean);
void g_value_set_char(GValue* value, gchar v_char);
void g_value_set_uchar(GValue* value, guchar v_uchar);
void g_value_set_int(GValue* value, gint v_int);
void g_value_set_uint(GValue* value, guint v_uint);
void g_value_set_long(GValue* value, glong v_long);
void g_value_set_ulong(GValue* value, gulong v_ulong);
void g_value_set_int64(GValue* value, gint64 v_int64);
void g_value_set_uint64(GValue* value, guint64 v_uint64);
void g_value_set_float(GValue* value, gfloat v_float);
void g_value_set_double(GValue* value, gdouble v_double);
void g_value_set_string(GValue* value, const(gchar)* v_string);
void g_value_set_pointer(GValue* value, gpointer v_pointer);
void g_value_set_object(GValue* value, gpointer v_object);

// GValue type-specific getters
gboolean g_value_get_boolean(const(GValue)* value);
gchar g_value_get_char(const(GValue)* value);
guchar g_value_get_uchar(const(GValue)* value);
gint g_value_get_int(const(GValue)* value);
guint g_value_get_uint(const(GValue)* value);
glong g_value_get_long(const(GValue)* value);
gulong g_value_get_ulong(const(GValue)* value);
gint64 g_value_get_int64(const(GValue)* value);
guint64 g_value_get_uint64(const(GValue)* value);
gfloat g_value_get_float(const(GValue)* value);
gdouble g_value_get_double(const(GValue)* value);
const(gchar)* g_value_get_string(const(GValue)* value);
gpointer g_value_get_pointer(const(GValue)* value);
gpointer g_value_get_object(const(GValue)* value);

// Signals
alias GCallback = extern(C) void function();
alias GClosureNotify = extern(C) void function(gpointer data, GClosure* closure);

struct GClosure {
    guint ref_count;
    guint meta_marshal_nouse;
    guint n_guards;
    guint n_fnotifiers;
    guint n_inotifiers;
    guint in_inotify;
    guint floating;
    guint derivative_flag;
    
    extern(C) void function(GClosure* closure, GValue* return_value, guint n_param_values,
                            const(GValue)* param_values, gpointer invocation_hint,
                            gpointer marshal_data) marshal;
    gpointer data;
    GClosureNotifyData* notifiers;
}

struct GClosureNotifyData {
    gpointer data;
    GClosureNotify notify;
}

gulong g_signal_connect_data(gpointer instance, const(gchar)* detailed_signal,
                              GCallback c_handler, gpointer data,
                              GClosureNotify destroy_data, GConnectFlags connect_flags);

alias GConnectFlags = int;
enum : GConnectFlags {
    G_CONNECT_AFTER = 1 << 0,
    G_CONNECT_SWAPPED = 1 << 1
}

// Signal macros
extern(D) gulong g_signal_connect(T)(gpointer instance, const(gchar)* detailed_signal,
                                      T c_handler, gpointer data) {
    return g_signal_connect_data(instance, detailed_signal, cast(GCallback)c_handler,
                                 data, null, cast(GConnectFlags)0);
}

void g_signal_handler_disconnect(gpointer instance, gulong handler_id);
void g_signal_handler_block(gpointer instance, gulong handler_id);
void g_signal_handler_unblock(gpointer instance, gulong handler_id);
gulong g_signal_handler_find(gpointer instance, GSignalMatchType mask, guint signal_id,
                             GQuark detail, GClosure* closure, gpointer func, gpointer data);

alias GSignalMatchType = int;
enum : GSignalMatchType {
    G_SIGNAL_MATCH_ID = 1 << 0,
    G_SIGNAL_MATCH_DETAIL = 1 << 1,
    G_SIGNAL_MATCH_CLOSURE = 1 << 2,
    G_SIGNAL_MATCH_FUNC = 1 << 3,
    G_SIGNAL_MATCH_DATA = 1 << 4,
    G_SIGNAL_MATCH_UNBLOCKED = 1 << 5
}

void g_signal_emit_by_name(gpointer instance, const(gchar)* detailed_signal, ...);
guint g_signal_lookup(const(gchar)* name, GType itype);
guint g_signal_new(const(gchar)* signal_name, GType itype, GSignalFlags signal_flags,
                  guint class_offset, GSignalAccumulator accumulator, gpointer accu_data,
                  GSignalCMarshaller c_marshaller, GType return_type, guint n_params, ...);

alias GSignalFlags = int;
enum : GSignalFlags {
    G_SIGNAL_RUN_FIRST = 1 << 0,
    G_SIGNAL_RUN_LAST = 1 << 1,
    G_SIGNAL_RUN_CLEANUP = 1 << 2,
    G_SIGNAL_NO_RECURSE = 1 << 3,
    G_SIGNAL_DETAILED = 1 << 4,
    G_SIGNAL_ACTION = 1 << 5,
    G_SIGNAL_NO_HOOKS = 1 << 6
}

alias GSignalAccumulator = extern(C) gboolean function(GSignalInvocationHint* ihint,
                                                        GValue* return_accu,
                                                        const(GValue)* handler_return,
                                                        gpointer data);
alias GSignalCMarshaller = extern(C) void function(GClosure* closure, GValue* return_value,
                                                    guint n_param_values, const(GValue)* param_values,
                                                    gpointer invocation_hint, gpointer marshal_data);

struct GSignalInvocationHint {
    guint signal_id;
    GQuark detail;
    GSignalFlags run_type;
}
