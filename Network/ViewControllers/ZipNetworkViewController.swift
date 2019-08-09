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
//        request()
        schoolRequest()
    }

    func request() {
        let listRequest = server.request(api: CommonDataAPI.schoolList(id: 57)).mapList(Schools.self)
        let gkStatusRequest = server.request(api: CommonDataAPI.gkStatus(id: 841)).mapString()

        Observable
            .startLoading(showHud)
            .zip(listRequest, gkStatusRequest) { (list, gkStatus)in
                return (list, gkStatus)
            }
            .stopLoading(hideHud)
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

    func schoolRequest() {
        server
            .startLoading(showHud)
            .getSchools(api: CommonDataAPI.schoolList(id: 56))
            .stopLoading(hideHud)
            .subscribe { (event) in
                switch event {
                case .next(let root):
                    print("item:", root)
                case .error(let error):
                    print("错误", error.localizedDescription)
                case .completed:
                    print("完成")
                }
            }.disposed(by: disposeBag)
    }
}

