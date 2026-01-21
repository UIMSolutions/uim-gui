/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.c.qtcore;

import core.stdc.config;

extern(C++) nothrow @nogc:

// Qt basic types
alias qint8 = byte;
alias quint8 = ubyte;
alias qint16 = short;
alias quint16 = ushort;
alias qint32 = int;
alias quint32 = uint;
alias qint64 = long;
alias quint64 = ulong;
alias qreal = double;
alias qsizetype = ptrdiff_t;

// Forward declarations
struct QObject;
struct QWidget;
struct QApplication;
struct QCoreApplication;
struct QString;
struct QStringView;
struct QByteArray;
struct QVariant;
struct QMetaObject;
struct QList;
struct QVector;
struct QMap;
struct QHash;

// QString - Qt's string class
extern(C) {
    QString* qt_QString_new();
    QString* qt_QString_fromUtf8(const(char)* str, qsizetype size);
    QString* qt_QString_fromLatin1(const(char)* str, qsizetype size);
    void qt_QString_delete(QString* str);
    const(char)* qt_QString_toUtf8(QString* str);
    const(char)* qt_QString_toLatin1(QString* str);
    qsizetype qt_QString_size(QString* str);
    qsizetype qt_QString_length(QString* str);
    bool qt_QString_isEmpty(QString* str);
    void qt_QString_clear(QString* str);
    void qt_QString_append(QString* str, QString* other);
    void qt_QString_prepend(QString* str, QString* other);
    QString* qt_QString_arg(QString* str, QString* a);
    int qt_QString_compare(QString* s1, QString* s2);
}

// QByteArray - Qt's byte array class
extern(C) {
    QByteArray* qt_QByteArray_new();
    QByteArray* qt_QByteArray_fromRawData(const(char)* data, qsizetype size);
    void qt_QByteArray_delete(QByteArray* arr);
    const(char)* qt_QByteArray_data(QByteArray* arr);
    qsizetype qt_QByteArray_size(QByteArray* arr);
    bool qt_QByteArray_isEmpty(QByteArray* arr);
    void qt_QByteArray_clear(QByteArray* arr);
}

// QVariant - Qt's variant type
extern(C) {
    QVariant* qt_QVariant_new();
    QVariant* qt_QVariant_fromInt(int value);
    QVariant* qt_QVariant_fromDouble(double value);
    QVariant* qt_QVariant_fromBool(bool value);
    QVariant* qt_QVariant_fromString(QString* value);
    void qt_QVariant_delete(QVariant* variant);
    int qt_QVariant_toInt(QVariant* variant, bool* ok);
    double qt_QVariant_toDouble(QVariant* variant, bool* ok);
    bool qt_QVariant_toBool(QVariant* variant);
    QString* qt_QVariant_toString(QVariant* variant);
    bool qt_QVariant_isValid(QVariant* variant);
    bool qt_QVariant_isNull(QVariant* variant);
    int qt_QVariant_userType(QVariant* variant);
}

// QObject - Base class for all Qt objects
extern(C) {
    void qt_QObject_delete(QObject* obj);
    QString* qt_QObject_objectName(QObject* obj);
    void qt_QObject_setObjectName(QObject* obj, QString* name);
    QObject* qt_QObject_parent(QObject* obj);
    void qt_QObject_setParent(QObject* obj, QObject* parent);
    bool qt_QObject_inherits(QObject* obj, const(char)* classname);
    bool qt_QObject_isWidgetType(QObject* obj);
    bool qt_QObject_isWindowType(QObject* obj);
    void qt_QObject_deleteLater(QObject* obj);
    
    // Signals and slots
    bool qt_QObject_connect(QObject* sender, const(char)* signal,
                           QObject* receiver, const(char)* slot);
    bool qt_QObject_disconnect(QObject* sender, const(char)* signal,
                              QObject* receiver, const(char)* slot);
    bool qt_QObject_blockSignals(QObject* obj, bool block);
    
    // Properties
    QVariant* qt_QObject_property(QObject* obj, const(char)* name);
    bool qt_QObject_setProperty(QObject* obj, const(char)* name, QVariant* value);
}

// QMetaObject - Meta-object information
extern(C) {
    const(char)* qt_QMetaObject_className(QMetaObject* meta);
    QMetaObject* qt_QMetaObject_superClass(QMetaObject* meta);
}

// QCoreApplication - Core application functionality
extern(C) {
    QCoreApplication* qt_QCoreApplication_new(int* argc, char** argv);
    void qt_QCoreApplication_delete(QCoreApplication* app);
    int qt_QCoreApplication_exec();
    void qt_QCoreApplication_quit();
    void qt_QCoreApplication_exit(int returnCode);
    QCoreApplication* qt_QCoreApplication_instance();
    QString* qt_QCoreApplication_applicationName();
    void qt_QCoreApplication_setApplicationName(QString* name);
    QString* qt_QCoreApplication_applicationVersion();
    void qt_QCoreApplication_setApplicationVersion(QString* version);
    QString* qt_QCoreApplication_organizationName();
    void qt_QCoreApplication_setOrganizationName(QString* name);
    QString* qt_QCoreApplication_organizationDomain();
    void qt_QCoreApplication_setOrganizationDomain(QString* domain);
    void qt_QCoreApplication_processEvents();
}

// QTimer - Timer functionality
struct QTimer;
extern(C) {
    QTimer* qt_QTimer_new(QObject* parent);
    void qt_QTimer_delete(QTimer* timer);
    void qt_QTimer_start(QTimer* timer, int msec);
    void qt_QTimer_start_noarg(QTimer* timer);
    void qt_QTimer_stop(QTimer* timer);
    void qt_QTimer_setInterval(QTimer* timer, int msec);
    int qt_QTimer_interval(QTimer* timer);
    bool qt_QTimer_isActive(QTimer* timer);
    void qt_QTimer_setSingleShot(QTimer* timer, bool singleShot);
    bool qt_QTimer_isSingleShot(QTimer* timer);
    int qt_QTimer_remainingTime(QTimer* timer);
}

// QPoint - 2D point
struct QPoint {
    int x;
    int y;
}

extern(C) {
    QPoint qt_QPoint_new(int x, int y);
    int qt_QPoint_x(QPoint* point);
    int qt_QPoint_y(QPoint* point);
    void qt_QPoint_setX(QPoint* point, int x);
    void qt_QPoint_setY(QPoint* point, int y);
    bool qt_QPoint_isNull(QPoint* point);
}

// QPointF - 2D point with floating point precision
struct QPointF {
    qreal x;
    qreal y;
}

extern(C) {
    QPointF qt_QPointF_new(qreal x, qreal y);
    qreal qt_QPointF_x(QPointF* point);
    qreal qt_QPointF_y(QPointF* point);
    void qt_QPointF_setX(QPointF* point, qreal x);
    void qt_QPointF_setY(QPointF* point, qreal y);
    bool qt_QPointF_isNull(QPointF* point);
}

// QSize - 2D size
struct QSize {
    int wd;
    int ht;
}

extern(C) {
    QSize qt_QSize_new(int width, int height);
    int qt_QSize_width(QSize* size);
    int qt_QSize_height(QSize* size);
    void qt_QSize_setWidth(QSize* size, int width);
    void qt_QSize_setHeight(QSize* size, int height);
    bool qt_QSize_isEmpty(QSize* size);
    bool qt_QSize_isNull(QSize* size);
    bool qt_QSize_isValid(QSize* size);
}

// QSizeF - 2D size with floating point precision
struct QSizeF {
    qreal wd;
    qreal ht;
}

extern(C) {
    QSizeF qt_QSizeF_new(qreal width, qreal height);
    qreal qt_QSizeF_width(QSizeF* size);
    qreal qt_QSizeF_height(QSizeF* size);
    void qt_QSizeF_setWidth(QSizeF* size, qreal width);
    void qt_QSizeF_setHeight(QSizeF* size, qreal height);
    bool qt_QSizeF_isEmpty(QSizeF* size);
    bool qt_QSizeF_isNull(QSizeF* size);
    bool qt_QSizeF_isValid(QSizeF* size);
}

// QRect - Rectangle
struct QRect {
    int x1;
    int y1;
    int x2;
    int y2;
}

extern(C) {
    QRect qt_QRect_new(int x, int y, int width, int height);
    int qt_QRect_x(QRect* rect);
    int qt_QRect_y(QRect* rect);
    int qt_QRect_width(QRect* rect);
    int qt_QRect_height(QRect* rect);
    void qt_QRect_setX(QRect* rect, int x);
    void qt_QRect_setY(QRect* rect, int y);
    void qt_QRect_setWidth(QRect* rect, int width);
    void qt_QRect_setHeight(QRect* rect, int height);
    bool qt_QRect_isEmpty(QRect* rect);
    bool qt_QRect_isNull(QRect* rect);
    bool qt_QRect_isValid(QRect* rect);
    bool qt_QRect_contains(QRect* rect, QPoint* point);
    bool qt_QRect_intersects(QRect* rect, QRect* other);
}

// QRectF - Rectangle with floating point precision
struct QRectF {
    qreal xp;
    qreal yp;
    qreal w;
    qreal h;
}

extern(C) {
    QRectF qt_QRectF_new(qreal x, qreal y, qreal width, qreal height);
    qreal qt_QRectF_x(QRectF* rect);
    qreal qt_QRectF_y(QRectF* rect);
    qreal qt_QRectF_width(QRectF* rect);
    qreal qt_QRectF_height(QRectF* rect);
    void qt_QRectF_setX(QRectF* rect, qreal x);
    void qt_QRectF_setY(QRectF* rect, qreal y);
    void qt_QRectF_setWidth(QRectF* rect, qreal width);
    void qt_QRectF_setHeight(QRectF* rect, qreal height);
    bool qt_QRectF_isEmpty(QRectF* rect);
    bool qt_QRectF_isNull(QRectF* rect);
    bool qt_QRectF_isValid(QRectF* rect);
}

// QList - Qt's list container
extern(C) {
    void* qt_QList_new();
    void qt_QList_delete(void* list);
    qsizetype qt_QList_size(void* list);
    bool qt_QList_isEmpty(void* list);
    void qt_QList_clear(void* list);
    void qt_QList_append(void* list, void* value);
    void qt_QList_prepend(void* list, void* value);
    void* qt_QList_at(void* list, qsizetype index);
}

// QDir - Directory operations
struct QDir;
extern(C) {
    QDir* qt_QDir_new(QString* path);
    void qt_QDir_delete(QDir* dir);
    QString* qt_QDir_path(QDir* dir);
    QString* qt_QDir_absolutePath(QDir* dir);
    bool qt_QDir_exists(QDir* dir);
    bool qt_QDir_isReadable(QDir* dir);
    bool qt_QDir_mkdir(QDir* dir, QString* dirName);
    bool qt_QDir_rmdir(QDir* dir, QString* dirName);
    bool qt_QDir_remove(QDir* dir, QString* fileName);
    bool qt_QDir_rename(QDir* dir, QString* oldName, QString* newName);
}

// QFile - File operations
struct QFile;
extern(C) {
    QFile* qt_QFile_new(QString* name);
    void qt_QFile_delete(QFile* file);
    bool qt_QFile_open(QFile* file, int mode);
    void qt_QFile_close(QFile* file);
    bool qt_QFile_exists(QFile* file);
    bool qt_QFile_remove(QFile* file);
    bool qt_QFile_rename(QFile* file, QString* newName);
    qint64 qt_QFile_size(QFile* file);
    qint64 qt_QFile_read(QFile* file, char* data, qint64 maxSize);
    qint64 qt_QFile_write(QFile* file, const(char)* data, qint64 maxSize);
}

// File open modes
enum QIODeviceOpenMode {
    NotOpen = 0x0000,
    ReadOnly = 0x0001,
    WriteOnly = 0x0002,
    ReadWrite = ReadOnly | WriteOnly,
    Append = 0x0004,
    Truncate = 0x0008,
    Text = 0x0010,
    Unbuffered = 0x0020
}
