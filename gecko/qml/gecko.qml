import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import QtQuick.Dialogs 1.0
import "js/app.js" as Gecko
import "component"

ApplicationWindow{
    id: root
    visible: true
    height: 600
    width: 800
    minimumHeight: height
    minimumWidth: width
    maximumHeight: height
    maximumWidth: width
    flags: Qt.FramelessWindowHint | Qt.Window
    x: (Screen.desktopAvailableWidth/2)-(width/2)
    y: (Screen.desktopAvailableHeight/2)-(height/2)
	Material.accent: Gecko.theme.primary

    StackLayout {
        id: main
        anchors.fill: parent

        Page {
            id: intropage
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true
			enabled: (main.currentIndex == 0)

            Rectangle {
                id: rectangle
                anchors.fill: parent
                color: Gecko.theme.dark

                Image {
                    id: image
                    x: 280
                    y: 180
                    source: "res/logobig.png"
                    fillMode: Image.PreserveAspectFit
                }

                ProgressBar {
                    y: 504
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    indeterminate: true
                    value: 0.5

					Timer {
						interval: 3000
						running: true
						repeat: false

						onTriggered: main.currentIndex = 1;
					}
                }
            }
        }

		Page {
            id: otheropage
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true
			enabled: (main.currentIndex == 1)
		}
	}

    WMBar{
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        visible: false

        onCloseClicked:{
            Gecko.closeapp(root)
        }
    }
}





/*##^## Designer {
    D{i:5;anchors_x:69}D{i:1;anchors_height:100;anchors_width:100}D{i:6;anchors_width:800}
}
 ##^##*/
