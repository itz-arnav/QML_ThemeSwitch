import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import ThemeToggle

T.Switch {
    id: control

    width: 250
    height: 80

    background: GlowyRectangle {
        anchors.fill: parent
        bgColor: control.checked ? "#00072d" : "#87bfff"
    }

    indicator: Item {
        anchors.fill: parent
        anchors {
            leftMargin: 5
            rightMargin: 5
        }

        clip: true

        GlowyRectangle {
            id: sun
            height: control.height - 30
            width: height

            bgColor: "#ffba08"
            x: width/3
            y: control.height/2 - height/2

            Behavior on scale {
                NumberAnimation {
                    duration: 600
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on x {
                NumberAnimation {
                    duration: 1000
                    easing.type: Easing.OutCubic
                }
            }
        }

        GlowyRectangle {
            id: moon

            scale: 0
            height: control.height - 30
            width: height

            bgColor: "#f7f7f7"
            x: control.width
            y: control.height/2 - height/2

            Behavior on scale {
                NumberAnimation {
                    duration: 1000
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on x {
                NumberAnimation {
                    duration: 600
                    easing.type: Easing.OutCubic
                }
            }
        }

        Image {
            id: cloud
            source: "Images/clouds.png"
            height: control.height - 30
            width: height
            antialiasing: true
            smooth: true
            fillMode: Image.PreserveAspectCrop
            x: control.width - cloud.width - cloud.width/3
            y: control.height/2 - height/2

            Behavior on x {
                NumberAnimation {
                    duration: 700
                    easing.type: Easing.OutCubic
                }
            }
        }

        Image {
            id: stars
            source: "Images/stars.png"
            height: control.height - 40
            width: height
            antialiasing: true
            smooth: true
            fillMode: Image.PreserveAspectCrop
            x: sun.width/2
            y: control.height/2 - height/2
            opacity: 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 1500
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    SequentialAnimation {
        id: twinkleAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: stars
            property: "opacity"
            duration: 1500
            easing.type: Easing.InOutQuad
            from: 0.6
            to: 0.3
        }
        NumberAnimation {
            target: stars
            property: "opacity"
            duration: 1500
            easing.type: Easing.InOutQuad
            from: 0.3
            to: 0.6
        }
    }

    Timer {
        id: twinkleTimer
        interval: 1500
        onTriggered: {
            twinkleAnimation.restart()
        }
    }

    onCheckedChanged: {
        if(checked) {
            // user clicked, so dark theme
            sun.x = -sun.width
            sun.scale = 0
            cloud.x = control.width + cloud.width
            moon.x = control.width - moon.width - moon.width/3
            moon.scale = 1
            stars.opacity = 0.6
            twinkleTimer.start()
        } else {
            //light theme
            twinkleTimer.stop()
            twinkleAnimation.stop()
            sun.x = sun.width/3
            sun.scale = 1
            cloud.x = control.width - cloud.width - cloud.width/3
            moon.x = control.width
            moon.scale = 0
            stars.opacity = 0
        }
    }
}
