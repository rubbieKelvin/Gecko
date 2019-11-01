import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0
import "../js/app.js" as Gecko

Rectangle{
    id: root
    height: 50
    color: Gecko.theme.dark
    property string title: "Title"
    width: 800
	enabled: visible

	signal closeClicked()

    Rectangle {
        id: rectangle
        width: 200
        height: parent.height
        color: Gecko.theme.black

        Image {
            id: icon
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "res/autogecko.py.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Label {
        id: pagetitle
        color: Gecko.theme.light
        text: qsTr(title)
        anchors.left: rectangle.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 10
        font.weight: Font.Normal
        font.family: "Nunito"
        font.pixelSize: 15
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
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
