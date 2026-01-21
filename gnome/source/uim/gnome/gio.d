/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.gio;

/**
 * D wrappers for GIO functionality
 * Provides idiomatic D interfaces to GIO C functions
 */

public import uim.gnome.c.gio;
public import uim.gnome.gobject;
public import uim.gnome.types;

/**
 * File wrapper
 */
class File {
    private GFile* _file;
    
    private this(GFile* file) @safe pure nothrow @nogc {
        _file = file;
    }
    
    static File forPath(string path) @trusted {
        auto file = g_file_new_for_path(toGString(path));
        return file ? new File(file) : null;
    }
    
    static File forUri(string uri) @trusted {
        auto file = g_file_new_for_uri(toGString(uri));
        return file ? new File(file) : null;
    }
    
    @property string path() @trusted {
        auto cpath = g_file_get_path(_file);
        if (cpath is null) return null;
        auto result = fromGString(cpath);
        g_free(cast(void*)cpath);
        return result;
    }
    
    @property string uri() @trusted {
        auto curi = g_file_get_uri(_file);
        if (curi is null) return null;
        auto result = fromGString(curi);
        g_free(cast(void*)curi);
        return result;
    }
    
    @property string basename() @trusted {
        auto cbase = g_file_get_basename(_file);
        if (cbase is null) return null;
        auto result = fromGString(cbase);
        g_free(cast(void*)cbase);
        return result;
    }
    
    bool exists() @trusted {
        return fromGBoolean(g_file_query_exists(_file, null));
    }
    
    bool delete_() @trusted {
        GError* error = null;
        bool result = fromGBoolean(g_file_delete(_file, null, &error));
        if (error) {
            g_error_free(error);
        }
        return result;
    }
    
    bool trash() @trusted {
        GError* error = null;
        bool result = fromGBoolean(g_file_trash(_file, null, &error));
        if (error) {
            g_error_free(error);
        }
        return result;
    }
}

/**
 * Settings wrapper for GSettings
 */
class Settings : GObjectWrapper {
    this(string schemaId) @trusted {
        auto settings = g_settings_new(toGString(schemaId));
        super(cast(GObject*)settings);
    }
    
    @property GSettings* gSettings() @safe pure nothrow @nogc {
        return cast(GSettings*)_gobject;
    }
    
    bool getBool(string key) @trusted {
        return fromGBoolean(g_settings_get_boolean(gSettings, toGString(key)));
    }
    
    void setBool(string key, bool value) @trusted {
        g_settings_set_boolean(gSettings, toGString(key), toGBoolean(value));
    }
    
    int getInt(string key) @trusted {
        return g_settings_get_int(gSettings, toGString(key));
    }
    
    void setInt(string key, int value) @trusted {
        g_settings_set_int(gSettings, toGString(key), value);
    }
    
    string getString(string key) @trusted {
        auto cstr = g_settings_get_string(gSettings, toGString(key));
        if (cstr is null) return null;
        auto result = fromGString(cstr);
        g_free(cast(void*)cstr);
        return result;
    }
    
    void setString(string key, string value) @trusted {
        g_settings_set_string(gSettings, toGString(key), toGString(value));
    }
    
    void reset(string key) @trusted {
        g_settings_reset(gSettings, toGString(key));
    }
}
