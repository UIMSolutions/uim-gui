/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde;

// Main KDE/Qt module - imports all sub-modules

// Core C bindings
public import uim.kde.c.qtcore;
public import uim.kde.c.qtwidgets;
public import uim.kde.c.qtgui;

// D wrappers
public import uim.kde.qtcore;
public import uim.kde.qtwidgets;
public import uim.kde.qtgui;

// Utilities
public import uim.kde.utils;
public import uim.kde.types;
