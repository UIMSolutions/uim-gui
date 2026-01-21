/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.utils;

public import uim.gnome.types;
public import uim.gnome.c.glib;
public import uim.gnome.c.gobject;

/**
 * Utility functions for working with GNOME libraries from D
 */

/**
 * Initialize GLib type system
 */
void initGLib() @trusted {
    import uim.gnome.c.gobject : g_type_init;
    static bool initialized = false;
    if (!initialized) {
        g_type_init();
        initialized = true;
    }
}

/**
 * Convert D array to GLib list
 */
GList* toGList(T)(T[] items) @trusted {
    import uim.gnome.c.glib : g_list_append;
    GList* list = null;
    foreach (item; items) {
        list = g_list_append(list, cast(void*)item);
    }
    return list;
}

/**
 * Convert GLib list to D array
 */
T[] fromGList(T)(GList* list) @trusted {
    T[] result;
    while (list !is null) {
        result ~= cast(T)list.data;
        list = list.next;
    }
    return result;
}

/**
 * Free a GLib list
 */
void freeGList(GList* list) @trusted {
    import uim.gnome.c.glib : g_list_free;
    if (list !is null) {
        g_list_free(list);
    }
}

/**
 * RAII wrapper for GObject reference counting
 */
struct GObjectRef(T) if (is(T == struct) || is(T == class)) {
    private T* _object;
    
    @disable this(this); // No copying - use explicit ref
    
    this(T* obj) @trusted {
        _object = obj;
        if (_object !is null) {
            import uim.gnome.c.gobject : g_object_ref;
            g_object_ref(cast(void*)_object);
        }
    }
    
    ~this() @trusted {
        if (_object !is null) {
            import uim.gnome.c.gobject : g_object_unref;
            g_object_unref(cast(void*)_object);
        }
    }
    
    @property T* ptr() @safe pure nothrow @nogc {
        return _object;
    }
    
    T* release() @safe nothrow @nogc {
        auto obj = _object;
        _object = null;
        return obj;
    }
    
    alias ptr this;
}

/**
 * Connect a signal to a D delegate/function
 */
struct SignalConnection {
    private void* instance;
    private ulong handlerId;
    
    this(T)(T* inst, string signalName, void delegate() handler) @trusted {
        import uim.gnome.c.gobject : g_signal_connect_data, GCallback, GConnectFlags;
        
        instance = cast(void*)inst;
        
        // Create a wrapper that calls the D delegate
        extern(C) static void wrapper(void* obj, void* userData) nothrow {
            auto dg = cast(void delegate()*)userData;
            try {
                (*dg)();
            } catch (Exception e) {
                // Log error or handle it appropriately
            }
        }
        
        auto dgCopy = new void delegate();
        *dgCopy = handler;
        
        handlerId = g_signal_connect_data(
            instance,
            toGString(signalName),
            cast(GCallback)&wrapper,
            cast(void*)dgCopy,
            null,
            cast(GConnectFlags)0
        );
    }
    
    void disconnect() @trusted {
        if (handlerId != 0) {
            import uim.gnome.c.gobject : g_signal_handler_disconnect;
            g_signal_handler_disconnect(instance, handlerId);
            handlerId = 0;
        }
    }
    
    ~this() @trusted {
        disconnect();
    }
}

/**
 * Helper to connect signals with automatic cleanup
 */
SignalConnection connectSignal(T)(T* instance, string signal, void delegate() handler) {
    return SignalConnection(instance, signal, handler);
}

/**
 * Get a property from a GObject
 */
T getProperty(T)(void* object, string propertyName) @trusted {
    import uim.gnome.c.gobject : GValue, g_value_init, g_object_get_property, 
                                  g_value_unset, G_TYPE_BOOLEAN, G_TYPE_INT, 
                                  G_TYPE_STRING, g_value_get_boolean, g_value_get_int,
                                  g_value_get_string;
    
    GValue value;
    
    static if (is(T == bool)) {
        g_value_init(&value, G_TYPE_BOOLEAN);
        g_object_get_property(cast(void*)object, toGString(propertyName), &value);
        auto result = fromGBoolean(g_value_get_boolean(&value));
        g_value_unset(&value);
        return result;
    } else static if (is(T == int)) {
        g_value_init(&value, G_TYPE_INT);
        g_object_get_property(cast(void*)object, toGString(propertyName), &value);
        auto result = g_value_get_int(&value);
        g_value_unset(&value);
        return result;
    } else static if (is(T == string)) {
        g_value_init(&value, G_TYPE_STRING);
        g_object_get_property(cast(void*)object, toGString(propertyName), &value);
        auto cstr = g_value_get_string(&value);
        auto result = fromGString(cstr);
        g_value_unset(&value);
        return result;
    } else {
        static assert(false, "Unsupported property type: " ~ T.stringof);
    }
}

/**
 * Set a property on a GObject
 */
void setProperty(T)(void* object, string propertyName, T value) @trusted {
    import uim.gnome.c.gobject : GValue, g_value_init, g_object_set_property,
                                  g_value_unset, G_TYPE_BOOLEAN, G_TYPE_INT,
                                  G_TYPE_STRING, g_value_set_boolean, g_value_set_int,
                                  g_value_set_string;
    
    GValue gvalue;
    
    static if (is(T == bool)) {
        g_value_init(&gvalue, G_TYPE_BOOLEAN);
        g_value_set_boolean(&gvalue, toGBoolean(value));
    } else static if (is(T == int)) {
        g_value_init(&gvalue, G_TYPE_INT);
        g_value_set_int(&gvalue, value);
    } else static if (is(T == string)) {
        g_value_init(&gvalue, G_TYPE_STRING);
        g_value_set_string(&gvalue, toGString(value));
    } else {
        static assert(false, "Unsupported property type: " ~ T.stringof);
    }
    
    g_object_set_property(cast(void*)object, toGString(propertyName), &gvalue);
    g_value_unset(&gvalue);
}

/**
 * Run the GLib main loop
 */
void runMainLoop() @trusted {
    import uim.gnome.c.glib : GMainLoop, g_main_loop_new, g_main_loop_run, g_main_loop_unref;
    
    auto loop = g_main_loop_new(null, FALSE);
    g_main_loop_run(loop);
    g_main_loop_unref(loop);
}
