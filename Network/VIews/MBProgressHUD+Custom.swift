//
//  MBProgressHUD+Custom.swift
//  Network
//
//  Created by youzy01 on 2019/7/5.
//  Copyright © 2019 youzy. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    static func showLoading(to view: UIView, animated: Bool = true) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.mode = .customView
        let loadview = LoadingView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        loadview.start()
        hud.customView = loadview
        hud.label.text = "加载中..."
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.3)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.white
        return hud
    }

    static func showCustomAdded(to view: UIView, animated: Bool) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.3)
        return hud
    }

    static func showMessage(_ text: String, to view: UIView, animated: Bool = true, position: Position = .center, delay: TimeInterval = 2) {
        let hud = MBProgressHUD.showAdded(to: view, animated: animated)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0, alpha: 0.8)

        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        hud.mode = .text
        hud.label.text = text
        hud.label.textColor = .white

        switch position {
        case .top:
            hud.offset = CGPoint(x: 0, y: -200)
        case .center:
            hud.offset = CGPoint(x: 0, y: 0)
        case .bottom:
            hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        }
        hud.hide(animated: animated, afterDelay: delay)
    }
}

extension MBProgressHUD {
    enum Position {
        case top
        case center
        case bottom
    }
}
