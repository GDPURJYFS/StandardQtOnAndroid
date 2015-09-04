# 不要把 VisualItemModel 赋给 Repeater model

```
Repeater {
    model: itemsModel
    Button {
        text: "button"
    }
}
VisualItemModel {
    id: itemsModel
}
```