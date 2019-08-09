import UIKit

typealias Block = (Int, Int) -> Int


//let sum: (Int, Int) -> Int = { (a, b) in
//    let s = a +
//}
//
//let sum1: Block = { (a, b) in
//    return a + b
//}

typealias SumBlock = (Int, Int) -> Int

class Utils {
    let sum: SumBlock = { (a: Int, b: Int) in
        return a + b
    }
}

struct UtilsBlock {

    static func sum() -> Block {
        return { (a, b) in
            return a + b
        }
    }
}

let sum = UtilsBlock.sum()

print(sum(1, 2))
