/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.gnome.c.gdk;

import uim.gnome.c.glib;
import uim.gnome.c.gobject;

extern(C) nothrow @nogc:

// GDK Display
struct GdkDisplay {
    GObject parent_instance;
}

struct GdkDisplayClass {
    GObjectClass parent_class;
}

GType gdk_display_get_type();
GdkDisplay* gdk_display_get_default();
GdkDisplay* gdk_display_open(const(gchar)* display_name);
void gdk_display_close(GdkDisplay* display);
gboolean gdk_display_is_closed(GdkDisplay* display);
void gdk_display_sync(GdkDisplay* display);
void gdk_display_flush(GdkDisplay* display);
const(gchar)* gdk_display_get_name(GdkDisplay* display);

// GDK Monitor
struct GdkMonitor {
    GObject parent_instance;
}

GType gdk_monitor_get_type();
GdkDisplay* gdk_monitor_get_display(GdkMonitor* monitor);
void gdk_monitor_get_geometry(GdkMonitor* monitor, GdkRectangle* geometry);
int gdk_monitor_get_width_mm(GdkMonitor* monitor);
int gdk_monitor_get_height_mm(GdkMonitor* monitor);
const(gchar)* gdk_monitor_get_manufacturer(GdkMonitor* monitor);
const(gchar)* gdk_monitor_get_model(GdkMonitor* monitor);
int gdk_monitor_get_scale_factor(GdkMonitor* monitor);
int gdk_monitor_get_refresh_rate(GdkMonitor* monitor);

// GDK Rectangle
struct GdkRectangle {
    int x;
    int y;
    int width;
    int height;
}

gboolean gdk_rectangle_intersect(const(GdkRectangle)* src1, const(GdkRectangle)* src2,
                                 GdkRectangle* dest);
void gdk_rectangle_union(const(GdkRectangle)* src1, const(GdkRectangle)* src2,
                        GdkRectangle* dest);
gboolean gdk_rectangle_contains_point(const(GdkRectangle)* rect, int x, int y);
gboolean gdk_rectangle_equal(const(GdkRectangle)* rect1, const(GdkRectangle)* rect2);

// GDK RGBA Color
struct GdkRGBA {
    gdouble red;
    gdouble green;
    gdouble blue;
    gdouble alpha;
}

GType gdk_rgba_get_type();
GdkRGBA* gdk_rgba_copy(const(GdkRGBA)* rgba);
void gdk_rgba_free(GdkRGBA* rgba);
gboolean gdk_rgba_parse(GdkRGBA* rgba, const(gchar)* spec);
gchar* gdk_rgba_to_string(const(GdkRGBA)* rgba);
gboolean gdk_rgba_equal(const(GdkRGBA)* p1, const(GdkRGBA)* p2);
guint gdk_rgba_hash(const(GdkRGBA)* p);

// GDK Texture
struct GdkTexture {
    GObject parent_instance;
}

GType gdk_texture_get_type();
GdkTexture* gdk_texture_new_from_file(void* file, GError** error);
GdkTexture* gdk_texture_new_from_resource(const(gchar)* resource_path);
int gdk_texture_get_width(GdkTexture* texture);
int gdk_texture_get_height(GdkTexture* texture);

// GDK Cursor
struct GdkCursor {
    GObject parent_instance;
}

GType gdk_cursor_get_type();
GdkCursor* gdk_cursor_new_from_name(const(gchar)* name, GdkCursor* fallback);
GdkCursor* gdk_cursor_new_from_texture(GdkTexture* texture, int hotspot_x, int hotspot_y,
                                       GdkCursor* fallback);
const(gchar)* gdk_cursor_get_name(GdkCursor* cursor);
GdkTexture* gdk_cursor_get_texture(GdkCursor* cursor);
int gdk_cursor_get_hotspot_x(GdkCursor* cursor);
int gdk_cursor_get_hotspot_y(GdkCursor* cursor);

// GDK Events
alias GdkEventType = int;
enum : GdkEventType {
    GDK_DELETE = 0,
    GDK_MOTION_NOTIFY = 1,
    GDK_BUTTON_PRESS = 2,
    GDK_BUTTON_RELEASE = 3,
    GDK_KEY_PRESS = 4,
    GDK_KEY_RELEASE = 5,
    GDK_ENTER_NOTIFY = 6,
    GDK_LEAVE_NOTIFY = 7,
    GDK_FOCUS_CHANGE = 8,
    GDK_CONFIGURE = 9,
    GDK_PROXIMITY_IN = 10,
    GDK_PROXIMITY_OUT = 11,
    GDK_DRAG_ENTER = 12,
    GDK_DRAG_LEAVE = 13,
    GDK_DRAG_MOTION = 14,
    GDK_DROP_START = 15,
    GDK_SCROLL = 16,
    GDK_GRAB_BROKEN = 17,
    GDK_TOUCH_BEGIN = 18,
    GDK_TOUCH_UPDATE = 19,
    GDK_TOUCH_END = 20,
    GDK_TOUCH_CANCEL = 21,
    GDK_TOUCHPAD_SWIPE = 22,
    GDK_TOUCHPAD_PINCH = 23,
    GDK_PAD_BUTTON_PRESS = 24,
    GDK_PAD_BUTTON_RELEASE = 25,
    GDK_PAD_RING = 26,
    GDK_PAD_STRIP = 27,
    GDK_EVENT_LAST = 28
}

struct GdkEvent {
    GType type;
}

GType gdk_event_get_type();
GdkEventType gdk_event_get_event_type(GdkEvent* event);
void gdk_event_unref(GdkEvent* event);
GdkEvent* gdk_event_ref(GdkEvent* event);

// GDK Key values
alias GdkModifierType = int;
enum : GdkModifierType {
    GDK_SHIFT_MASK = 1 << 0,
    GDK_LOCK_MASK = 1 << 1,
    GDK_CONTROL_MASK = 1 << 2,
    GDK_ALT_MASK = 1 << 3,
    GDK_BUTTON1_MASK = 1 << 8,
    GDK_BUTTON2_MASK = 1 << 9,
    GDK_BUTTON3_MASK = 1 << 10,
    GDK_BUTTON4_MASK = 1 << 11,
    GDK_BUTTON5_MASK = 1 << 12,
    GDK_SUPER_MASK = 1 << 26,
    GDK_HYPER_MASK = 1 << 27,
    GDK_META_MASK = 1 << 28
}

// Key constants
enum : uint {
    GDK_KEY_Escape = 0xff1b,
    GDK_KEY_Return = 0xff0d,
    GDK_KEY_BackSpace = 0xff08,
    GDK_KEY_Tab = 0xff09,
    GDK_KEY_space = 0x020,
    GDK_KEY_Delete = 0xffff,
    GDK_KEY_Home = 0xff50,
    GDK_KEY_End = 0xff57,
    GDK_KEY_Page_Up = 0xff55,
    GDK_KEY_Page_Down = 0xff56,
    GDK_KEY_Left = 0xff51,
    GDK_KEY_Up = 0xff52,
    GDK_KEY_Right = 0xff53,
    GDK_KEY_Down = 0xff54,
    GDK_KEY_F1 = 0xffbe,
    GDK_KEY_F2 = 0xffbf,
    GDK_KEY_F3 = 0xffc0,
    GDK_KEY_F4 = 0xffc1,
    GDK_KEY_F5 = 0xffc2,
    GDK_KEY_F6 = 0xffc3,
    GDK_KEY_F7 = 0xffc4,
    GDK_KEY_F8 = 0xffc5,
    GDK_KEY_F9 = 0xffc6,
    GDK_KEY_F10 = 0xffc7,
    GDK_KEY_F11 = 0xffc8,
    GDK_KEY_F12 = 0xffc9
}

// GDK Clipboard
struct GdkClipboard {
    GObject parent_instance;
}

GType gdk_clipboard_get_type();
GdkClipboard* gdk_display_get_clipboard(GdkDisplay* display);
void gdk_clipboard_set_text(GdkClipboard* clipboard, const(gchar)* text);
void gdk_clipboard_read_text_async(GdkClipboard* clipboard, void* cancellable,
                                   void* callback, gpointer user_data);

// GDK Surface
struct GdkSurface {
    GObject parent_instance;
}

GType gdk_surface_get_type();
GdkDisplay* gdk_surface_get_display(GdkSurface* surface);
int gdk_surface_get_width(GdkSurface* surface);
int gdk_surface_get_height(GdkSurface* surface);
void gdk_surface_queue_render(GdkSurface* surface);
