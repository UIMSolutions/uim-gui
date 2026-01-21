/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.c.qtgui;

import uim.kde.c.qtcore;

extern(C++) nothrow @nogc:

// QColor - Color representation
struct QColor;
extern(C) {
    QColor* qt_QColor_new();
    QColor* qt_QColor_fromRgb(int r, int g, int b, int a);
    QColor* qt_QColor_fromRgba(uint rgba);
    QColor* qt_QColor_fromHsv(int h, int s, int v, int a);
    QColor* qt_QColor_fromName(QString* name);
    void qt_QColor_delete(QColor* color);
    int qt_QColor_red(QColor* color);
    int qt_QColor_green(QColor* color);
    int qt_QColor_blue(QColor* color);
    int qt_QColor_alpha(QColor* color);
    void qt_QColor_setRed(QColor* color, int red);
    void qt_QColor_setGreen(QColor* color, int green);
    void qt_QColor_setBlue(QColor* color, int blue);
    void qt_QColor_setAlpha(QColor* color, int alpha);
    QString* qt_QColor_name(QColor* color);
    bool qt_QColor_isValid(QColor* color);
}

// QFont - Font representation
struct QFont;
extern(C) {
    QFont* qt_QFont_new();
    QFont* qt_QFont_fromFamily(QString* family);
    void qt_QFont_delete(QFont* font);
    QString* qt_QFont_family(QFont* font);
    void qt_QFont_setFamily(QFont* font, QString* family);
    int qt_QFont_pointSize(QFont* font);
    void qt_QFont_setPointSize(QFont* font, int pointSize);
    int qt_QFont_pixelSize(QFont* font);
    void qt_QFont_setPixelSize(QFont* font, int pixelSize);
    int qt_QFont_weight(QFont* font);
    void qt_QFont_setWeight(QFont* font, int weight);
    bool qt_QFont_bold(QFont* font);
    void qt_QFont_setBold(QFont* font, bool bold);
    bool qt_QFont_italic(QFont* font);
    void qt_QFont_setItalic(QFont* font, bool italic);
    bool qt_QFont_underline(QFont* font);
    void qt_QFont_setUnderline(QFont* font, bool underline);
    bool qt_QFont_strikeOut(QFont* font);
    void qt_QFont_setStrikeOut(QFont* font, bool strikeOut);
}

// Font weights
enum QFontWeight {
    Thin = 100,
    ExtraLight = 200,
    Light = 300,
    Normal = 400,
    Medium = 500,
    DemiBold = 600,
    Bold = 700,
    ExtraBold = 800,
    Black = 900
}

// QPixmap - Off-screen image representation
struct QPixmap;
extern(C) {
    QPixmap* qt_QPixmap_new();
    QPixmap* qt_QPixmap_fromSize(int width, int height);
    QPixmap* qt_QPixmap_fromFile(QString* fileName);
    void qt_QPixmap_delete(QPixmap* pixmap);
    int qt_QPixmap_width(QPixmap* pixmap);
    int qt_QPixmap_height(QPixmap* pixmap);
    QSize qt_QPixmap_size(QPixmap* pixmap);
    bool qt_QPixmap_isNull(QPixmap* pixmap);
    bool qt_QPixmap_save(QPixmap* pixmap, QString* fileName, const(char)* format);
    QPixmap* qt_QPixmap_scaled(QPixmap* pixmap, int width, int height, int aspectRatioMode);
}

// QImage - Hardware-independent image representation
struct QImage;
extern(C) {
    QImage* qt_QImage_new();
    QImage* qt_QImage_fromSize(int width, int height, int format);
    QImage* qt_QImage_fromFile(QString* fileName);
    void qt_QImage_delete(QImage* image);
    int qt_QImage_width(QImage* image);
    int qt_QImage_height(QImage* image);
    QSize qt_QImage_size(QImage* image);
    int qt_QImage_format(QImage* image);
    bool qt_QImage_isNull(QImage* image);
    bool qt_QImage_save(QImage* image, QString* fileName, const(char)* format);
    QImage* qt_QImage_scaled(QImage* image, int width, int height, int aspectRatioMode);
    QPixmap* qt_QImage_toPixmap(QImage* image);
}

// Image formats
enum QImageFormat {
    Format_Invalid = 0,
    Format_Mono = 1,
    Format_MonoLSB = 2,
    Format_Indexed8 = 3,
    Format_RGB32 = 4,
    Format_ARGB32 = 5,
    Format_ARGB32_Premultiplied = 6,
    Format_RGB16 = 7,
    Format_ARGB8565_Premultiplied = 8,
    Format_RGB666 = 9,
    Format_ARGB6666_Premultiplied = 10,
    Format_RGB555 = 11,
    Format_ARGB8555_Premultiplied = 12,
    Format_RGB888 = 13,
    Format_RGB444 = 14,
    Format_ARGB4444_Premultiplied = 15,
    Format_RGBX8888 = 16,
    Format_RGBA8888 = 17,
    Format_RGBA8888_Premultiplied = 18
}

// Aspect ratio modes
enum QtAspectRatioMode {
    IgnoreAspectRatio = 0,
    KeepAspectRatio = 1,
    KeepAspectRatioByExpanding = 2
}

// QIcon - Scalable icons
struct QIcon;
extern(C) {
    QIcon* qt_QIcon_new();
    QIcon* qt_QIcon_fromPixmap(QPixmap* pixmap);
    QIcon* qt_QIcon_fromFile(QString* fileName);
    void qt_QIcon_delete(QIcon* icon);
    bool qt_QIcon_isNull(QIcon* icon);
    QPixmap* qt_QIcon_pixmap(QIcon* icon, int width, int height);
    void qt_QIcon_addFile(QIcon* icon, QString* fileName);
    void qt_QIcon_addPixmap(QIcon* icon, QPixmap* pixmap);
}

// QPainter - Painting operations
struct QPainter;
extern(C) {
    QPainter* qt_QPainter_new();
    void qt_QPainter_delete(QPainter* painter);
    bool qt_QPainter_begin(QPainter* painter, void* device);
    bool qt_QPainter_end(QPainter* painter);
    void qt_QPainter_drawPoint(QPainter* painter, int x, int y);
    void qt_QPainter_drawLine(QPainter* painter, int x1, int y1, int x2, int y2);
    void qt_QPainter_drawRect(QPainter* painter, int x, int y, int width, int height);
    void qt_QPainter_drawEllipse(QPainter* painter, int x, int y, int width, int height);
    void qt_QPainter_drawText(QPainter* painter, int x, int y, QString* text);
    void qt_QPainter_drawPixmap(QPainter* painter, int x, int y, QPixmap* pixmap);
    void qt_QPainter_fillRect(QPainter* painter, int x, int y, int width, int height, QColor* color);
    void qt_QPainter_setPen(QPainter* painter, void* pen);
    void qt_QPainter_setBrush(QPainter* painter, void* brush);
    void qt_QPainter_setFont(QPainter* painter, QFont* font);
}

// QPen - Pen for drawing lines
struct QPen;
extern(C) {
    QPen* qt_QPen_new();
    QPen* qt_QPen_fromColor(QColor* color);
    void qt_QPen_delete(QPen* pen);
    QColor* qt_QPen_color(QPen* pen);
    void qt_QPen_setColor(QPen* pen, QColor* color);
    int qt_QPen_width(QPen* pen);
    void qt_QPen_setWidth(QPen* pen, int width);
    int qt_QPen_style(QPen* pen);
    void qt_QPen_setStyle(QPen* pen, int style);
}

// Pen styles
enum QtPenStyle {
    NoPen = 0,
    SolidLine = 1,
    DashLine = 2,
    DotLine = 3,
    DashDotLine = 4,
    DashDotDotLine = 5
}

// QBrush - Brush for filling shapes
struct QBrush;
extern(C) {
    QBrush* qt_QBrush_new();
    QBrush* qt_QBrush_fromColor(QColor* color);
    void qt_QBrush_delete(QBrush* brush);
    QColor* qt_QBrush_color(QBrush* brush);
    void qt_QBrush_setColor(QBrush* brush, QColor* color);
    int qt_QBrush_style(QBrush* brush);
    void qt_QBrush_setStyle(QBrush* brush, int style);
}

// Brush styles
enum QtBrushStyle {
    NoBrush = 0,
    SolidPattern = 1,
    Dense1Pattern = 2,
    Dense2Pattern = 3,
    Dense3Pattern = 4,
    Dense4Pattern = 5,
    Dense5Pattern = 6,
    Dense6Pattern = 7,
    Dense7Pattern = 8,
    HorPattern = 9,
    VerPattern = 10,
    CrossPattern = 11,
    BDiagPattern = 12,
    FDiagPattern = 13,
    DiagCrossPattern = 14
}

// QPalette - Widget color roles
struct QPalette;
extern(C) {
    QPalette* qt_QPalette_new();
    void qt_QPalette_delete(QPalette* palette);
    QColor* qt_QPalette_color(QPalette* palette, int role);
    void qt_QPalette_setColor(QPalette* palette, int role, QColor* color);
}

// Color roles
enum QPaletteColorRole {
    WindowText = 0,
    Button = 1,
    Light = 2,
    Midlight = 3,
    Dark = 4,
    Mid = 5,
    Text = 6,
    BrightText = 7,
    ButtonText = 8,
    Base = 9,
    Window = 10,
    Shadow = 11,
    Highlight = 12,
    HighlightedText = 13,
    Link = 14,
    LinkVisited = 15,
    AlternateBase = 16,
    ToolTipBase = 17,
    ToolTipText = 18,
    PlaceholderText = 19
}

// QCursor - Mouse cursor
struct QCursor;
extern(C) {
    QCursor* qt_QCursor_new();
    QCursor* qt_QCursor_fromShape(int shape);
    void qt_QCursor_delete(QCursor* cursor);
    QPoint qt_QCursor_pos();
    void qt_QCursor_setPos(int x, int y);
}

// Cursor shapes
enum QtCursorShape {
    ArrowCursor = 0,
    UpArrowCursor = 1,
    CrossCursor = 2,
    WaitCursor = 3,
    IBeamCursor = 4,
    SizeVerCursor = 5,
    SizeHorCursor = 6,
    SizeBDiagCursor = 7,
    SizeFDiagCursor = 8,
    SizeAllCursor = 9,
    BlankCursor = 10,
    SplitVCursor = 11,
    SplitHCursor = 12,
    PointingHandCursor = 13,
    ForbiddenCursor = 14,
    WhatsThisCursor = 15,
    BusyCursor = 16,
    OpenHandCursor = 17,
    ClosedHandCursor = 18,
    DragCopyCursor = 19,
    DragMoveCursor = 20,
    DragLinkCursor = 21
}

// Key codes
enum QtKey {
    Key_Escape = 0x01000000,
    Key_Tab = 0x01000001,
    Key_Backtab = 0x01000002,
    Key_Backspace = 0x01000003,
    Key_Return = 0x01000004,
    Key_Enter = 0x01000005,
    Key_Insert = 0x01000006,
    Key_Delete = 0x01000007,
    Key_Pause = 0x01000008,
    Key_Print = 0x01000009,
    Key_Home = 0x01000010,
    Key_End = 0x01000011,
    Key_Left = 0x01000012,
    Key_Up = 0x01000013,
    Key_Right = 0x01000014,
    Key_Down = 0x01000015,
    Key_PageUp = 0x01000016,
    Key_PageDown = 0x01000017,
    Key_Space = 0x20,
    Key_F1 = 0x01000030,
    Key_F2 = 0x01000031,
    Key_F3 = 0x01000032,
    Key_F4 = 0x01000033,
    Key_F5 = 0x01000034,
    Key_F6 = 0x01000035,
    Key_F7 = 0x01000036,
    Key_F8 = 0x01000037,
    Key_F9 = 0x01000038,
    Key_F10 = 0x01000039,
    Key_F11 = 0x0100003a,
    Key_F12 = 0x0100003b
}

// Keyboard modifiers
enum QtKeyboardModifier {
    NoModifier = 0x00000000,
    ShiftModifier = 0x02000000,
    ControlModifier = 0x04000000,
    AltModifier = 0x08000000,
    MetaModifier = 0x10000000,
    KeypadModifier = 0x20000000,
    GroupSwitchModifier = 0x40000000
}
