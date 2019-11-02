import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0
import "../js/app.js" as Gecko

Rectangle{
    id: rectangle
    width: 584
    height: 65
    color: Gecko.theme.dark
    property alias namelabel: namelabel
    property alias sizelabel: sizelabel

	signal deleteClicked()

    DelayButton {
        id: deletebutton
        x: 461
        y: 10
        text: qsTr("Delete")
        anchors.right: parent.right
        anchors.rightMargin: 10
        delay: 2000
        font.capitalization: Font.Capitalize
        font.pixelSize: 10
        font.family: "Nunito"
        Material.background: Gecko.theme.primary
		Material.foreground: Gecko.theme.white
		ToolTip.visible: hovered
		ToolTip.text: qsTr("Hold the button for 2 seconds to delete "+namelabel.text+" template")
		ToolTip.delay: 1000
		ToolTip.timeout: 5000

        onActivated: deleteClicked()
    }

    RowLayout {
        y: 8
        anchors.right: deletebutton.left
        anchors.rightMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 8
		spacing: 10

        Label {
            id: namelabel
            color: Gecko.theme.light
            text: qsTr("Name")
            Layout.fillWidth: true
            Layout.preferredHeight: 49
            Layout.preferredWidth: 214
            font.pixelSize: 12
            font.family: "Nunito"
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: sizelabel
            color: Gecko.theme.light
            text: qsTr("Size")
            Layout.preferredHeight: 49
            Layout.preferredWidth: 98
            font.family: "Nunito"
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12
        }
    }
}

/*##^## Designer {
    D{i:2;anchors_x:8}
}
 ##^##*/
