//
//  BaseViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/8.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    lazy var loadingView = LoadingView(frame: self.view.bounds)

    var hud: MBHUD?

    /// 开始加载动画 (此方法不会产生循环引用)
    lazy var startLoadAnimation: () -> Void = { [weak self] in
        self?.beginLoading()
    }

    /// 关闭加载动画 (此方法不会产生循环引用)
    lazy var stopLoadAnimation: () -> Void = { [weak self] in
        self?.stopLoading()
    }

    /// 显示HUD加载动画闭包
    lazy var showHud: () -> Void = { [weak self] in
        self?.showHUD()
    }

    /// 隐藏HUD加载动画闭包
    lazy var hideHud: () -> Void = { [weak self] in
        self?.hideHUD()
    }

    /// 显示HUD加载动画
    func showHUD() {
        hud = MBHUD.showLoading(to: view)
    }

    /// 隐藏HUD加载动画
    func hideHUD() {
        print(hud)
        hud?.hide(animated: true)
    }

    func beginLoading() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        loadingView.start()
    }

    func stopLoading() {
        if loadingView.isLoading {
            loadingView.stop()
            loadingView.removeFromSuperview()
        }
    }

    deinit {
        print("\(self)_deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
