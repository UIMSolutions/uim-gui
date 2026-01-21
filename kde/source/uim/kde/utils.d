/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.utils;

public import uim.kde.types;
public import uim.kde.c.qtcore;

/**
 * Utility functions for working with Qt/KDE from D
 */

/**
 * Connect a Qt signal to a D delegate
 * Note: This is a simplified version. Full Qt signal/slot support would require MOC integration
 */
bool connectSignal(T)(QObject* sender, string signal, T receiver, void delegate() handler) @trusted {
    // In a full implementation, this would use Qt's meta-object system
    // For now, this is a placeholder showing the intended API
    return false;
}

/**
 * Disconnect a Qt signal
 */
bool disconnectSignal(QObject* sender, string signal, QObject* receiver, string slot) @trusted {
    auto qsignal = toQString(signal);
    auto qslot = toQString(slot);
    scope(exit) {
        qt_QString_delete(qsignal);
        qt_QString_delete(qslot);
    }
    return qt_QObject_disconnect(sender, signal.ptr, receiver, slot.ptr);
}

/**
 * Get a property from a QObject
 */
T getProperty(T)(QObject* obj, string propertyName) @trusted {
    auto qname = toQString(propertyName);
    scope(exit) qt_QString_delete(qname);
    
    auto variant = qt_QObject_property(obj, propertyName.ptr);
    scope(exit) qt_QVariant_delete(variant);
    
    static if (is(T == int)) {
        bool ok;
        return qt_QVariant_toInt(variant, &ok);
    } else static if (is(T == double)) {
        bool ok;
        return qt_QVariant_toDouble(variant, &ok);
    } else static if (is(T == bool)) {
        return qt_QVariant_toBool(variant);
    } else static if (is(T == string)) {
        auto qstr = qt_QVariant_toString(variant);
        scope(exit) qt_QString_delete(qstr);
        return fromQString(qstr);
    } else {
        static assert(false, "Unsupported property type: " ~ T.stringof);
    }
}

/**
 * Set a property on a QObject
 */
void setProperty(T)(QObject* obj, string propertyName, T value) @trusted {
    QVariant* variant;
    
    static if (is(T == int)) {
        variant = qt_QVariant_fromInt(value);
    } else static if (is(T == double)) {
        variant = qt_QVariant_fromDouble(value);
    } else static if (is(T == bool)) {
        variant = qt_QVariant_fromBool(value);
    } else static if (is(T == string)) {
        auto qstr = toQString(value);
        variant = qt_QVariant_fromString(qstr);
        qt_QString_delete(qstr);
    } else {
        static assert(false, "Unsupported property type: " ~ T.stringof);
    }
    
    scope(exit) qt_QVariant_delete(variant);
    qt_QObject_setProperty(obj, propertyName.ptr, variant);
}

/**
 * Process pending events
 */
void processEvents() @trusted {
    qt_QCoreApplication_processEvents();
}

/**
 * Execute the Qt event loop
 */
int exec() @trusted {
    return qt_QCoreApplication_exec();
}

/**
 * Quit the application
 */
void quit() @trusted {
    qt_QCoreApplication_quit();
}
