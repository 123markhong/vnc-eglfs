TEMPLATE = lib
TARGET   = qvnceglfs

DEFINES += VNC_MAKEDLL

QT += gui gui-private network

CONFIG += hide_symbols
CONFIG += silent
CONFIG += no_private_qt_headers_warning

CONFIG += strict_c++
CONFIG += c++11
CONFIG += warn_on

#CONFIG += pedantic
#CONFIG += debug

pedantic {
    gcc {
        QMAKE_CXXFLAGS *= -pedantic-errors
        QMAKE_CXXFLAGS *= -Wpedantic

        QMAKE_CXXFLAGS *= -Wsuggest-override
        QMAKE_CXXFLAGS *= -Wsuggest-final-types
        QMAKE_CXXFLAGS *= -Wsuggest-final-methods

        CONFIG += noqtheaderwarnings
        #QMAKE_CXXFLAGS *= -fanalyzer
    }
}

lessThan(QT_MAJOR_VERSION, 6) {

    # Qt5 headers might be full of warnings, when using modern compilers
    CONFIG += noqtheaderwarnings
}

noqtheaderwarnings {

    linux {
        QMAKE_CXXFLAGS += \
            -isystem $$[QT_INSTALL_HEADERS]/QtCore \
            -isystem $$[QT_INSTALL_HEADERS]/QtCore/$$[QT_VERSION]/QtCore \
            -isystem $$[QT_INSTALL_HEADERS]/QtGui \
            -isystem $$[QT_INSTALL_HEADERS]/QtGui/$$[QT_VERSION]/QtGui \
            -isystem $$[QT_INSTALL_HEADERS]/QtNetwork \
    }
}

MOC_DIR=moc
OBJECTS_DIR=obj

#TARGET = $$qtLibraryTarget(vncgl)
DESTDIR = lib
#LIBS *= -L$${BUILD_ROOT}/lib -l$$qtLibraryTarget(qvnc)
#LIBS += -L/opt/st/myd-ld25x/4.2.4-snapshot/sysroots/cortexa35-ostl-linux/usr/lib/plugins/platforms -lqvnc

HEADERS += \
    RfbSocket.h \
    RfbPixelStreamer.h \
    RfbEncoder.h \
    RfbInputEventHandler.h \
    VncServer.h \
    VncClient.h \
    VncNamespace.h

SOURCES += \
    RfbSocket.cpp \
    RfbPixelStreamer.cpp \
    RfbEncoder.cpp \
    RfbInputEventHandler.cpp \
    VncServer.cpp \
    VncClient.cpp \
    VncNamespace.cpp \
    VncProxyPlugin.cpp

CONFIG += link_pkgconfig
#PKGCONFIG += openssl
OTHER_FILES += metadata.json
#INSTALL_ROOT=/usr/local/vnceglfs
#INSTALL_ROOT=${./pwd}
# INSTALL_ROOT=$$[QT_INSTALL_PREFIX]

#target.path = $${INSTALL_ROOT}/lib

header_files.files = VncNamespace.h
#header_files.path = $${INSTALL_ROOT}/include

INSTALLS += target header_files
