import QtQuick 2.4
import QtQuick.Controls 1.2

//! [0]
// import "./Component/LockView" as LockView
//! [0]

QtObject {
    id: main

    property MainWindow mainWindow : MainWindow {

    }

    //! [0]
    //! 不要尝试在安卓应用中随意切换多个窗体
    //! 由于安卓绘制的原因，不能及时更新窗体的切换。
    //! 如果要实现类似于支付宝的锁屏功能，请直接在页面栈进行操作。
    //    property ApplicationWindow lockView: ApplicationWindow {
    //        width: 480
    //        height: 600
    //        visible: true
    //        modality: Qt.ApplicationModal

    //        LockView.LockView {
    //            ptWidth: parent.width / 4
    //            anchors.fill: parent
    //            onPasswordChanged: {
    //                console.log(password)
    //                if(password === "6589") {
    //                    console.log("good");
    //                    mainWindow.visible = true;
    //                    lockView.lower();
    //                    lockView.hide();
    //                }
    //            }
    //        }
    //    }
    //! [0]
}
