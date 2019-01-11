TEMPLATE = app

QT += qml quick widgets
CONFIG += c++11  link_pkgconfig
PKGCONFIG += roscpp

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

