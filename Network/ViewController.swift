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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func textAction(_ sender: UIButton) {
        MBProgressHUD.showMessage("加载成功", to: self.view)
    }
}

