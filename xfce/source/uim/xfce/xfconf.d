/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.xfconf;

import uim.xfce.c.xfconf;
import uim.xfce.c.libxfce4util;
import std.string : toStringz, fromStringz;
import std.conv : to;

/**
 * D wrapper for XfconfChannel - Configuration storage channel
 * 
 * Provides type-safe access to XFCE configuration system (xfconf).
 * Configuration is organized in channels and properties.
 * 
 * Example:
 * ---
 * auto channel = new Channel("xfce4-desktop");
 * channel.setString("/backdrop/screen0/monitor0/workspace0/last-image", "/path/to/wallpaper.jpg");
 * auto wallpaper = channel.getString("/backdrop/screen0/monitor0/workspace0/last-image");
 * ---
 */
class Channel {
    private XfconfChannel* _channel;
    private bool _owned;

    /**
     * Get or create a configuration channel
     * Params:
     *   name = Channel name (e.g., "xfce4-desktop", "xfce4-panel")
     */
    this(string name) {
        _channel = xfconf_channel_get(toStringz(name));
        _owned = false; // Channels are singleton-managed by xfconf
    }

    /**
     * Check if a property exists
     */
    bool hasProperty(string property) {
        return xfconf_channel_has_property(_channel, toStringz(property)) != 0;
    }

    /**
     * Reset a property to its default value
     * Params:
     *   property = Property path
     *   recursive = If true, reset all child properties too
     */
    void resetProperty(string property, bool recursive = false) {
        xfconf_channel_reset_property(_channel, toStringz(property), recursive ? 1 : 0);
    }

    // Boolean property access
    bool getBool(string property, bool defaultValue = false) {
        return xfconf_channel_get_bool(_channel, toStringz(property), defaultValue ? 1 : 0) != 0;
    }

    void setBool(string property, bool value) {
        xfconf_channel_set_bool(_channel, toStringz(property), value ? 1 : 0);
    }

    // Integer property access
    int getInt(string property, int defaultValue = 0) {
        return xfconf_channel_get_int(_channel, toStringz(property), defaultValue);
    }

    void setInt(string property, int value) {
        xfconf_channel_set_int(_channel, toStringz(property), value);
    }

    // Unsigned integer property access
    uint getUint(string property, uint defaultValue = 0) {
        return xfconf_channel_get_uint(_channel, toStringz(property), defaultValue);
    }

    void setUint(string property, uint value) {
        xfconf_channel_set_uint(_channel, toStringz(property), value);
    }

    // Double property access
    double getDouble(string property, double defaultValue = 0.0) {
        return xfconf_channel_get_double(_channel, toStringz(property), defaultValue);
    }

    void setDouble(string property, double value) {
        xfconf_channel_set_double(_channel, toStringz(property), value);
    }

    // String property access
    string getString(string property, string defaultValue = "") {
        auto cstr = xfconf_channel_get_string(_channel, toStringz(property), toStringz(defaultValue));
        if (cstr is null) return defaultValue;
        return fromStringz(cstr).idup;
    }

    void setString(string property, string value) {
        xfconf_channel_set_string(_channel, toStringz(property), toStringz(value));
    }

    // String list property access
    string[] getStringList(string property) {
        auto cstrArray = xfconf_channel_get_string_list(_channel, toStringz(property));
        if (cstrArray is null) return [];
        
        string[] result;
        for (size_t i = 0; cstrArray[i] !is null; i++) {
            result ~= fromStringz(cstrArray[i]).idup;
        }
        return result;
    }

    void setStringList(string property, string[] values) {
        import core.stdc.stdlib : malloc, free;
        
        // Convert D string array to C string array
        auto cstrArray = cast(const(char)**)malloc((values.length + 1) * (const(char)*).sizeof);
        scope(exit) free(cstrArray);
        
        foreach (i, val; values) {
            cstrArray[i] = toStringz(val);
        }
        cstrArray[values.length] = null;
        
        xfconf_channel_set_string_list(_channel, toStringz(property), cstrArray);
    }

    /**
     * Get the underlying C pointer (for advanced use)
     */
    @property XfconfChannel* cHandle() {
        return _channel;
    }
}

/**
 * Initialize the xfconf library
 * Must be called before using any xfconf functions
 */
bool initXfconf() {
    import uim.gnome.c.glib : GError;
    GError* error = null;
    auto result = xfconf_init(&error);
    return result != 0;
}

/**
 * Shutdown xfconf library
 * Call when done using xfconf
 */
void shutdownXfconf() {
    xfconf_shutdown();
}

/**
 * List all available configuration channels
 */
string[] listChannels() {
    auto cstrArray = xfconf_list_channels();
    if (cstrArray is null) return [];
    
    string[] result;
    for (size_t i = 0; cstrArray[i] !is null; i++) {
        result ~= fromStringz(cstrArray[i]).idup;
    }
    return result;
}
