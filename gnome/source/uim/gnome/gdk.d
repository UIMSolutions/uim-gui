/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.gdk;

/**
 * D wrappers for GDK functionality
 * Provides idiomatic D interfaces to GDK C functions
 */

public import uim.gnome.c.gdk;
public import uim.gnome.gobject;
public import uim.gnome.types;

/**
 * Display wrapper
 */
class Display : GObjectWrapper {
    private this(GdkDisplay* display) @safe pure nothrow @nogc {
        super(cast(GObject*)display);
    }
    
    static Display getDefault() @trusted {
        auto display = gdk_display_get_default();
        return display ? new Display(display) : null;
    }
    
    static Display open(string displayName) @trusted {
        auto display = gdk_display_open(toGString(displayName));
        return display ? new Display(display) : null;
    }
    
    @property GdkDisplay* gdkDisplay() @safe pure nothrow @nogc {
        return cast(GdkDisplay*)_gobject;
    }
    
    @property string name() @trusted {
        return fromGString(gdk_display_get_name(gdkDisplay));
    }
    
    void close() @trusted {
        gdk_display_close(gdkDisplay);
    }
    
    @property bool isClosed() @trusted {
        return fromGBoolean(gdk_display_is_closed(gdkDisplay));
    }
    
    void sync() @trusted {
        gdk_display_sync(gdkDisplay);
    }
    
    void flush() @trusted {
        gdk_display_flush(gdkDisplay);
    }
}

/**
 * RGBA Color wrapper
 */
struct RGBA {
    double red;
    double green;
    double blue;
    double alpha;
    
    this(double r, double g, double b, double a = 1.0) @safe pure nothrow @nogc {
        red = r;
        green = g;
        blue = b;
        alpha = a;
    }
    
    static RGBA parse(string spec) @trusted {
        GdkRGBA rgba;
        if (gdk_rgba_parse(&rgba, toGString(spec))) {
            return RGBA(rgba.red, rgba.green, rgba.blue, rgba.alpha);
        }
        return RGBA(0, 0, 0, 1);
    }
    
    string toString() @trusted {
        GdkRGBA rgba = GdkRGBA(red, green, blue, alpha);
        auto cstr = gdk_rgba_to_string(&rgba);
        auto result = fromGString(cstr);
        g_free(cast(void*)cstr);
        return result;
    }
    
    GdkRGBA toGdkRGBA() @safe pure nothrow @nogc {
        return GdkRGBA(red, green, blue, alpha);
    }
}

/**
 * Rectangle wrapper
 */
struct Rectangle {
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
    
    bool intersects(Rectangle other) @trusted {
        GdkRectangle r1 = toGdkRectangle();
        GdkRectangle r2 = other.toGdkRectangle();
        GdkRectangle dest;
        return fromGBoolean(gdk_rectangle_intersect(&r1, &r2, &dest));
    }
    
    Rectangle union_(Rectangle other) @trusted {
        GdkRectangle r1 = toGdkRectangle();
        GdkRectangle r2 = other.toGdkRectangle();
        GdkRectangle dest;
        gdk_rectangle_union(&r1, &r2, &dest);
        return Rectangle(dest.x, dest.y, dest.width, dest.height);
    }
    
    bool containsPoint(int px, int py) @trusted {
        GdkRectangle r = toGdkRectangle();
        return fromGBoolean(gdk_rectangle_contains_point(&r, px, py));
    }
    
    GdkRectangle toGdkRectangle() @safe pure nothrow @nogc {
        return GdkRectangle(x, y, width, height);
    }
}
