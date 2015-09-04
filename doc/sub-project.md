# 副项目

```
| + StandardQtOnAndroid
| | StandardQtOnAndroid.qmlproject
| | + Component
| | + BusinessPage
| | + ApplicationSettings
| | main.qml
| | MainWindow.qml
| | MainView.qml
```

- 使用 `main.qml` 来加载主窗体以及其他窗体。
- 使用 `PageStackWindow` 进行手机应用的设计。
- 由于手机应用必定有一个主界面，所以使用 `MainView.qml` 进行主页面的设计，可以在主页面中使用 `PathView` 或者 `ListView` 进行主页面的布局。
