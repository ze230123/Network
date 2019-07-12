//
//  LoadingView.swift
//  YouZhiYuan
//
//  Created by 泽i on 2018/9/29.
//  Copyright © 2018年 泽i. All rights reserved.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    var imageView: UIImageView!

    var isLoading: Bool = true

    deinit {
        print("LoadingView_deinit")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        backgroundColor = UIColor.white

        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(50)
//            make.right.equalTo(self).offset(-50)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.height.width.equalTo(100)
        }
        imageView.image = UIImage(named: "loading1")
    }

    func start() {
        let image = UIImage.animatedImageNamed("loading", duration: 0.7)
        imageView.image = image
        isLoading = true
    }

    func stop() {
        imageView.image = UIImage(named: "loading1")
        isLoading = false
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
