/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.qtcore;

/**
 * D wrappers for Qt Core functionality
 * Provides idiomatic D interfaces to Qt Core C++ classes
 */

public import uim.kde.c.qtcore;
public import uim.kde.types;

/**
 * D wrapper for QString
 */
class QtString {
    private QString* _qstr;
    
    this(string str = "") @trusted {
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
    
    void append(string str) @trusted {
        auto other = toQString(str);
        qt_QString_append(_qstr, other);
        qt_QString_delete(other);
    }
    
    void prepend(string str) @trusted {
        auto other = toQString(str);
        qt_QString_prepend(_qstr, other);
        qt_QString_delete(other);
    }
    
    override string toString() @trusted {
        return fromQString(_qstr);
    }
    
    @property size_t length() @trusted {
        return cast(size_t)qt_QString_length(_qstr);
    }
    
    @property bool isEmpty() @trusted {
        return qt_QString_isEmpty(_qstr);
    }
    
    void clear() @trusted {
        qt_QString_clear(_qstr);
    }
    
    @property QString* handle() @safe pure nothrow @nogc {
        return _qstr;
    }
}

/**
 * Base class for QObject wrappers
 */
abstract class QtObject {
    protected QObject* _qobject;
    
    this(QObject* obj) @safe pure nothrow @nogc {
        _qobject = obj;
    }
    
    @property QObject* handle() @safe pure nothrow @nogc {
        return _qobject;
    }
    
    @property string objectName() @trusted {
        auto qname = qt_QObject_objectName(_qobject);
        scope(exit) qt_QString_delete(qname);
        return fromQString(qname);
    }
    
    @property void objectName(string name) @trusted {
        auto qname = toQString(name);
        qt_QObject_setObjectName(_qobject, qname);
        qt_QString_delete(qname);
    }
    
    void deleteLater() @trusted {
        qt_QObject_deleteLater(_qobject);
    }
    
    bool blockSignals(bool block) @trusted {
        return qt_QObject_blockSignals(_qobject, block);
    }
    
    T getProperty(T)(string name) @trusted {
        return .getProperty!T(_qobject, name);
    }
    
    void setProperty(T)(string name, T value) @trusted {
        .setProperty(_qobject, name, value);
    }
}

/**
 * Application wrapper
 */
class CoreApplication : QtObject {
    private static CoreApplication _instance;
    
    this(string[] args) @trusted {
        // Convert D args to C args
        import core.stdc.stdlib : malloc;
        int argc = cast(int)args.length;
        char** argv = cast(char**)malloc(char*.sizeof * args.length);
        foreach (i, arg; args) {
            argv[i] = cast(char*)toStringz(arg);
        }
        
        auto app = qt_QCoreApplication_new(&argc, argv);
        super(cast(QObject*)app);
        _instance = this;
    }
    
    ~this() @trusted {
        qt_QCoreApplication_delete(cast(QCoreApplication*)_qobject);
    }
    
    int exec() @trusted {
        return qt_QCoreApplication_exec();
    }
    
    void quit() @trusted {
        qt_QCoreApplication_quit();
    }
    
    void exit(int returnCode = 0) @trusted {
        qt_QCoreApplication_exit(returnCode);
    }
    
    static CoreApplication instance() @safe {
        return _instance;
    }
    
    @property static string applicationName() @trusted {
        auto qname = qt_QCoreApplication_applicationName();
        scope(exit) qt_QString_delete(qname);
        return fromQString(qname);
    }
    
    @property static void applicationName(string name) @trusted {
        auto qname = toQString(name);
        qt_QCoreApplication_setApplicationName(qname);
        qt_QString_delete(qname);
    }
    
    @property static string applicationVersion() @trusted {
        auto qver = qt_QCoreApplication_applicationVersion();
        scope(exit) qt_QString_delete(qver);
        return fromQString(qver);
    }
    
    @property static void applicationVersion(string ver) @trusted {
        auto qver = toQString(ver);
        qt_QCoreApplication_setApplicationVersion(qver);
        qt_QString_delete(qver);
    }
    
    static void processEvents() @trusted {
        qt_QCoreApplication_processEvents();
    }
}

/**
 * Timer wrapper
 */
class Timer : QtObject {
    this(QtObject parent = null) @trusted {
        auto timer = qt_QTimer_new(parent ? parent.handle : null);
        super(cast(QObject*)timer);
    }
    
    ~this() @trusted {
        qt_QTimer_delete(cast(QTimer*)_qobject);
    }
    
    void start(int msec) @trusted {
        qt_QTimer_start(cast(QTimer*)_qobject, msec);
    }
    
    void start() @trusted {
        qt_QTimer_start_noarg(cast(QTimer*)_qobject);
    }
    
    void stop() @trusted {
        qt_QTimer_stop(cast(QTimer*)_qobject);
    }
    
    @property int interval() @trusted {
        return qt_QTimer_interval(cast(QTimer*)_qobject);
    }
    
    @property void interval(int msec) @trusted {
        qt_QTimer_setInterval(cast(QTimer*)_qobject, msec);
    }
    
    @property bool isActive() @trusted {
        return qt_QTimer_isActive(cast(QTimer*)_qobject);
    }
    
    @property bool singleShot() @trusted {
        return qt_QTimer_isSingleShot(cast(QTimer*)_qobject);
    }
    
    @property void singleShot(bool single) @trusted {
        qt_QTimer_setSingleShot(cast(QTimer*)_qobject, single);
    }
}
