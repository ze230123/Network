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

    var hud: MBHUD?

    /// 开始加载动画 (此方法不会产生循环引用)
    lazy var startLoading: () -> Void = { [weak self] in
        self?.showHud()
    }
    
    /// 关闭加载动画 (此方法不会产生循环引用)
    lazy var endLoading: () -> Void = { [weak self] in
        self?.hiddenHUD()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showHud() {
        hud = MBHUD.showLoading(to: view)
    }

    func hiddenHUD() {
        hud?.hide(animated: true)
    }
}
