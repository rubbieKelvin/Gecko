import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.0
import "../js/app.js" as Gecko

Rectangle{
    width: 200
    height: 40
    color: "#00000000"

	property string itext

    Label {
        id: label
        x: 8
        y: 0
        width: 184
        height: 40
        color: Gecko.theme.white
        text: qsTr(itext)
        font.weight: Font.Normal
        font.pixelSize: 12
        font.family: "Nunito"
        verticalAlignment: Text.AlignVCenter
    }
}
