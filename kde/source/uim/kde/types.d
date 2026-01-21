/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.types;

public import uim.kde.c.qtcore;

/**
 * Common type definitions and utilities for KDE/Qt library usage in D
 */

// String conversion helpers
import std.string : toStringz, fromStringz;

/**
 * Convert a D string to a QString
 */
QString* toQString(string str) @trusted {
    return qt_QString_fromUtf8(str.ptr, cast(qsizetype)str.length);
}

/**
 * Convert a QString to a D string
 */
string fromQString(QString* qstr) @trusted {
    if (qstr is null) return null;
    auto cstr = qt_QString_toUtf8(qstr);
    if (cstr is null) return null;
    import core.stdc.string : strlen;
    return cast(string)cstr[0 .. strlen(cstr)].idup;
}

/**
 * RAII wrapper for QString
 */
struct QStringWrapper {
    private QString* _qstr;
    
    @disable this(this); // No copying
    
    this(string str) @trusted {
        _qstr = toQString(str);
    }
    
    this(QString* qstr) @safe pure nothrow @nogc {
        _qstr = qstr;
    }
    
    ~this() @trusted {
        if (_qstr !is null) {
            qt_QString_delete(_qstr);
        }
    }
    
    @property QString* ptr() @safe pure nothrow @nogc {
        return _qstr;
    }
    
    string toString() @trusted {
        return fromQString(_qstr);
    }
    
    QString* release() @safe nothrow @nogc {
        auto p = _qstr;
        _qstr = null;
        return p;
    }
}

/**
 * RAII wrapper for QObject-derived types
 */
struct QObjectWrapper(T) {
    private T* _obj;
    
    @disable this(this); // No copying
    
    this(T* obj) @safe pure nothrow @nogc {
        _obj = obj;
    }
    
    @property T* ptr() @safe pure nothrow @nogc {
        return _obj;
    }
    
    T* release() @safe nothrow @nogc {
        auto obj = _obj;
        _obj = null;
        return obj;
    }
    
    alias ptr this;
}

/**
 * Exception for Qt errors
 */
class QtException : Exception {
    this(string msg, string file = __FILE__, size_t line = __LINE__) @safe pure nothrow {
        super(msg, file, line);
    }
}

/**
 * Convert Qt geometry types to D equivalents
 */
struct Point {
    int x;
    int y;
    
    this(int x, int y) @safe pure nothrow @nogc {
        this.x = x;
        this.y = y;
    }
    
    QPoint toQPoint() @safe pure nothrow @nogc {
        return QPoint(x, y);
    }
    
    static Point fromQPoint(QPoint qpt) @safe pure nothrow @nogc {
        return Point(qpt.x, qpt.y);
    }
}

struct PointF {
    qreal x;
    qreal y;
    
    this(qreal x, qreal y) @safe pure nothrow @nogc {
        this.x = x;
        this.y = y;
    }
    
    QPointF toQPointF() @safe pure nothrow @nogc {
        return QPointF(x, y);
    }
    
    static PointF fromQPointF(QPointF qpt) @safe pure nothrow @nogc {
        return PointF(qpt.x, qpt.y);
    }
}

struct Size {
    int width;
    int height;
    
    this(int width, int height) @safe pure nothrow @nogc {
        this.width = width;
        this.height = height;
    }
    
    QSize toQSize() @safe pure nothrow @nogc {
        return QSize(width, height);
    }
    
    static Size fromQSize(QSize qsize) @safe pure nothrow @nogc {
        return Size(qsize.wd, qsize.ht);
    }
}

struct Rect {
    int x;
    int y;
    int width;
    int height;
    
    this(int x, int y, int width, int height) @safe pure nothrow @nogc {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }
    
    QRect toQRect() @safe pure nothrow @nogc {
        return QRect(x, y, width, height);
    }
    
    static Rect fromQRect(QRect qrect) @trusted {
        return Rect(
            qt_QRect_x(&qrect),
            qt_QRect_y(&qrect),
            qt_QRect_width(&qrect),
            qt_QRect_height(&qrect)
        );
    }
}
