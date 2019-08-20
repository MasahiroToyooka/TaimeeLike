//
//  User.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/20.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

// Firestoreドキュメントから初期化できるタイプ。
protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

struct User {
    
    var uid: String?
    var firstName: String?
    var lastName: String?
    var birthDay: Date?
    var address: String?
    var phoneNumber: Int?
    
    
    var ticketPlan: [Ticket]?
    var haveTicket: [Ticket]?
}


struct Ticket {
    
    var date: Date
    var shopData: ShopModel
    var price: String
    var detailText: String
    var imageUrls: [String]?
    
    var dictionary: [String: Any] {
        return [
            "date": date,
            "shopData": shopData,
            "price": price,
            "detailText": detailText,
            "imageUrls": imageUrls ?? ""
        ]
    }
    
//    init(dictionary: [String: Any]) {
//        
//        self.date = dictionary["date"] as! Date
//        self.shopData = dictionary["shopData"] as! ShopModel
//        self.price = dictionary["price"] as! String
//        self.detailText = dictionary["detailText"] as! String
//        self.imageUrls = dictionary["imageUrls"] as! [String]?
//    }
    
//    func toCellModel() -> CellModel {
//
//        let shopName = shopData.shopName
//        let address = shopData.address
//
//        return CellModel(shopName: shopName, imageUrls: imageUrls, detailText: detailText, jobDate: date, price: price, address: address)
//    }
    
}


extension Ticket: DocumentSerializable {

    init?(dictionary: [String : Any]) {
        guard let date = dictionary["date"] as? Date,
            let shopData = dictionary["shopData"] as? ShopModel,
            let price = dictionary["price"] as? String,
            let detailText = dictionary["detailText"] as? String,
            let imageUrls = dictionary["imageUrls"] as? [String]? else {return nil}
        
        self.init(date: date, shopData: shopData, price: price, detailText: detailText, imageUrls: imageUrls)
    }
}


struct ShopModel {
    
    var shopName: String
    //    var images: [UIImage]?
    var address: String
    var ShopId : String?
    
    init(dictionary: [String: Any]) {
        
        self.shopName = dictionary["shopName"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        //        self.images = dictionary["images"] as? [UIImage]
        self.ShopId = dictionary["shopId"] as? String
    }
}


extension Ticket {
    
    static let
}


