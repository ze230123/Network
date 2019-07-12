//
//  FileTestViewController.swift
//  Network
//
//  Created by youzy01 on 2019/7/12.
//  Copyright © 2019 youzy. All rights reserved.
//

import UIKit

class FileTestViewController: BaseViewController {
    @IBOutlet weak var keyField: UITextField!
    @IBOutlet weak var bodyField: UITextField!
    @IBOutlet weak var dateField: UITextField!

    @IBOutlet weak var textView: UITextView!

    let manager = FileManager.default

    var path: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.layoutManager.allowsNonContiguousLayout = false

        let url = try? manager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        path = url?.appendingPathComponent("NetworkCache", isDirectory: true).path ?? ""
        print(path)
        guard !manager.fileExists(atPath: path) else {
            return
        }

        do {
            try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func addAction(_ sender: UIButton) {
        if !textView.text.isEmpty {
            textView.text += "\n"
        }
        textView.text += "开始保存数据。。。"
        let key = keyField.text ?? ""
        let body = bodyField.text ?? ""
        let time = dateField.text ?? ""

        guard let data = body.data(using: .utf8) else {
            return
        }
        let date = NSDate(timeIntervalSinceNow: time.doubleValue)
        let filePath = makeFilePath(for: key)

        _ = manager.createFile(atPath: filePath, contents: data, attributes: nil)
        try? manager.setAttributes([.modificationDate: date], ofItemAtPath: filePath)
        textView.text += "\n保存数据成功"

        textView.text += "\n\n**********************************************\n"
        textView.scrollToButtom()
    }

    @IBAction func removeAction(_ sender: UIButton) {
        let key = keyField.text ?? ""
        let filePath = makeFilePath(for: key)
        do {
            try manager.removeItem(atPath: filePath)
            textView.text += "\n删除成功 key: \(key)"
        } catch let error {
            textView.text += "\n删除失败  error: \(error.localizedDescription)"
        }
        textView.text += "\n\n**********************************************\n"
        textView.scrollToButtom()
    }

    @IBAction func readAction(_ sender: UIButton) {
        if !textView.text.isEmpty {
            textView.text += "\n"
        }
        textView.text += "开始读取数据。。。"

        let key = keyField.text ?? ""
        let filePath = makeFilePath(for: key)
        guard manager.fileExists(atPath: filePath) else {
            textView.text += "\n没有找到缓存 key: \(key)"
            textView.text += "\n\n**********************************************\n"
            textView.scrollToButtom()
            return
        }
        let attributes = try? manager.attributesOfItem(atPath: filePath)
        let date = attributes?[.modificationDate] as? Date
        let time = date?.timeIntervalSinceNow ?? 0

        if time <= 0 {
            textView.text += "\n缓存已过期"
            textView.text += "\n开始清除过期缓存...."
            do {
                try manager.removeItem(atPath: filePath)
                textView.text += "\n删除成功 key: \(key)"
            } catch let error {
                textView.text += "\n删除失败  error: \(error.localizedDescription)"
            }
            textView.text += "\n\n**********************************************\n"
            textView.scrollToButtom()
            return
        }

        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            let result = String(data: data, encoding: .utf8) ?? "无"
            textView.text += "\n缓存数据: key: \(key)  | data: \(result)"
        } else {
            textView.text += "\n读取数据失败"
        }
        textView.text += "\n\n**********************************************\n"
        textView.scrollToButtom()
    }
}

private extension FileTestViewController {
    func makeFilePath(for key: String) -> String {
        return "\(path)/\(makeFileName(for: key))"
    }

    func makeFileName(for key: String) -> String {
        let fileExtension = URL(fileURLWithPath: key).pathExtension
        let fileName = key.MD5

        switch fileExtension.isEmpty {
        case true:
            return fileName
        case false:
            return "\(fileName).\(fileExtension)"
        }
    }
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0
    }
}

extension UITextView {
    func scrollToButtom() {
        let rect = CGRect(x: 0, y: contentSize.height - 15, width: contentSize.width, height: 10)
        scrollRectToVisible(rect, animated: true)
    }
}
