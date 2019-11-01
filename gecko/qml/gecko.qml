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
                        id: listView
                        y: 35
                        height: 332
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        delegate: Item {
                            x: 5
                            width: 80
                            height: 40
                            Row {
                                id: row1
                                spacing: 10
                                Rectangle {
                                    width: 40
                                    height: 40
                                    color: colorCode
                                }

                                Text {
                                    text: name
                                    font.bold: true
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                        model: ListModel {
                            ListElement {
                                name: "Grey"
                                colorCode: "grey"
                            }

                            ListElement {
                                name: "Red"
                                colorCode: "red"
                            }

                            ListElement {
                                name: "Blue"
                                colorCode: "blue"
                            }

                            ListElement {
                                name: "Green"
                                colorCode: "green"
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
                    
                    Page {
                        id: template_page
                        width: 200
                        height: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        
                        Rectangle {
                            id: rectangle1
                            color: "#de3838"
                            anchors.fill: parent
                        }
                    }
                    
                    Page {
                        id: project_page
                        width: 200
                        height: 200
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
        visible: (main.currentIndex != 0)

        onCloseClicked:{
            Gecko.closeapp(root)
        }
    }
}







/*##^## Designer {
    D{i:10;anchors_width:110;anchors_x:45}D{i:9;anchors_height:200}D{i:22;anchors_height:200;anchors_width:200}
D{i:24;anchors_height:200;anchors_width:200}D{i:26;anchors_height:200;anchors_width:200}
D{i:20;anchors_height:100;anchors_width:100;anchors_x:200;anchors_y:0}D{i:8;anchors_height:200;anchors_width:200}
}
 ##^##*/
