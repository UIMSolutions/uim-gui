/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.util;

import uim.xfce.c.libxfce4util;
import std.string : toStringz, fromStringz;
import std.conv : to;

/**
 * XFCE Kiosk mode support
 * 
 * Allows checking if certain capabilities are restricted by system administrator.
 * Useful for implementing desktop lockdown features.
 */
class Kiosk {
    private XfceKiosk* _kiosk;

    /**
     * Create a kiosk instance for a module
     * Params:
     *   moduleName = Name of the module (e.g., "xfce4-panel")
     */
    this(string moduleName) {
        _kiosk = xfce_kiosk_new(toStringz(moduleName));
    }

    ~this() {
        if (_kiosk) {
            xfce_kiosk_free(_kiosk);
            _kiosk = null;
        }
    }

    /**
     * Check if a capability is allowed
     * Params:
     *   capability = Capability name to check
     * Returns: true if allowed, false if restricted
     */
    bool query(string capability) {
        return xfce_kiosk_query(_kiosk, toStringz(capability)) != 0;
    }
}

/**
 * Resource type for XFCE resource lookup
 */
enum ResourceType {
    Data = XfceResourceType.XFCE_RESOURCE_DATA,
    Config = XfceResourceType.XFCE_RESOURCE_CONFIG,
    Cache = XfceResourceType.XFCE_RESOURCE_CACHE,
    Icons = XfceResourceType.XFCE_RESOURCE_ICONS,
    Themes = XfceResourceType.XFCE_RESOURCE_THEMES
}

/**
 * Look up an XFCE resource file
 * Params:
 *   resourceType = Type of resource to look up
 *   filename = Filename to search for
 * Returns: Full path to the resource, or null if not found
 */
string resourceLookup(ResourceType resourceType, string filename) {
    auto cstr = xfce_resource_lookup(resourceType, toStringz(filename));
    if (cstr is null) return null;
    return fromStringz(cstr).idup;
}

/**
 * Get the appropriate location to save a resource
 * Params:
 *   resourceType = Type of resource
 *   relativePath = Relative path for the resource
 *   create = Whether to create the directory if it doesn't exist
 * Returns: Full path where the resource should be saved
 */
string resourceSaveLocation(ResourceType resourceType, string relativePath, bool create = true) {
    auto cstr = xfce_resource_save_location(resourceType, toStringz(relativePath), create ? 1 : 0);
    if (cstr is null) return null;
    return fromStringz(cstr).idup;
}

/**
 * Get the user's home directory
 */
string getHomeDir() {
    auto cstr = xfce_get_homedir();
    if (cstr is null) return null;
    return fromStringz(cstr).idup;
}

/**
 * Get the user's XFCE config directory
 */
string getUserDir() {
    auto cstr = xfce_get_userdir();
    if (cstr is null) return null;
    return fromStringz(cstr).idup;
}

/**
 * Get localized directory name
 * Params:
 *   directory = Directory name to localize (e.g., "Desktop", "Documents")
 * Returns: Localized directory name
 */
string getDirLocalized(string directory) {
    auto cstr = xfce_get_dir_localized(toStringz(directory));
    if (cstr is null) return directory;
    return fromStringz(cstr).idup;
}

/**
 * Get XFCE version string
 */
string getVersionString() {
    auto cstr = xfce_version_string();
    if (cstr is null) return "unknown";
    return fromStringz(cstr).idup;
}

/**
 * Check if XFCE version meets requirements
 * Params:
 *   major = Required major version
 *   minor = Required minor version
 *   micro = Required micro version
 * Returns: true if current version meets requirements
 */
bool checkVersion(uint major, uint minor, uint micro) {
    return xfce_check_version(major, minor, micro) != 0;
}

/**
 * Expand variables in a command string
 * Params:
 *   command = Command string with variables (e.g., "$HOME/file")
 * Returns: Expanded command string
 */
string expandVariables(string command) {
    auto cstr = xfce_expand_variables(toStringz(command), null);
    if (cstr is null) return command;
    return fromStringz(cstr).idup;
}

/**
 * Get language names (in preference order)
 */
string[] getLanguageNames() {
    auto cstrArray = xfce_get_language_names();
    if (cstrArray is null) return [];
    
    string[] result;
    for (size_t i = 0; cstrArray[i] !is null; i++) {
        result ~= fromStringz(cstrArray[i]).idup;
    }
    return result;
}

/**
 * Get localized language name
 * Params:
 *   language = Language code (e.g., "en", "de")
 * Returns: Localized language name
 */
string getLanguageName(string language) {
    auto cstr = xfce_get_language_name(toStringz(language));
    if (cstr is null) return language;
    return fromStringz(cstr).idup;
}
