//
//  Ticket.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/22.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseAuth

struct Ticket {
    
    var date: Date
    var shopName: String
    var shopInfo: Shop
    var price: String
    var text: String
    var detailText: String
    var imageUrls: [String]?
    var ticketID: String
}


extension Ticket: DocumentSerializable {
    
    var documentID: String {
        return ticketID
    }
    
    private init?(documentID: String, dictionary: [String: Any]) {
        guard let ticketID = dictionary["ticketID"] as? String else { return nil}
        
        precondition(ticketID == documentID)
        
        self.init(dictionary: dictionary)
    }
    
    public init?(dictionary: [String: Any]) {
        guard let text = dictionary["text"] as? String,
            let detailText = dictionary["detailText"] as? String,
            let date = dictionary["date"] as? Date,
            let imageUrls = dictionary["imageUrls"] as? [String],
            let price = dictionary["price"] as? String,
            let shopName = dictionary["shopName"] as? String,
            let ticketID = dictionary["ticketID"] as? String,
            
            let shopInfo = dictionary["shopInfo"] as? [String: Any] else {return nil}
        
        guard let shop = Shop(dictionary: shopInfo) else {return nil}
        
        self.init(date: date, shopName: shopName, shopInfo: shop, price: price, text: text, detailText: detailText, imageUrls: imageUrls, ticketID: ticketID)
    }
    
    
    init?(document: QueryDocumentSnapshot) {
        self.init(documentID: document.documentID, dictionary: document.data())
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        self.init(documentID: document.documentID, dictionary: data)
    }
    
    var documentData: [String : Any] {
        return [
            "ticketID": ticketID,
            "shopName": shopName,
            "shopInfo": shopInfo,
            "price": price,
            "date": date,
            "imageUrls": imageUrls ?? "",
            "text": text,
            "detailText": detailText
        ]
    }
    
    static func imageURL(number: Int) -> String {
        let URLString =
        "https://storage.googleapis.com/firestorequickstarts.appspot.com/food_\(number).png"
        return URLString
    }
}





extension Ticket {
    
    static func randomPhotoURL() -> URL {
        let number = RandomUniform(22) + 1
        let URLString =
        "https://storage.googleapis.com/firestorequickstarts.appspot.com/food_\(number).png"
        return URL(string: URLString)!
    }
    
    //    static let imageUrls = [
    //        imageURL(number: 1),
    //        imageURL(number: 2),
    //        imageURL(number: 3),
    //        imageURL(number: 4),
    //        imageURL(number: 5),
    //        imageURL(number: 6),
    //        imageURL(number: 7),
    //        imageURL(number: 8),
    //        imageURL(number: 9),
    //        imageURL(number: 10),
    //        imageURL(number: 11),
    //        imageURL(number: 12),
    //        imageURL(number: 13),
    //        imageURL(number: 14),
    //        imageURL(number: 15),
    //        imageURL(number: 16),
    //        imageURL(number: 17),
    //        imageURL(number: 18),
    //        imageURL(number: 19),
    //        imageURL(number: 20)
    //    ]
}
