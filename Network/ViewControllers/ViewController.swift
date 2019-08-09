//
//  ViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/3.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func textAction(_ sender: UIButton) {
//        MBHUD.showMessage("加载成功", to: self.view)
        MBHUD.showLoading(to: view)
    }
}

