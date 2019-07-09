//
//  NetworkViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit
import RxSwift
import MJRefresh

class NetworkViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var pageIndex: Int = 0

    var dataScore: [NewModel] = []


    deinit {
        print("deinit_\(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addRefreshHeader()
        addRefreshFooter()
        loadData()
    }

    func request(action: RefreshAction) {
        server
            .showHUD(startLoading)
            .request(api: TestAPI.new)
            .testMap(NewModel.self)
            .verifyStatus()
            .hiddenHud(endLoading)
            .subscribe { [unowned self] (event) in
                switch event {
                case .next(let root):
                    print(root)
                    if action == .load {
                        self.dataScore.removeAll()
                    }
                    self.dataScore.append(contentsOf: root.data)
                case .error(let error):
                    MBProgressHUD.showMessage(error.localizedDescription, to: self.view)
                case .completed:
                    self.tableView.reloadData()
                    self.endRefresh(action: action)
                }
            }.disposed(by: disposeBag)
    }

//    func showHud() {
//        hud = MBProgressHUD.showLoading(to: view)
//    }
//
//    func hiddenHUD() {
//        hud?.hide(animated: true)
//    }
}

extension NetworkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataScore.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID", for: indexPath)
        let item = dataScore[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}

extension NetworkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension NetworkViewController {
    enum RefreshAction {
        case load
        case more
    }

    func addRefreshHeader() {
        let header = MJRefreshNormalHeader { [weak self] in
            self?.loadData()
        }
        tableView.mj_header = header
    }

    func addRefreshFooter() {
        let footer = MJRefreshAutoFooter { [weak self] in
            self?.loadMore()
        }
        tableView.mj_footer = footer
    }

    func loadData() {
        pageIndex = 1
        request(action: .load)
    }

    func loadMore() {
        pageIndex += 1
        request(action: .more)
    }

    func endRefresh(action: RefreshAction) {
        switch action {
        case .load:
            tableView.mj_header.endRefreshing()
        case .more:
            tableView.mj_footer.endRefreshing()
        }
    }
}
