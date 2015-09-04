# 项目组织

```
| StandardQtOnAndroid.pro
| deployment.pri
| LICENSE
| main.cpp
| readme.md
| qml.qrc
| + qml
| + StandardQtOnAndroid
| | StandardQtOnAndroid.qmlproject
| | ...
| + doc
| + android
| + 3rdparty
```

项目由主项目 `StandardQtOnAndroid.pro` 以及 `StandardQtOnAndroid.qmlproject` 副项目构成。

在开发初期，界面设计师可以独立于主项目，快速地，便捷地运行无业务的副项目，与业务（主项目）开发进度相分离，在开发中后期，进行业务逻辑与界面的融合。

## 主项目

主项目是指 **pro** 项目，一般带有一个或者多个 **Cpp** 文件，在调试运行的时候需要进行编译。

```
| StandardQtOnAndroid.pro
| deployment.pri
| main.cpp
| qml.qrc
| + qml
| + android
| + 3rdparty
| ...
```

- **qml** 文件夹内包含 **qml** 文件和 **qml** 使用的图片，脚本等文件。由 `qml.qrc` 文件进行资源映射。
- **android** 文件夹包含安卓平台相关文件
- **3rdparty** 包含跨平台的库

## 副项目

```
| + StandardQtOnAndroid
| | StandardQtOnAndroid.qmlproject
| | + Component
| | + BusinessPage
| | + Sparrow
| | main.qml
| | MainWindow.qml
| | MainView.qml
```

- 使用 `main.qml` 来加载主窗体以及其他窗体。
- 使用 `Sparrow` 进行手机应用的设计。
- 由于手机应用必定有一个主界面，所以使用 `MainView.qml` 进行主页面的设计，可以在主页面中使用 `PathView` 或者横向 `ListView` 进行主页面的布局。
