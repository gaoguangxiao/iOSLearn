import WWDCSlope

// 斜坡。
enum Slope {
    case beginnersParadise
    case practiceRun
    case livingRoom
    case olympicRun
    case blackBeauty
}

//实现一个定义枚举的子集
// 适合初学者的斜坡
@EnumSubset<Slope>
enum EasySlope {
    case beginnersParadise
    case practiceRun
}

//错误案例，会自动提示提示，该宏仅仅适用于枚举
//@EnumSubset
//struct Skier {
//}

//if let easy = EasySlope(.beginnersParadise) {
//    print("easy: \(easy)")
//}

//接下来，让此枚举支持泛型
enum Ball {
    case basketball
    case football
    case handball
}

@EnumSubset<Ball>
enum EasyBall {
    case basketball
}

if let ball = EasyBall(.basketball) {
    print("ball: \(ball)")
}
