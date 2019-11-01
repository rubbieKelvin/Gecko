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

    Component.onCompleted: {
        main.currentIndex = 0
        navlist.currentIndex = 0
    }

    StackLayout {
        id: main
        currentIndex: 1
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
            id: mainpage
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true
            enabled: (main.currentIndex == 1)

            Rectangle {
                id: body
                color: Gecko.theme.dark
                anchors.topMargin: 49
                anchors.fill: parent

                Rectangle {
                    id: sidebar
                    width: 200
                    color: Gecko.theme.black
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0

                    ListView {
                        id: navlist
                        y: 35
                        height: 332
                        clip: true
                        flickDeceleration: 500
                        maximumFlickVelocity: 1000
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        spacing: 20
                        highlight: Rectangle{
                            width: 3
                            height: 40
                            color: Gecko.theme.secondary
                            anchors.right: parent.right
                        }
                        delegate: NavItem{
                            id: navitem
                            width: parent.width
                            itext: itemtext
                            color: (navitem == navlist.currentItem) ? Gecko.theme.primary : "#00000000"

                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                enabled: true

                                onClicked: {
                                    var x = parent.x
                                    var y = parent.y
                                    var index = navlist.indexAt(x, y)
                                    navlist.currentIndex = index
                                }
                            }
                        }
                        model: ListModel {
                            ListElement{
                                itemtext: "Template"
                            }

                            ListElement{
                                itemtext: "Project"
                            }

                            ListElement{
                                itemtext: "Settings"
                            }
                        }
                    }
                }

                StackLayout {
                    id: workstack
                    clip: true
                    anchors.left: sidebar.right
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    currentIndex: navlist.currentIndex

                    Page {
                        id: template_page
                        width: 200
                        height: 200
                        title: "Templates"
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            id: rectangle1
                            color: Gecko.theme.dark
                            anchors.fill: parent

                            Pane {
                                id: tempformpane
                                x: 8
                                y: 8
                                width: 584
                                height: 60
                                contentHeight: 60
                                contentWidth: 548
                                font.family: "Nunito"
                                Material.elevation: 5
                                Material.background: Gecko.theme.black

                                RowLayout {
                                    x: 8
                                    y: 8
                                    width: 461
                                    height: 43
                                    anchors.verticalCenter: parent.verticalCenter

                                    TextField {
                                        id: jsonfilepath
                                        color: "#d8d8d8"
                                        text: qsTr("")
                                        placeholderText: "Json file path..."
                                        font.pixelSize: 11
                                        font.family: "Nunito"
                                        Layout.fillWidth: true
                                    }

                                    TextField {
                                        id: newtemplatename
                                        color: "#c8c8c8"
                                        text: qsTr("")
                                        placeholderText: "Name..."
                                        font.pixelSize: 11
                                        font.family: "Nunito"
                                        Layout.fillWidth: true
                                    }
                                }

                                Button{
                                    id: button
                                    x: 718
                                    y: 65
                                    text: qsTr("Install")
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.capitalization: Font.Capitalize
                                    font.pixelSize: 11
                                    font.family: "Nunito"
                                    Material.background: Gecko.theme.primary
                                    Material.foreground: Gecko.theme.white
                                }
                            }

                            ScrollView{
								clip: true
                                anchors.bottomMargin: 8
                                anchors.rightMargin: 8
                                anchors.leftMargin: 8
                                anchors.topMargin: 93
                                anchors.fill: parent

								ListView {
	                                id: templist
	                                delegate: TempItem{
										width: parent.width
										namelabel.text: name
										sizelabel.text: filesize
										datelabel.text: date
										itemid: iid
									}
	                                model: ListModel {
	                                    ListElement {
	                                        name: "Grey"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 0
	                                    }

										ListElement {
	                                        name: "Red"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }

										ListElement {
	                                        name: "Html"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }

										ListElement {
	                                        name: "PythonModule"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }

										ListElement {
	                                        name: "Fask"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }

										ListElement {
	                                        name: "Thesis"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }

										ListElement {
	                                        name: "Qml"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }

										ListElement {
	                                        name: "Eel"
											filesize: "500 kb"
											date: "23, Oct."
											iid: 1
	                                    }
	                                }
	                            }
                            }
                        }
                    }

                    Page {
                        id: project_page
                        width: 200
                        height: 200
                        title: "Projects"
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            id: rectangle2
                            color: "#80ed49"
                            anchors.fill: parent
                        }
                    }

                    Page {
                        id: settings_page
                        width: 200
                        height: 200
                        title: "Settings"
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            id: rectangle3
                            color: "#8e59e2"
                            anchors.fill: parent
                        }
                    }
                }
            }
        }
    }

    WMBar{
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        title: workstack.children[workstack.currentIndex].title
        visible: (main.currentIndex != 0)

        onCloseClicked:{
            Gecko.closeapp(root)
        }
    }
}




/*##^## Designer {
    D{i:10;anchors_width:110;anchors_x:45}D{i:9;anchors_height:200}D{i:26;anchors_height:160;anchors_width:110;anchors_x:125;anchors_y:225}
D{i:20;anchors_height:100;anchors_width:100;anchors_x:200;anchors_y:0}D{i:37;anchors_height:200;anchors_width:200}
D{i:39;anchors_height:200;anchors_width:200}D{i:8;anchors_height:200;anchors_width:200}
}
 ##^##*/
