[将SwiftUI提升至新的维度](https://developer.apple.com/wwdc23/10113)

SIMD3表示三维向量，包含三个标量值，可以是整数、浮点数或其他支持SIMD的操作系统

1、3D模型添加附着物【获取点击3D模型的点击坐标；将点击坐标转换为3D坐标；】
2、在模型添加其他模型
掌握在模型上面，添加浮动的模型，可拖曳旋转？


## 问题
@GestureState属性修饰符怎么使用【10113需要向前学习此手势的用法，点击模型】

- 值可以是任意类型
```
@GestureState private var isDetectingLongPress = false

@GestureState var offset: SIMD3<Float> = [0, 0, 0]
```
