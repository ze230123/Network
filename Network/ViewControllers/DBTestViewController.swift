//
//  DBTestViewController.swift
//  Network
//
//  Created by youzy01 on 2019/8/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit
import ObjectMapper

class DBTestViewController: BaseViewController {

//    let helper = UserInfoHelper(name: "1554583589")
    let manager = DBManager(name: "1554583589")

    var items: [ScoreProperty] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = user.score {
            let json = Mapper(context: Context()).toJSON(item)
            print(json)
            items = json.map { ScoreProperty(key: $0.key, value: "\($0.value)")}
            print(items)
        }
    }

    @IBAction func saveAction(_ sender: UIButton) {
//        helper.add(items)
        if let score = user.score {
            manager.add(score)
        }
    }

    @IBAction func readAction(_ sender: UIButton) {
        if let item = manager.read() {
            print(item)
        }
    }

    @IBAction func deleteAction(_ sender: UIButton) {
//        helper.removeAll()
    }
}
