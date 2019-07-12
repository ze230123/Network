//
//  MultiNetworkViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

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
        let loginAPI = NewAccountAPI.login(userName: "15545583589", password: "123456")
        server
            .showHUD(startLoading)
            .request(api: loginAPI)
            .mapObject(UserLogin.self)
            .map { (root) -> Int in
                guard let state = root.result?.state else {
                    throw NetworkError.message("未知错误，登陆失败")
                }
                guard state == .success else {
                    throw NetworkError.message(state.description)
                }
                guard let userId = root.result?.userId?.numId else {
                    throw NetworkError.message("用户ID获取失败")
                }
                return userId
            }
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
            .hiddenHud(endLoading)
            .subscribe { [unowned self] (event) in
                switch event {
                case .next(let root):
                    LoginUtils(info: root, view: self.view).check().jump().save()
                case .error(let error):
                    MBProgressHUD.showMessage(error.localizedDescription, to: self.view)
                case .completed: break
                }
            }.disposed(by: disposeBag)
    }
}

func sorted(_ item1: Int, item2: Int) -> Bool {
    return item1 < item1
}
