/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.types;

public import uim.gnome.c.glib;
public import uim.gnome.c.gobject;

/**
 * Common type definitions and aliases for GNOME library usage in D
 */

// String handling
alias GString = string;
alias GChar = char;
alias GUChar = ubyte;

// Integer types with D-friendly names
alias GInt = int;
alias GUInt = uint;
alias GSize = size_t;
alias GSSize = ptrdiff_t;

// Boolean handling
bool fromGBoolean(gboolean value) @safe pure nothrow @nogc {
    return value != 0;
}

gboolean toGBoolean(bool value) @safe pure nothrow @nogc {
    return value ? TRUE : FALSE;
}

// String conversion helpers
import std.string : toStringz, fromStringz;

/**
 * Convert a D string to a GLib string (null-terminated C string)
 */
const(gchar)* toGString(string str) @trusted {
    return cast(const(gchar)*)toStringz(str);
}

/**
 * Convert a GLib string to a D string
 */
string fromGString(const(gchar)* gstr) @trusted {
    if (gstr is null) return null;
    import core.stdc.string : strlen;
    return cast(string)gstr[0 .. strlen(gstr)];
}

/**
 * Safe wrapper for GLib memory allocation
 */
T* gMalloc(T)(size_t count = 1) @trusted {
    import uim.gnome.c.glib : g_malloc0;
    return cast(T*)g_malloc0(T.sizeof * count);
}

/**
 * Safe wrapper for GLib memory deallocation
 */
void gFree(T)(T* ptr) @trusted {
    import uim.gnome.c.glib : g_free;
    if (ptr !is null) {
        g_free(cast(void*)ptr);
    }
}

/**
 * RAII wrapper for GLib-allocated memory
 */
struct GMemory(T) {
    private T* _ptr;
    
    @disable this(this); // No copying
    
    this(size_t count = 1) @trusted {
        _ptr = gMalloc!T(count);
    }
    
    ~this() @trusted {
        gFree(_ptr);
    }
    
    @property T* ptr() @safe pure nothrow @nogc {
        return _ptr;
    }
    
    T* release() @safe nothrow @nogc {
        auto p = _ptr;
        _ptr = null;
        return p;
    }
}

/**
 * RAII wrapper for GError
 */
struct GErrorWrapper {
    private GError* _error;
    
    @disable this(this); // No copying
    
    this(GError* err) @safe pure nothrow @nogc {
        _error = err;
    }
    
    ~this() @trusted {
        if (_error !is null) {
            import uim.gnome.c.glib : g_error_free;
            g_error_free(_error);
        }
    }
    
    @property GError* ptr() @safe pure nothrow @nogc {
        return _error;
    }
    
    @property bool hasError() @safe pure nothrow @nogc {
        return _error !is null;
    }
    
    @property string message() @trusted {
        if (_error is null) return null;
        return fromGString(_error.message);
    }
    
    @property int code() @safe pure nothrow @nogc {
        if (_error is null) return 0;
        return _error.code;
    }
}

/**
 * Exception for GLib/GNOME errors
 */
class GNOMEException : Exception {
    private GError* _error;
    
    this(GError* error, string file = __FILE__, size_t line = __LINE__) @trusted {
        string msg = "GNOME Error";
        if (error !is null && error.message !is null) {
            msg = fromGString(error.message);
        }
        super(msg, file, line);
        _error = error;
    }
    
    @property int errorCode() @safe pure nothrow @nogc {
        return _error ? _error.code : 0;
    }
    
    @property uint errorDomain() @safe pure nothrow @nogc {
        return _error ? _error.domain : 0;
    }
}
