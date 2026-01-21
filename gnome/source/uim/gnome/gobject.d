/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.gobject;

/**
 * D wrappers for GObject functionality
 * Provides idiomatic D interfaces to GObject C functions
 */

public import uim.gnome.c.gobject;
public import uim.gnome.types;

/**
 * Base class for GObject wrappers
 */
abstract class GObjectWrapper {
    protected GObject* _gobject;
    
    this(GObject* obj) @safe pure nothrow @nogc {
        _gobject = obj;
    }
    
    @property GObject* gObject() @safe pure nothrow @nogc {
        return _gobject;
    }
    
    void ref_() @trusted {
        if (_gobject !is null) {
            g_object_ref(cast(void*)_gobject);
        }
    }
    
    void unref() @trusted {
        if (_gobject !is null) {
            g_object_unref(cast(void*)_gobject);
        }
    }
    
    /**
     * Connect a signal to a callback
     */
    ulong connectSignal(string signalName, void delegate() callback) @trusted {
        extern(C) static void wrapper(void* obj, void* userData) nothrow {
            auto dg = cast(void delegate()*)userData;
            try {
                (*dg)();
            } catch (Exception e) {
                // Log error
            }
        }
        
        auto dgCopy = new void delegate();
        *dgCopy = callback;
        
        return g_signal_connect_data(
            cast(void*)_gobject,
            toGString(signalName),
            cast(GCallback)&wrapper,
            cast(void*)dgCopy,
            null,
            cast(GConnectFlags)0
        );
    }
    
    void disconnectSignal(ulong handlerId) @trusted {
        g_signal_handler_disconnect(cast(void*)_gobject, handlerId);
    }
    
    /**
     * Get a property value
     */
    T getProperty(T)(string propertyName) @trusted {
        return .getProperty!T(cast(void*)_gobject, propertyName);
    }
    
    /**
     * Set a property value
     */
    void setProperty(T)(string propertyName, T value) @trusted {
        .setProperty(cast(void*)_gobject, propertyName, value);
    }
}

/**
 * Value wrapper for GValue
 */
struct Value {
    private GValue _value;
    
    @disable this(this);
    
    static Value fromBool(bool value) @trusted {
        Value v;
        g_value_init(&v._value, G_TYPE_BOOLEAN);
        g_value_set_boolean(&v._value, toGBoolean(value));
        return v;
    }
    
    static Value fromInt(int value) @trusted {
        Value v;
        g_value_init(&v._value, G_TYPE_INT);
        g_value_set_int(&v._value, value);
        return v;
    }
    
    static Value fromString(string value) @trusted {
        Value v;
        g_value_init(&v._value, G_TYPE_STRING);
        g_value_set_string(&v._value, toGString(value));
        return v;
    }
    
    bool toBool() @trusted {
        return fromGBoolean(g_value_get_boolean(&_value));
    }
    
    int toInt() @trusted {
        return g_value_get_int(&_value);
    }
    
    string toString() @trusted {
        return fromGString(g_value_get_string(&_value));
    }
    
    ~this() @trusted {
        g_value_unset(&_value);
    }
    
    @property GValue* ptr() @safe return {
        return &_value;
    }
}
