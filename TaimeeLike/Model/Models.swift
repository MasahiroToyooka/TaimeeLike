//
//  User.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/20.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation

struct User {
    
    var uid: String?
    var firstName: String?
    var secondName: String?
    var year: Int?
    var month: Int?
    var day: Int?
    
}

struct Ticket {
    
    var shopId: String?
    
    
}

struct ShopModel {
    
    var shopName: String?
    var images: [UIImage]?
    var address: String?
    var ShopId : String?
    
    init(dictionary: [String: Any]) {
        
        self.shopName = dictionary["shopName"] as? String
        self.address = dictionary["address"] as? String
        self.images = dictionary["images"] as? [UIImage]
        self.ShopId = dictionary["shopId"] as? String
    }
    
}
