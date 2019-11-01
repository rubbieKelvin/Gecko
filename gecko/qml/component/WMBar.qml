import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0
import "../js/app.js" as Gecko

Rectangle{
    id: root
    height: 50
    color: "#00000000"
    width: 800
	enabled: visible

	signal closeClicked()

    Rectangle {
        width: 200
        height: parent.height
        color: Gecko.theme.low_contrast

        Image {
            id: icon
            anchors.fill: parent
            source: "res/logo.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Label {
        id: pagetitle
        color: Gecko.theme.light
        text: qsTr("Label")
        font.weight: Font.Bold
        font.family: "Poppins"
        font.pixelSize: 15
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
    }

    WMIcon {
        id: wMIcon
        anchors.right: parent.right
        anchors.rightMargin: 0
        image.source: "res/cancel.png"

		onClick:{
			closeClicked()
		}

    }

}
