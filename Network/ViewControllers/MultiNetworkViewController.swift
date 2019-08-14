//
//  MultiNetworkViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//
import UIKit

var user = UserInfo()

class MultiNetworkViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        request()
    }

    @IBAction func tapAction(_ sender: UIButton) {
//        MBProgressHUD.showMessage("加载成功", to: self.view)
        request()
    }

    func request() {

//        server
//            .request(api: NewAccountAPI.info(numId: 13203922))
//            .mapObject(User.self)
//            .subscribe { (event) in
//                switch event {
//                case .next(let root):
//                    print(root)
//                    let manager = DBManager(name: root.result?.numId.stringValue ?? "")
//                case .error(let error):
//                    MBHUD.showMessage(error.localizedDescription, to: self.view)
//                case .completed: break
//                }
//            }.disposed(by: disposeBag)

        let loginAPI = NewAccountAPI.login(userName: "19000000034", password: "123456")

        server
            .startLoading(showHud)
            .request(api: loginAPI)
            .mapObject(UserLogin.self)
            .map(LoginUtils.getUserId)
            .flatMap(LoginUtils.getUserInfo)
            .map({ (root) -> UserInfo in
                guard let user = root.result else {
                    throw NetworkError.message("获取用户信息失败")
                }
                let info = UserInfo(user: user)
                return info
            })
            .flatMap(LoginUtils.getGKStatus)
            .flatMap(LoginUtils.getScore)
            .stopLoading(hideHud)
            .subscribe { [unowned self] (event) in
                switch event {
                case .next(let root):
                    LoginUtils(info: root, view: self.view).check().jump().save()
                case .error(let error):
                    MBHUD.showMessage(error.localizedDescription, to: self.view)
                case .completed: break
                }
            }.disposed(by: disposeBag)
    }
}

func sorted(_ item1: Int, item2: Int) -> Bool {
    return item1 < item1
}
