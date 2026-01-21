/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.xfce;

/**
 * XFCE Desktop Environment Library for D
 * 
 * Provides D bindings for XFCE desktop environment libraries:
 * - xfconf: Configuration system
 * - libxfce4util: Utility functions
 * - libxfce4ui: UI helpers and widgets
 * - Session management support
 * 
 * XFCE is built on GTK, so this library builds upon the uim.gnome module.
 * 
 * Example:
 * ---
 * import uim.xfce;
 * 
 * void main(string[] args) {
 *     initGTK();
 *     initXfconf();
 *     
 *     auto channel = new Channel("myapp");
 *     channel.setString("/config/theme", "dark");
 *     
 *     auto app = new Application("org.example.myapp");
 *     app.run(args);
 *     
 *     shutdownXfconf();
 * }
 * ---
 */

// Re-export GTK/GNOME (XFCE is built on GTK)
public import uim.gnome;

// C bindings
public import uim.xfce.c.libxfce4util;
public import uim.xfce.c.libxfce4ui;
public import uim.xfce.c.xfconf;

// D wrappers
public import uim.xfce.util;
public import uim.xfce.ui;
public import uim.xfce.xfconf;
public import uim.xfce.sm;
