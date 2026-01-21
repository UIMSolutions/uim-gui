/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.qtgui;

/**
 * D wrappers for Qt GUI functionality
 * Provides idiomatic D interfaces to Qt GUI C++ classes
 */

public import uim.kde.c.qtgui;
public import uim.kde.types;

/**
 * Color wrapper
 */
struct Color {
    int r, g, b, a;
    
    this(int red, int green, int blue, int alpha = 255) @safe pure nothrow @nogc {
        r = red;
        g = green;
        b = blue;
        a = alpha;
    }
    
    static Color fromName(string name) @trusted {
        auto qname = toQString(name);
        auto qcolor = qt_QColor_fromName(qname);
        qt_QString_delete(qname);
        
        Color result = Color(
            qt_QColor_red(qcolor),
            qt_QColor_green(qcolor),
            qt_QColor_blue(qcolor),
            qt_QColor_alpha(qcolor)
        );
        qt_QColor_delete(qcolor);
        return result;
    }
    
    string toName() @trusted {
        auto qcolor = qt_QColor_fromRgb(r, g, b, a);
        auto qname = qt_QColor_name(qcolor);
        auto result = fromQString(qname);
        qt_QString_delete(qname);
        qt_QColor_delete(qcolor);
        return result;
    }
}

/**
 * Font wrapper
 */
class Font {
    private QFont* _qfont;
    
    this(string family = "") @trusted {
        if (family.length > 0) {
            auto qfamily = toQString(family);
            _qfont = qt_QFont_fromFamily(qfamily);
            qt_QString_delete(qfamily);
        } else {
            _qfont = qt_QFont_new();
        }
    }
    
    ~this() @trusted {
        if (_qfont !is null) {
            qt_QFont_delete(_qfont);
        }
    }
    
    @property string family() @trusted {
        auto qfamily = qt_QFont_family(_qfont);
        scope(exit) qt_QString_delete(qfamily);
        return fromQString(qfamily);
    }
    
    @property void family(string f) @trusted {
        auto qfamily = toQString(f);
        qt_QFont_setFamily(_qfont, qfamily);
        qt_QString_delete(qfamily);
    }
    
    @property int pointSize() @trusted {
        return qt_QFont_pointSize(_qfont);
    }
    
    @property void pointSize(int size) @trusted {
        qt_QFont_setPointSize(_qfont, size);
    }
    
    @property bool bold() @trusted {
        return qt_QFont_bold(_qfont);
    }
    
    @property void bold(bool b) @trusted {
        qt_QFont_setBold(_qfont, b);
    }
    
    @property bool italic() @trusted {
        return qt_QFont_italic(_qfont);
    }
    
    @property void italic(bool i) @trusted {
        qt_QFont_setItalic(_qfont, i);
    }
    
    @property QFont* handle() @safe pure nothrow @nogc {
        return _qfont;
    }
}
