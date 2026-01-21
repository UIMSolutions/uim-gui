/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.qtwidgets;

/**
 * D wrappers for Qt Widgets functionality
 * Provides idiomatic D interfaces to Qt Widget C++ classes
 */

public import uim.kde.c.qtwidgets;
public import uim.kde.qtcore;
public import uim.kde.types;

/**
 * Application wrapper for GUI applications
 */
class Application : CoreApplication {
    this(string[] args) @trusted {
        // Convert D args to C args
        import core.stdc.stdlib : malloc;
        int argc = cast(int)args.length;
        char** argv = cast(char**)malloc(char*.sizeof * args.length);
        foreach (i, arg; args) {
            argv[i] = cast(char*)toStringz(arg);
        }
        
        auto app = qt_QApplication_new(&argc, argv);
        _qobject = cast(QObject*)app;
        _instance = this;
    }
    
    ~this() @trusted {
        qt_QApplication_delete(cast(QApplication*)_qobject);
    }
    
    void setStyle(string style) @trusted {
        auto qstyle = toQString(style);
        qt_QApplication_setStyle(qstyle);
        qt_QString_delete(qstyle);
    }
}

/**
 * Base widget wrapper
 */
class Widget : QtObject {
    this(Widget parent = null) @trusted {
        auto widget = qt_QWidget_new(parent ? cast(QWidget*)parent.handle : null);
        super(cast(QObject*)widget);
    }
    
    protected this(QWidget* widget) @safe pure nothrow @nogc {
        super(cast(QObject*)widget);
    }
    
    @property QWidget* widgetHandle() @safe pure nothrow @nogc {
        return cast(QWidget*)_qobject;
    }
    
    void show() @trusted {
        qt_QWidget_show(widgetHandle);
    }
    
    void hide() @trusted {
        qt_QWidget_hide(widgetHandle);
    }
    
    void close() @trusted {
        qt_QWidget_close(widgetHandle);
    }
    
    @property bool visible() @trusted {
        return qt_QWidget_isVisible(widgetHandle);
    }
    
    @property void visible(bool v) @trusted {
        qt_QWidget_setVisible(widgetHandle, v);
    }
    
    void resize(int width, int height) @trusted {
        qt_QWidget_resize(widgetHandle, width, height);
    }
    
    void move(int x, int y) @trusted {
        qt_QWidget_move(widgetHandle, x, y);
    }
    
    void setGeometry(int x, int y, int width, int height) @trusted {
        qt_QWidget_setGeometry(widgetHandle, x, y, width, height);
    }
    
    @property string windowTitle() @trusted {
        auto qtitle = qt_QWidget_windowTitle(widgetHandle);
        scope(exit) qt_QString_delete(qtitle);
        return fromQString(qtitle);
    }
    
    @property void windowTitle(string title) @trusted {
        auto qtitle = toQString(title);
        qt_QWidget_setWindowTitle(widgetHandle, qtitle);
        qt_QString_delete(qtitle);
    }
    
    @property bool enabled() @trusted {
        return qt_QWidget_isEnabled(widgetHandle);
    }
    
    @property void enabled(bool e) @trusted {
        qt_QWidget_setEnabled(widgetHandle, e);
    }
    
    void setToolTip(string text) @trusted {
        auto qtext = toQString(text);
        qt_QWidget_setToolTip(widgetHandle, qtext);
        qt_QString_delete(qtext);
    }
}

/**
 * Main window wrapper
 */
class MainWindow : Widget {
    this(Widget parent = null) @trusted {
        auto window = qt_QMainWindow_new(parent ? cast(QWidget*)parent.handle : null);
        _qobject = cast(QObject*)window;
    }
    
    void setCentralWidget(Widget widget) @trusted {
        qt_QMainWindow_setCentralWidget(
            cast(QMainWindow*)_qobject,
            cast(QWidget*)widget.handle
        );
    }
}

/**
 * Push button wrapper
 */
class PushButton : Widget {
    this(string text = "", Widget parent = null) @trusted {
        QPushButton* button;
        if (text.length > 0) {
            auto qtext = toQString(text);
            button = qt_QPushButton_new(qtext, parent ? cast(QWidget*)parent.handle : null);
            qt_QString_delete(qtext);
        } else {
            button = qt_QPushButton_new_notext(parent ? cast(QWidget*)parent.handle : null);
        }
        _qobject = cast(QObject*)button;
    }
    
    @property string text() @trusted {
        auto qtext = qt_QPushButton_text(cast(QPushButton*)_qobject);
        scope(exit) qt_QString_delete(qtext);
        return fromQString(qtext);
    }
    
    @property void text(string t) @trusted {
        auto qtext = toQString(t);
        qt_QPushButton_setText(cast(QPushButton*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
}

/**
 * Label wrapper
 */
class Label : Widget {
    this(string text = "", Widget parent = null) @trusted {
        QLabel* label;
        if (text.length > 0) {
            auto qtext = toQString(text);
            label = qt_QLabel_new(qtext, parent ? cast(QWidget*)parent.handle : null);
            qt_QString_delete(qtext);
        } else {
            label = qt_QLabel_new_notext(parent ? cast(QWidget*)parent.handle : null);
        }
        _qobject = cast(QObject*)label;
    }
    
    @property string text() @trusted {
        auto qtext = qt_QLabel_text(cast(QLabel*)_qobject);
        scope(exit) qt_QString_delete(qtext);
        return fromQString(qtext);
    }
    
    @property void text(string t) @trusted {
        auto qtext = toQString(t);
        qt_QLabel_setText(cast(QLabel*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
    
    @property bool wordWrap() @trusted {
        return qt_QLabel_wordWrap(cast(QLabel*)_qobject);
    }
    
    @property void wordWrap(bool wrap) @trusted {
        qt_QLabel_setWordWrap(cast(QLabel*)_qobject, wrap);
    }
}

/**
 * Line edit wrapper
 */
class LineEdit : Widget {
    this(string text = "", Widget parent = null) @trusted {
        QLineEdit* edit;
        if (text.length > 0) {
            auto qtext = toQString(text);
            edit = qt_QLineEdit_new(qtext, parent ? cast(QWidget*)parent.handle : null);
            qt_QString_delete(qtext);
        } else {
            edit = qt_QLineEdit_new_notext(parent ? cast(QWidget*)parent.handle : null);
        }
        _qobject = cast(QObject*)edit;
    }
    
    @property string text() @trusted {
        auto qtext = qt_QLineEdit_text(cast(QLineEdit*)_qobject);
        scope(exit) qt_QString_delete(qtext);
        return fromQString(qtext);
    }
    
    @property void text(string t) @trusted {
        auto qtext = toQString(t);
        qt_QLineEdit_setText(cast(QLineEdit*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
    
    @property string placeholderText() @trusted {
        auto qtext = qt_QLineEdit_placeholderText(cast(QLineEdit*)_qobject);
        scope(exit) qt_QString_delete(qtext);
        return fromQString(qtext);
    }
    
    @property void placeholderText(string t) @trusted {
        auto qtext = toQString(t);
        qt_QLineEdit_setPlaceholderText(cast(QLineEdit*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
    
    void clear() @trusted {
        qt_QLineEdit_clear(cast(QLineEdit*)_qobject);
    }
}

/**
 * Text edit wrapper
 */
class TextEdit : Widget {
    this(string text = "", Widget parent = null) @trusted {
        QTextEdit* edit;
        if (text.length > 0) {
            auto qtext = toQString(text);
            edit = qt_QTextEdit_new(qtext, parent ? cast(QWidget*)parent.handle : null);
            qt_QString_delete(qtext);
        } else {
            edit = qt_QTextEdit_new_notext(parent ? cast(QWidget*)parent.handle : null);
        }
        _qobject = cast(QObject*)edit;
    }
    
    @property string plainText() @trusted {
        auto qtext = qt_QTextEdit_toPlainText(cast(QTextEdit*)_qobject);
        scope(exit) qt_QString_delete(qtext);
        return fromQString(qtext);
    }
    
    @property void plainText(string t) @trusted {
        auto qtext = toQString(t);
        qt_QTextEdit_setPlainText(cast(QTextEdit*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
    
    void append(string text) @trusted {
        auto qtext = toQString(text);
        qt_QTextEdit_append(cast(QTextEdit*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
    
    void clear() @trusted {
        qt_QTextEdit_clear(cast(QTextEdit*)_qobject);
    }
}

/**
 * Checkbox wrapper
 */
class CheckBox : Widget {
    this(string text = "", Widget parent = null) @trusted {
        QCheckBox* checkbox;
        if (text.length > 0) {
            auto qtext = toQString(text);
            checkbox = qt_QCheckBox_new(qtext, parent ? cast(QWidget*)parent.handle : null);
            qt_QString_delete(qtext);
        } else {
            checkbox = qt_QCheckBox_new_notext(parent ? cast(QWidget*)parent.handle : null);
        }
        _qobject = cast(QObject*)checkbox;
    }
    
    @property bool checked() @trusted {
        return qt_QCheckBox_isChecked(cast(QCheckBox*)_qobject);
    }
    
    @property void checked(bool c) @trusted {
        qt_QCheckBox_setChecked(cast(QCheckBox*)_qobject, c);
    }
}

/**
 * ComboBox wrapper
 */
class ComboBox : Widget {
    this(Widget parent = null) @trusted {
        auto combo = qt_QComboBox_new(parent ? cast(QWidget*)parent.handle : null);
        _qobject = cast(QObject*)combo;
    }
    
    void addItem(string text) @trusted {
        auto qtext = toQString(text);
        qt_QComboBox_addItem(cast(QComboBox*)_qobject, qtext);
        qt_QString_delete(qtext);
    }
    
    @property string currentText() @trusted {
        auto qtext = qt_QComboBox_currentText(cast(QComboBox*)_qobject);
        scope(exit) qt_QString_delete(qtext);
        return fromQString(qtext);
    }
    
    @property int currentIndex() @trusted {
        return qt_QComboBox_currentIndex(cast(QComboBox*)_qobject);
    }
    
    @property void currentIndex(int idx) @trusted {
        qt_QComboBox_setCurrentIndex(cast(QComboBox*)_qobject, idx);
    }
    
    void clear() @trusted {
        qt_QComboBox_clear(cast(QComboBox*)_qobject);
    }
}

/**
 * VBoxLayout - Vertical box layout
 */
class VBoxLayout {
    private QVBoxLayout* _layout;
    
    this(Widget parent = null) @trusted {
        _layout = qt_QVBoxLayout_new(parent ? cast(QWidget*)parent.handle : null);
    }
    
    void addWidget(Widget widget) @trusted {
        qt_QBoxLayout_addWidget(cast(QBoxLayout*)_layout, cast(QWidget*)widget.handle);
    }
    
    void addSpacing(int size) @trusted {
        qt_QBoxLayout_addSpacing(cast(QBoxLayout*)_layout, size);
    }
    
    void addStretch(int stretch = 0) @trusted {
        qt_QBoxLayout_addStretch(cast(QBoxLayout*)_layout, stretch);
    }
    
    @property void* handle() @safe pure nothrow @nogc {
        return cast(void*)_layout;
    }
}

/**
 * HBoxLayout - Horizontal box layout
 */
class HBoxLayout {
    private QHBoxLayout* _layout;
    
    this(Widget parent = null) @trusted {
        _layout = qt_QHBoxLayout_new(parent ? cast(QWidget*)parent.handle : null);
    }
    
    void addWidget(Widget widget) @trusted {
        qt_QBoxLayout_addWidget(cast(QBoxLayout*)_layout, cast(QWidget*)widget.handle);
    }
    
    void addSpacing(int size) @trusted {
        qt_QBoxLayout_addSpacing(cast(QBoxLayout*)_layout, size);
    }
    
    void addStretch(int stretch = 0) @trusted {
        qt_QBoxLayout_addStretch(cast(QBoxLayout*)_layout, stretch);
    }
    
    @property void* handle() @safe pure nothrow @nogc {
        return cast(void*)_layout;
    }
}

/**
 * Message box utilities
 */
class MessageBox {
    static void information(Widget parent, string title, string text) @trusted {
        auto qtitle = toQString(title);
        auto qtext = toQString(text);
        qt_QMessageBox_information(
            parent ? cast(QWidget*)parent.handle : null,
            qtitle,
            qtext
        );
        qt_QString_delete(qtitle);
        qt_QString_delete(qtext);
    }
    
    static void warning(Widget parent, string title, string text) @trusted {
        auto qtitle = toQString(title);
        auto qtext = toQString(text);
        qt_QMessageBox_warning(
            parent ? cast(QWidget*)parent.handle : null,
            qtitle,
            qtext
        );
        qt_QString_delete(qtitle);
        qt_QString_delete(qtext);
    }
    
    static void critical(Widget parent, string title, string text) @trusted {
        auto qtitle = toQString(title);
        auto qtext = toQString(text);
        qt_QMessageBox_critical(
            parent ? cast(QWidget*)parent.handle : null,
            qtitle,
            qtext
        );
        qt_QString_delete(qtitle);
        qt_QString_delete(qtext);
    }
}
