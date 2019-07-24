//
//  ZipNetworkViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/10.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit
import RxSwift

class ZipNetworkViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapAction(_ sender: UIButton) {
        request()
    }

    func request() {
        let listRequest = server.request(api: CommonDataAPI.schoolList(id: 57)).mapList(Schools.self)
        let gkStatusRequest = server.request(api: CommonDataAPI.gkStatus(id: 841)).mapString()

        Observable
            .showHud(startLoading)
            .zip(listRequest, gkStatusRequest) { (list, gkStatus)in
                return (list, gkStatus)
            }
            .hiddenHud(endLoading)
            .subscribe { (event) in
                switch event {
                case .next(let (list, result)):
                    print(list)
                    print(result)
                case .error(let error):
                    print(error.localizedDescription)
                case .completed: break
                }
            }.disposed(by: disposeBag)
    }
}

