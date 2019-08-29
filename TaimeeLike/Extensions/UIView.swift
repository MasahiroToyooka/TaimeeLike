////
////  UIView.swift
////  TaimeeLike
////
////  Created by 豊岡正紘 on 2019/08/19.
////  Copyright © 2019 Masahiro Toyooka. All rights reserved.
////
//
//import UIKit
//
//extension UIView {
//    
//    // 枠線の色
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return layer.borderColor.map { UIColor(cgColor: $0) }
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//    
//    // 枠線のWidth
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    
//    // 角丸設定
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//}
