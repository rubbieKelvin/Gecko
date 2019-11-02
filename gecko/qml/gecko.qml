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
                        currentIndex: 2
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
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
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
								visible: true
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

									onClicked:{
										var tobj = {rectobj:toastrect, textobj:toastmessage, timeobj:toasttimer};
										Gecko.install(jsonfilepath.text, newtemplatename.text, tempmodel, tobj);
									}
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

										onDeleteClicked:{
											var tobj = {rectobj:toastrect, textobj:toastmessage, timeobj:toasttimer};
											Gecko.uninstall(name, tempmodel, tobj);
										}
                                    }
                                    model:ListModel{
										id: tempmodel
									}
									Component.onCompleted: {
										Gecko.feedtempmodel(tempmodel);
									}
                                }
                            }
                        }
                    }

                    Page {
                        id: project_page
                        width: 200
                        height: 200
                        title: "New Projects"
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Rectangle {
                            id: rectangle2
                            color: Gecko.theme.dark
                            anchors.fill: parent

                            ColumnLayout {
                                x: 8
                                y: 29
                                width: 352
                                height: 454
                                spacing: 10

                                TextField {
                                    id: projectname
                                    text: qsTr("")
                                    bottomPadding: 8
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.preferredWidth: 294
                                    font.pixelSize: 12
                                    font.family: "Nunito"
                                    placeholderText: "Enter Project Name..."
                                    Material.foreground: Gecko.theme.white
                                    background: Rectangle{
                                        color: Gecko.theme.black
                                        radius: 4
                                    }
                                    padding: 4
                                }

                                ComboBox {
                                    id: templatescombo
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.preferredWidth: 294
                                    font.pixelSize: 12
                                    font.family: "Nunito"
                                    Material.foreground: Gecko.theme.white
                                    flat: true
									textRole: "name"
                                    model: tempmodel
                                    background: Rectangle{
                                        color: Gecko.theme.black
                                        radius: 4
                                    }
                                    padding: 4
                                }

                                TextArea {
                                    id: projectdescription
                                    text: qsTr("")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 196
                                    Layout.preferredWidth: 294
                                    textFormat: Text.PlainText
                                    placeholderText: "Project description..."
                                    font.pixelSize: 12
                                    font.family: "Nunito"
                                    Material.foreground: Gecko.theme.white
                                    background: Rectangle{
                                        color: Gecko.theme.black
                                        radius: 4
                                    }
                                    padding: 4
                                }

                                CheckDelegate {
                                    id: usegit
                                    text: qsTr("Use Git?")
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    Layout.preferredWidth: 294
                                    font.pixelSize: 12
                                    font.family: "Nunito"
                                    Material.foreground: Gecko.theme.white
                                }

                                Button {
                                    id: createproject
                                    text: qsTr("Create Project")
                                    font.capitalization: Font.Capitalize
                                    font.pixelSize: 13
                                    font.family: "Nunito"
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 48
                                    Layout.preferredWidth: 294
                                    Material.foreground: Gecko.theme.white
                                    Material.background: Gecko.theme.primary
                                }
                            }
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
                            color: Gecko.theme.dark
                            anchors.fill: parent

                            ColumnLayout {
                                x: 8
                                y: 8

                                TextField {
                                    id: authorname
                                    text: qsTr(Gecko.configuration().author)
                                    font.family: "Nunito"
                                    padding: 4
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 294
                                    background: Rectangle {
                                        color: Gecko.theme.black
                                        radius: 4
                                    }
                                    placeholderText: "Author's Name..."
                                    bottomPadding: 8
                                    Layout.preferredHeight: 50
                                    font.pixelSize: 12
									Material.foreground: Gecko.theme.white
                                }

                                TextField {
                                    id: gitpath
                                    text: qsTr(Gecko.configuration().git)
                                    font.family: "Nunito"
                                    padding: 4
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 294
                                    background: Rectangle {
                                        color: Gecko.theme.black
                                        radius: 4
                                    }
                                    placeholderText: "Git.exe Path..."
                                    bottomPadding: 8
                                    Layout.preferredHeight: 50
                                    font.pixelSize: 12
									Material.foreground: Gecko.theme.white
                                }

                                TextField {
                                    id: rootfolder
                                    text: qsTr(Gecko.configuration().root)
                                    font.family: "Nunito"
                                    padding: 4
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 294
                                    background: Rectangle {
                                        color: Gecko.theme.black
                                        radius: 4
                                    }
                                    placeholderText: "Project root folder"
                                    bottomPadding: 8
                                    Layout.preferredHeight: 50
                                    font.pixelSize: 12
									Material.foreground: Gecko.theme.white
                                }

                                Button {
                                    id: savesettings
                                    text: qsTr("Save")
                                    font.family: "Nunito"
                                    font.capitalization: Font.Capitalize
                                    Layout.fillWidth: true
                                    Layout.preferredWidth: 294
                                    Layout.fillHeight: false
                                    Layout.preferredHeight: 48
                                    font.pixelSize: 13
									Material.foreground: Gecko.theme.white
                                    Material.background: Gecko.theme.primary

									onClicked: {
										Gecko.configure(authorname.text, gitpath.text, rootfolder.text, {rectobj:toastrect, textobj:toastmessage, timeobj:toasttimer});
									}
                                }
                            }
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

    Rectangle {
        id: toastrect
        width: 300
        height: 50
        color: Gecko.theme.secondary
        radius: 4
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
		visible: false
		enabled: visible

        Label {
            id: toastmessage
            text: qsTr("Label")
            font.pointSize: 10
            font.family: "Nunito"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
			color: Gecko.theme.white
        }

		Timer{
			id: toasttimer
			interval: 3000
			running: false
			repeat: false

			onTriggered: toastrect.visible = false;
		}
    }
}
