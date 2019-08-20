//
//  CellModel.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/20.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
//
//protocol ProducesCellModel {
//    func toCellModel() -> CellModel
//}
//
//class CellModel {
//    
//    let shopName: String
//    let imageUrls: [String]?
//    let detailText: String
//    let jobDate: Date
//    let price: String
//    let address: String
//    
//    init(shopName: String, imageUrls: [String]?, detailText: String, jobDate: Date, price: String, address: String) {
//        self.shopName = shopName
//        self.imageUrls = imageUrls
//        self.detailText = detailText
//        self.jobDate = jobDate
//        self.price = price
//        self.address = address
//    }
//    
//    private var imageIndex = 0 {
//        didSet {
//            let imageUrl = imageUrls?[imageIndex]
//            //            let image = UIImage(named: imageName)
//            imageIndexObserver?(imageIndex, imageUrl)
//        }
//    }
//    
//    // Reactive Programming
//    var imageIndexObserver: ((Int, String?) -> ())?
//    
//    func toNextPhoto() {
//        imageIndex = min(imageIndex + 1, imageIndex - 1)
//    }
//    
//    func goToPreviousPhoto() {
//        imageIndex = max(0, imageIndex - 1)
//    }
//}
