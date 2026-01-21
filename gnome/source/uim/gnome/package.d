/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome;

// Main GNOME module - imports all sub-modules

// Core C bindings
public import uim.gnome.c.glib;
public import uim.gnome.c.gobject;
public import uim.gnome.c.gtk;
public import uim.gnome.c.gdk;
public import uim.gnome.c.gio;

// D wrappers
public import uim.gnome.glib;
public import uim.gnome.gobject;
public import uim.gnome.gtk;
public import uim.gnome.gdk;
public import uim.gnome.gio;

// Utilities
public import uim.gnome.utils;
public import uim.gnome.types;
