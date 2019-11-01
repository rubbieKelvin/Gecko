import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0
import "../js/app.js" as Gecko

Rectangle{
    id: root
    width: 50
    height: 50
    color: "#00000000"
    property alias image: image
    clip: true

    signal click()

    Image {
        id: image
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/qtquickplugin/images/template_image.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            root.color = "#33000000"
        }

        onExited: {
            root.color = "#00000000"
        }

        onPressed: {
			root.color = "#66000000"
            click()
        }
    }
}













/*##^## Designer {
    D{i:1;anchors_height:100;anchors_width:100}D{i:2;anchors_height:100;anchors_width:100}
}
 ##^##*/
