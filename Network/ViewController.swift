//
//  ViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    lazy var server = Network()
    let dis = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        server.signingIn
            .subscribe { (event) in
                switch event {
                case .next(let isFinish):
                    print(isFinish)
                case .completed, .error:
                    break
                }
            }.disposed(by: dis)
        request()
    }

    func request() {
//        server.request(api: <#T##ApiTargetType#>)
    }
}

