/*********************************************************************************************************
	Copyright: © 2018-2026 Ozan Nurettin Süel (Sicherheitsschmiede)
	License: Apache 2.0
	Authors: Ozan Nurettin Süel (UIManufaktur)
**********************************************************************************************************/
module uim.kde.c.qtwidgets;

import uim.kde.c.qtcore;
import uim.kde.c.qtgui;

extern(C++) nothrow @nogc:

// QApplication - Main application class
extern(C) {
    QApplication* qt_QApplication_new(int* argc, char** argv);
    void qt_QApplication_delete(QApplication* app);
    int qt_QApplication_exec();
    void qt_QApplication_quit();
    void qt_QApplication_setStyle(QString* style);
    QString* qt_QApplication_style();
    void qt_QApplication_setStyleSheet(QString* sheet);
    QString* qt_QApplication_styleSheet();
}

// QWidget - Base class for all UI objects
extern(C) {
    QWidget* qt_QWidget_new(QWidget* parent);
    void qt_QWidget_delete(QWidget* widget);
    void qt_QWidget_show(QWidget* widget);
    void qt_QWidget_hide(QWidget* widget);
    void qt_QWidget_close(QWidget* widget);
    bool qt_QWidget_isVisible(QWidget* widget);
    bool qt_QWidget_isHidden(QWidget* widget);
    void qt_QWidget_setVisible(QWidget* widget, bool visible);
    
    // Geometry
    void qt_QWidget_resize(QWidget* widget, int w, int h);
    void qt_QWidget_move(QWidget* widget, int x, int y);
    void qt_QWidget_setGeometry(QWidget* widget, int x, int y, int w, int h);
    QSize qt_QWidget_size(QWidget* widget);
    QPoint qt_QWidget_pos(QWidget* widget);
    QRect qt_QWidget_geometry(QWidget* widget);
    int qt_QWidget_width(QWidget* widget);
    int qt_QWidget_height(QWidget* widget);
    int qt_QWidget_x(QWidget* widget);
    int qt_QWidget_y(QWidget* widget);
    void qt_QWidget_setMinimumSize(QWidget* widget, int minw, int minh);
    void qt_QWidget_setMaximumSize(QWidget* widget, int maxw, int maxh);
    void qt_QWidget_setFixedSize(QWidget* widget, int w, int h);
    
    // Window properties
    QString* qt_QWidget_windowTitle(QWidget* widget);
    void qt_QWidget_setWindowTitle(QWidget* widget, QString* title);
    void qt_QWidget_setWindowIcon(QWidget* widget, void* icon);
    
    // Layout
    void qt_QWidget_setLayout(QWidget* widget, void* layout);
    void* qt_QWidget_layout(QWidget* widget);
    
    // Focus
    void qt_QWidget_setFocus(QWidget* widget);
    bool qt_QWidget_hasFocus(QWidget* widget);
    void qt_QWidget_clearFocus(QWidget* widget);
    
    // Enable/Disable
    void qt_QWidget_setEnabled(QWidget* widget, bool enabled);
    bool qt_QWidget_isEnabled(QWidget* widget);
    
    // Tooltips and status
    void qt_QWidget_setToolTip(QWidget* widget, QString* text);
    QString* qt_QWidget_toolTip(QWidget* widget);
    void qt_QWidget_setStatusTip(QWidget* widget, QString* text);
    QString* qt_QWidget_statusTip(QWidget* widget);
    
    // Parent/child
    QWidget* qt_QWidget_parentWidget(QWidget* widget);
    
    // Updates
    void qt_QWidget_update(QWidget* widget);
    void qt_QWidget_repaint(QWidget* widget);
}

// QMainWindow - Main application window
struct QMainWindow;
extern(C) {
    QMainWindow* qt_QMainWindow_new(QWidget* parent);
    void qt_QMainWindow_delete(QMainWindow* window);
    void qt_QMainWindow_setCentralWidget(QMainWindow* window, QWidget* widget);
    QWidget* qt_QMainWindow_centralWidget(QMainWindow* window);
    void qt_QMainWindow_setMenuBar(QMainWindow* window, void* menuBar);
    void* qt_QMainWindow_menuBar(QMainWindow* window);
    void qt_QMainWindow_setStatusBar(QMainWindow* window, void* statusBar);
    void* qt_QMainWindow_statusBar(QMainWindow* window);
    void qt_QMainWindow_addToolBar(QMainWindow* window, void* toolbar);
}

// QPushButton - Push button widget
struct QPushButton;
extern(C) {
    QPushButton* qt_QPushButton_new(QString* text, QWidget* parent);
    QPushButton* qt_QPushButton_new_notext(QWidget* parent);
    void qt_QPushButton_delete(QPushButton* button);
    QString* qt_QPushButton_text(QPushButton* button);
    void qt_QPushButton_setText(QPushButton* button, QString* text);
    void qt_QPushButton_setIcon(QPushButton* button, void* icon);
    void qt_QPushButton_setFlat(QPushButton* button, bool flat);
    bool qt_QPushButton_isFlat(QPushButton* button);
    void qt_QPushButton_setDefault(QPushButton* button, bool def);
    bool qt_QPushButton_isDefault(QPushButton* button);
}

// QLabel - Text or image display
struct QLabel;
extern(C) {
    QLabel* qt_QLabel_new(QString* text, QWidget* parent);
    QLabel* qt_QLabel_new_notext(QWidget* parent);
    void qt_QLabel_delete(QLabel* label);
    QString* qt_QLabel_text(QLabel* label);
    void qt_QLabel_setText(QLabel* label, QString* text);
    void qt_QLabel_setPixmap(QLabel* label, void* pixmap);
    void qt_QLabel_setAlignment(QLabel* label, int alignment);
    int qt_QLabel_alignment(QLabel* label);
    void qt_QLabel_setWordWrap(QLabel* label, bool on);
    bool qt_QLabel_wordWrap(QLabel* label);
}

// QLineEdit - Single line text editor
struct QLineEdit;
extern(C) {
    QLineEdit* qt_QLineEdit_new(QString* text, QWidget* parent);
    QLineEdit* qt_QLineEdit_new_notext(QWidget* parent);
    void qt_QLineEdit_delete(QLineEdit* edit);
    QString* qt_QLineEdit_text(QLineEdit* edit);
    void qt_QLineEdit_setText(QLineEdit* edit, QString* text);
    void qt_QLineEdit_setPlaceholderText(QLineEdit* edit, QString* text);
    QString* qt_QLineEdit_placeholderText(QLineEdit* edit);
    void qt_QLineEdit_clear(QLineEdit* edit);
    void qt_QLineEdit_setReadOnly(QLineEdit* edit, bool readOnly);
    bool qt_QLineEdit_isReadOnly(QLineEdit* edit);
    void qt_QLineEdit_setMaxLength(QLineEdit* edit, int maxLength);
    int qt_QLineEdit_maxLength(QLineEdit* edit);
    void qt_QLineEdit_setEchoMode(QLineEdit* edit, int mode);
    int qt_QLineEdit_echoMode(QLineEdit* edit);
}

// Echo modes for QLineEdit
enum QLineEditEchoMode {
    Normal = 0,
    NoEcho = 1,
    Password = 2,
    PasswordEchoOnEdit = 3
}

// QTextEdit - Multi-line text editor
struct QTextEdit;
extern(C) {
    QTextEdit* qt_QTextEdit_new(QString* text, QWidget* parent);
    QTextEdit* qt_QTextEdit_new_notext(QWidget* parent);
    void qt_QTextEdit_delete(QTextEdit* edit);
    QString* qt_QTextEdit_toPlainText(QTextEdit* edit);
    void qt_QTextEdit_setPlainText(QTextEdit* edit, QString* text);
    QString* qt_QTextEdit_toHtml(QTextEdit* edit);
    void qt_QTextEdit_setHtml(QTextEdit* edit, QString* html);
    void qt_QTextEdit_clear(QTextEdit* edit);
    void qt_QTextEdit_setReadOnly(QTextEdit* edit, bool readOnly);
    bool qt_QTextEdit_isReadOnly(QTextEdit* edit);
    void qt_QTextEdit_append(QTextEdit* edit, QString* text);
}

// QCheckBox - Checkbox widget
struct QCheckBox;
extern(C) {
    QCheckBox* qt_QCheckBox_new(QString* text, QWidget* parent);
    QCheckBox* qt_QCheckBox_new_notext(QWidget* parent);
    void qt_QCheckBox_delete(QCheckBox* checkbox);
    QString* qt_QCheckBox_text(QCheckBox* checkbox);
    void qt_QCheckBox_setText(QCheckBox* checkbox, QString* text);
    bool qt_QCheckBox_isChecked(QCheckBox* checkbox);
    void qt_QCheckBox_setChecked(QCheckBox* checkbox, bool checked);
    int qt_QCheckBox_checkState(QCheckBox* checkbox);
    void qt_QCheckBox_setCheckState(QCheckBox* checkbox, int state);
    void qt_QCheckBox_setTristate(QCheckBox* checkbox, bool y);
    bool qt_QCheckBox_isTristate(QCheckBox* checkbox);
}

// Check states
enum QtCheckState {
    Unchecked = 0,
    PartiallyChecked = 1,
    Checked = 2
}

// QRadioButton - Radio button widget
struct QRadioButton;
extern(C) {
    QRadioButton* qt_QRadioButton_new(QString* text, QWidget* parent);
    QRadioButton* qt_QRadioButton_new_notext(QWidget* parent);
    void qt_QRadioButton_delete(QRadioButton* button);
    QString* qt_QRadioButton_text(QRadioButton* button);
    void qt_QRadioButton_setText(QRadioButton* button, QString* text);
    bool qt_QRadioButton_isChecked(QRadioButton* button);
    void qt_QRadioButton_setChecked(QRadioButton* button, bool checked);
}

// QComboBox - Dropdown list
struct QComboBox;
extern(C) {
    QComboBox* qt_QComboBox_new(QWidget* parent);
    void qt_QComboBox_delete(QComboBox* combo);
    int qt_QComboBox_count(QComboBox* combo);
    void qt_QComboBox_addItem(QComboBox* combo, QString* text);
    void qt_QComboBox_insertItem(QComboBox* combo, int index, QString* text);
    void qt_QComboBox_removeItem(QComboBox* combo, int index);
    void qt_QComboBox_clear(QComboBox* combo);
    QString* qt_QComboBox_currentText(QComboBox* combo);
    int qt_QComboBox_currentIndex(QComboBox* combo);
    void qt_QComboBox_setCurrentIndex(QComboBox* combo, int index);
    QString* qt_QComboBox_itemText(QComboBox* combo, int index);
}

// QSpinBox - Integer spin box
struct QSpinBox;
extern(C) {
    QSpinBox* qt_QSpinBox_new(QWidget* parent);
    void qt_QSpinBox_delete(QSpinBox* spinbox);
    int qt_QSpinBox_value(QSpinBox* spinbox);
    void qt_QSpinBox_setValue(QSpinBox* spinbox, int value);
    int qt_QSpinBox_minimum(QSpinBox* spinbox);
    void qt_QSpinBox_setMinimum(QSpinBox* spinbox, int min);
    int qt_QSpinBox_maximum(QSpinBox* spinbox);
    void qt_QSpinBox_setMaximum(QSpinBox* spinbox, int max);
    void qt_QSpinBox_setRange(QSpinBox* spinbox, int min, int max);
    int qt_QSpinBox_singleStep(QSpinBox* spinbox);
    void qt_QSpinBox_setSingleStep(QSpinBox* spinbox, int step);
}

// QSlider - Slider widget
struct QSlider;
extern(C) {
    QSlider* qt_QSlider_new(int orientation, QWidget* parent);
    void qt_QSlider_delete(QSlider* slider);
    int qt_QSlider_value(QSlider* slider);
    void qt_QSlider_setValue(QSlider* slider, int value);
    int qt_QSlider_minimum(QSlider* slider);
    void qt_QSlider_setMinimum(QSlider* slider, int min);
    int qt_QSlider_maximum(QSlider* slider);
    void qt_QSlider_setMaximum(QSlider* slider, int max);
    void qt_QSlider_setRange(QSlider* slider, int min, int max);
    int qt_QSlider_singleStep(QSlider* slider);
    void qt_QSlider_setSingleStep(QSlider* slider, int step);
    void qt_QSlider_setTickPosition(QSlider* slider, int position);
    int qt_QSlider_tickPosition(QSlider* slider);
}

// Qt Orientation
enum QtOrientation {
    Horizontal = 1,
    Vertical = 2
}

// Layouts
struct QLayout;
struct QBoxLayout;
struct QHBoxLayout;
struct QVBoxLayout;
struct QGridLayout;
struct QFormLayout;

extern(C) {
    // QBoxLayout
    QBoxLayout* qt_QBoxLayout_new(int direction, QWidget* parent);
    void qt_QBoxLayout_delete(QBoxLayout* layout);
    void qt_QBoxLayout_addWidget(QBoxLayout* layout, QWidget* widget);
    void qt_QBoxLayout_addLayout(QBoxLayout* layout, QLayout* layout2);
    void qt_QBoxLayout_addSpacing(QBoxLayout* layout, int size);
    void qt_QBoxLayout_addStretch(QBoxLayout* layout, int stretch);
    
    // QHBoxLayout
    QHBoxLayout* qt_QHBoxLayout_new(QWidget* parent);
    void qt_QHBoxLayout_delete(QHBoxLayout* layout);
    
    // QVBoxLayout
    QVBoxLayout* qt_QVBoxLayout_new(QWidget* parent);
    void qt_QVBoxLayout_delete(QVBoxLayout* layout);
    
    // QGridLayout
    QGridLayout* qt_QGridLayout_new(QWidget* parent);
    void qt_QGridLayout_delete(QGridLayout* layout);
    void qt_QGridLayout_addWidget(QGridLayout* layout, QWidget* widget,
                                  int row, int column, int rowSpan, int columnSpan);
    void qt_QGridLayout_setSpacing(QGridLayout* layout, int spacing);
    int qt_QGridLayout_spacing(QGridLayout* layout);
    void qt_QGridLayout_setRowStretch(QGridLayout* layout, int row, int stretch);
    void qt_QGridLayout_setColumnStretch(QGridLayout* layout, int column, int stretch);
    
    // QFormLayout
    QFormLayout* qt_QFormLayout_new(QWidget* parent);
    void qt_QFormLayout_delete(QFormLayout* layout);
    void qt_QFormLayout_addRow(QFormLayout* layout, QString* label, QWidget* field);
    void qt_QFormLayout_addRow_widget(QFormLayout* layout, QWidget* label, QWidget* field);
}

// Box layout direction
enum QBoxLayoutDirection {
    LeftToRight = 0,
    RightToLeft = 1,
    TopToBottom = 2,
    BottomToTop = 3
}

// QMessageBox - Message dialog
struct QMessageBox;
extern(C) {
    QMessageBox* qt_QMessageBox_new(QWidget* parent);
    void qt_QMessageBox_delete(QMessageBox* msgbox);
    void qt_QMessageBox_setText(QMessageBox* msgbox, QString* text);
    void qt_QMessageBox_setInformativeText(QMessageBox* msgbox, QString* text);
    void qt_QMessageBox_setIcon(QMessageBox* msgbox, int icon);
    int qt_QMessageBox_exec(QMessageBox* msgbox);
    
    // Static convenience functions
    void qt_QMessageBox_information(QWidget* parent, QString* title, QString* text);
    void qt_QMessageBox_warning(QWidget* parent, QString* title, QString* text);
    void qt_QMessageBox_critical(QWidget* parent, QString* title, QString* text);
    int qt_QMessageBox_question(QWidget* parent, QString* title, QString* text);
}

// Message box icons
enum QMessageBoxIcon {
    NoIcon = 0,
    Information = 1,
    Warning = 2,
    Critical = 3,
    Question = 4
}

// Alignment flags
enum QtAlignment {
    AlignLeft = 0x0001,
    AlignRight = 0x0002,
    AlignHCenter = 0x0004,
    AlignJustify = 0x0008,
    AlignTop = 0x0020,
    AlignBottom = 0x0040,
    AlignVCenter = 0x0080,
    AlignCenter = AlignHCenter | AlignVCenter
}
