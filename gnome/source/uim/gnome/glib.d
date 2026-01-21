/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.glib;

/**
 * D wrappers for GLib functionality
 * Provides idiomatic D interfaces to GLib C functions
 */

public import uim.gnome.c.glib;
public import uim.gnome.types;

/**
 * D wrapper for GString
 */
class GLibString {
    private GString* _gstring;
    
    this(string str = "") @trusted {
        _gstring = g_string_new(toGString(str));
    }
    
    ~this() @trusted {
        if (_gstring !is null) {
            g_string_free(_gstring, TRUE);
        }
    }
    
    void append(string str) @trusted {
        g_string_append(_gstring, toGString(str));
    }
    
    void prepend(string str) @trusted {
        g_string_prepend(_gstring, toGString(str));
    }
    
    override string toString() @trusted {
        return fromGString(_gstring.str);
    }
    
    @property size_t length() @safe pure nothrow @nogc {
        return _gstring ? _gstring.len : 0;
    }
}

// GLib String functions
extern(C) GString* g_string_new(const(gchar)* init);
extern(C) GString* g_string_append(GString* string_, const(gchar)* val);
extern(C) GString* g_string_prepend(GString* string_, const(gchar)* val);
extern(C) gchar* g_string_free(GString* string_, gboolean free_segment);

/**
 * D wrapper for GList
 */
class GLibList(T) {
    private GList* _list;
    
    this() @safe pure nothrow @nogc {
        _list = null;
    }
    
    ~this() @trusted {
        g_list_free(_list);
    }
    
    void append(T data) @trusted {
        _list = g_list_append(_list, cast(void*)data);
    }
    
    void prepend(T data) @trusted {
        _list = g_list_prepend(_list, cast(void*)data);
    }
    
    void remove(T data) @trusted {
        _list = g_list_remove(_list, cast(void*)data);
    }
    
    @property size_t length() @trusted {
        return g_list_length(_list);
    }
    
    T opIndex(size_t index) @trusted {
        auto node = g_list_nth(_list, cast(uint)index);
        return node ? cast(T)node.data : T.init;
    }
    
    int opApply(scope int delegate(T) dg) @trusted {
        int result = 0;
        auto current = _list;
        while (current !is null) {
            result = dg(cast(T)current.data);
            if (result) break;
            current = current.next;
        }
        return result;
    }
}

/**
 * D wrapper for GHashTable
 */
class GLibHashTable(K, V) {
    private GHashTable* _table;
    
    this() @trusted {
        _table = g_hash_table_new(
            cast(GHashFunc)&g_str_hash,
            cast(GEqualFunc)&g_str_equal
        );
    }
    
    ~this() @trusted {
        if (_table !is null) {
            g_hash_table_destroy(_table);
        }
    }
    
    void insert(K key, V value) @trusted {
        g_hash_table_insert(_table, cast(void*)key, cast(void*)value);
    }
    
    V lookup(K key) @trusted {
        return cast(V)g_hash_table_lookup(_table, cast(void*)key);
    }
    
    bool contains(K key) @trusted {
        return fromGBoolean(g_hash_table_contains(_table, cast(void*)key));
    }
    
    bool remove(K key) @trusted {
        return fromGBoolean(g_hash_table_remove(_table, cast(void*)key));
    }
    
    @property uint size() @trusted {
        return g_hash_table_size(_table);
    }
}

/**
 * Main loop wrapper
 */
class MainLoop {
    private GMainLoop* _loop;
    
    this() @trusted {
        _loop = g_main_loop_new(null, FALSE);
    }
    
    ~this() @trusted {
        if (_loop !is null) {
            g_main_loop_unref(_loop);
        }
    }
    
    void run() @trusted {
        g_main_loop_run(_loop);
    }
    
    void quit() @trusted {
        g_main_loop_quit(_loop);
    }
    
    @property bool isRunning() @trusted {
        return fromGBoolean(g_main_loop_is_running(_loop));
    }
}

/**
 * Timeout source wrapper
 */
uint addTimeout(uint interval, bool delegate() callback) @trusted {
    extern(C) static gboolean wrapper(void* userData) nothrow {
        auto dg = cast(bool delegate()*)userData;
        try {
            return toGBoolean((*dg)());
        } catch (Exception e) {
            return FALSE;
        }
    }
    
    auto dgCopy = new bool delegate();
    *dgCopy = callback;
    
    return g_timeout_add(interval, cast(GSourceFunc)&wrapper, cast(void*)dgCopy);
}

/**
 * Idle source wrapper
 */
uint addIdle(bool delegate() callback) @trusted {
    extern(C) static gboolean wrapper(void* userData) nothrow {
        auto dg = cast(bool delegate()*)userData;
        try {
            return toGBoolean((*dg)());
        } catch (Exception e) {
            return FALSE;
        }
    }
    
    auto dgCopy = new bool delegate();
    *dgCopy = callback;
    
    return g_idle_add(cast(GSourceFunc)&wrapper, cast(void*)dgCopy);
}

/**
 * Remove a source
 */
bool removeSource(uint sourceId) @trusted {
    return fromGBoolean(g_source_remove(sourceId));
}
