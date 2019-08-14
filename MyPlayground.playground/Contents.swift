import UIKit
import Network
import RxSwift

Observable
    .repeatElement(0)
    .reduce(1, accumulator: +)
    .subscribe(onNext: { print($0) })
    .disposed(by: DisposeBag())
