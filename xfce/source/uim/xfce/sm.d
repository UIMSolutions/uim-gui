/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce.sm;

import uim.xfce.c.libxfce4ui;
import uim.xfce.c.libxfce4util;
import std.string : toStringz, fromStringz;

/**
 * XFCE Session Management Client
 * 
 * Handles session management for XFCE applications.
 * Allows applications to save/restore state across sessions.
 */
class SMClient {
    private XfceSMClient* _client;
    private bool _owned = false; // SM client is singleton

    /**
     * Get the default session management client
     */
    static SMClient get() {
        auto client = new SMClient();
        client._client = xfce_sm_client_get();
        return client;
    }

    /**
     * Get session management client with custom arguments
     * Params:
     *   args = Command line arguments
     *   restartStyle = Restart style (normal or immediate)
     *   priority = Client priority
     */
    static SMClient getWithArgv(string[] args, RestartStyle restartStyle = RestartStyle.Normal, ubyte priority = Priority.Default) {
        import core.stdc.stdlib : malloc, free;
        
        auto client = new SMClient();
        
        // Convert D string array to C string array
        auto argv = cast(char**)malloc((args.length + 1) * (char*).sizeof);
        foreach (i, arg; args) {
            argv[i] = cast(char*)toStringz(arg);
        }
        argv[args.length] = null;
        
        client._client = xfce_sm_client_get_with_argv(
            cast(int)args.length,
            argv,
            restartStyle,
            priority
        );
        
        free(argv);
        return client;
    }

    private this() {}

    /**
     * Connect to the session manager
     * Returns: true on success
     */
    bool connect() {
        import uim.gnome.c.glib : GError;
        GError* error = null;
        auto result = xfce_sm_client_connect(_client, &error);
        return result != 0;
    }

    /**
     * Disconnect from the session manager
     */
    void disconnect() {
        xfce_sm_client_disconnect(_client);
    }

    /**
     * Request session shutdown
     * Params:
     *   hint = Shutdown hint (logout, reboot, halt)
     */
    void requestShutdown(ShutdownHint hint = ShutdownHint.Ask) {
        xfce_sm_client_request_shutdown(_client, hint);
    }

    /**
     * Check if connected to session manager
     */
    bool isConnected() {
        return xfce_sm_client_is_connected(_client) != 0;
    }

    /**
     * Check if this is a resumed session
     */
    bool isResumed() {
        return xfce_sm_client_is_resumed(_client) != 0;
    }

    /**
     * Set the desktop file for this application
     */
    void setDesktopFile(string desktopFile) {
        xfce_sm_client_set_desktop_file(_client, toStringz(desktopFile));
    }

    /**
     * Get the session client ID
     */
    string getClientId() {
        auto cstr = xfce_sm_client_get_client_id(_client);
        if (cstr is null) return "";
        return fromStringz(cstr).idup;
    }

    /**
     * Get the state file path for session restoration
     */
    string getStateFile() {
        auto cstr = xfce_sm_client_get_state_file(_client);
        if (cstr is null) return "";
        return fromStringz(cstr).idup;
    }

    /**
     * Get the current working directory
     */
    string getCurrentDirectory() {
        auto cstr = xfce_sm_client_get_current_directory(_client);
        if (cstr is null) return "";
        return fromStringz(cstr).idup;
    }
}

/**
 * Restart style for session management
 */
enum RestartStyle {
    Normal = XfceSMClientRestartStyle.XFCE_SM_CLIENT_RESTART_NORMAL,
    Immediately = XfceSMClientRestartStyle.XFCE_SM_CLIENT_RESTART_IMMEDIATELY
}

/**
 * Priority for session management startup
 */
enum Priority : ubyte {
    Highest = XfceSMClientPriority.XFCE_SM_CLIENT_PRIORITY_HIGHEST,
    WindowManager = XfceSMClientPriority.XFCE_SM_CLIENT_PRIORITY_WM,
    Core = XfceSMClientPriority.XFCE_SM_CLIENT_PRIORITY_CORE,
    Desktop = XfceSMClientPriority.XFCE_SM_CLIENT_PRIORITY_DESKTOP,
    Default = XfceSMClientPriority.XFCE_SM_CLIENT_PRIORITY_DEFAULT,
    Lowest = XfceSMClientPriority.XFCE_SM_CLIENT_PRIORITY_LOWEST
}

/**
 * Shutdown hint for session manager
 */
enum ShutdownHint {
    Ask = XfceSMClientShutdownHint.XFCE_SM_CLIENT_SHUTDOWN_HINT_ASK,
    Logout = XfceSMClientShutdownHint.XFCE_SM_CLIENT_SHUTDOWN_HINT_LOGOUT,
    Halt = XfceSMClientShutdownHint.XFCE_SM_CLIENT_SHUTDOWN_HINT_HALT,
    Reboot = XfceSMClientShutdownHint.XFCE_SM_CLIENT_SHUTDOWN_HINT_REBOOT
}
