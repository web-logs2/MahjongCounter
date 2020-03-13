//
//  UIKitExtension.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/2/25.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

extension UIColor {
    
    private static func generateColors() -> [UIColor] {
        let color1 = UIColor(red: 220/255.0, green: 197/255.0, blue: 224/255.0, alpha: 1)
        let color2 = UIColor(red: 241/255.0, green: 169/255.0, blue: 158/255.0, alpha: 1)
        let color3 = UIColor(red: 161/255.0, green: 222/255.0, blue: 209/255.0, alpha: 1)
        let color4 = UIColor(red: 252/255.0, green: 226/255.0, blue: 167/255.0, alpha: 1)
        let color5 = UIColor(red: 195/255.0, green: 238/255.0, blue: 245/255.0, alpha: 1)
        return [color1, color2, color3, color4, color5]
    }
    
    private static var colors = generateColors()
    
    static func random() -> UIColor {
        if let color = colors.randomElement() {
            if let index = colors.firstIndex(of: color) {
                return colors.remove(at: index)
            }
            fatalError("Color is not found")
        } else if colors.isEmpty {
            colors = generateColors()
            return random()
        }
        fatalError("Can not generate a random color")
    }
    
    static let lightGreen = UIColor(red: 38/255.0, green: 212/255.0, blue: 73/255.0, alpha: 1)
}

extension UIImage {
    
    convenience init?(color: UIColor) {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

extension UIBarButtonItem {
    
    static func add(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: target, action: action)
    }
    
    static func action(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .action, target: target, action: action)
    }
    
    static func end(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "结束", style: .plain, target: target, action: action)
    }
    
    static func done(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "完成", style: .done, target: target, action: action)
    }
    
    static func cancel(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "取消", style: .plain, target: target, action: action)
    }
    
    static func back() -> UIBarButtonItem {
        return UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
    }
}

extension UIView {
    
    @discardableResult
    func addTapGestureRecognizer(target: Any, action: Selector) -> UITapGestureRecognizer {
        let gr = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gr)
        self.isUserInteractionEnabled = true
        return gr
    }
}
