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
    
    var startDate: Date
    var endDate: Date
    var shopInfo: [String: Any]
    var price: String
    var text: String
    var detailText: String
    
    /// userがチケットを使ったらfalseにするやつ
    var isEnabled: Bool
    var imageUrls: [String]?
    var documentID: String
}


extension Ticket: DocumentSerializable {
    
    public init?(dictionary: [String: Any]) {
        
        guard   let startDate = dictionary["startDate"] as? Date,
            let endDate = dictionary["endDate"] as? Date,
            let shopInfo = dictionary["shopInfo"] as? [String: Any],
            let price = dictionary["price"] as? String,
            let text = dictionary["text"] as? String,
            let detailText = dictionary["detailText"] as? String,
            let isEnabeled = dictionary["isEnabled"] as? Bool,
            let imageUrls = dictionary["imageUrls"] as? [String],
        
            let documentID = dictionary["documentID"] as? String else {
                return nil
        }
    
        
        self.init(startDate: startDate, endDate: endDate, shopInfo: shopInfo, price: price, text: text, detailText: detailText, isEnabled: isEnabeled, imageUrls: imageUrls, documentID: documentID)
    }
    
    
    init?(document: QueryDocumentSnapshot) {
        self.init(dictionary: document.data())
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        self.init(dictionary: data)
    }
    
    var documentData: [String : Any] {
        return [
            "documentID": documentID,
            "shopInfo": shopInfo,
            "price": price,
            "isEnabled": isEnabled,
            "startDate": startDate,
            "endDate": endDate,
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
    
        static let imageUrls = [
            imageURL(number: 1),
            imageURL(number: 2),
            imageURL(number: 3),
            imageURL(number: 4)
        ]
    
//    "マクドナルド",
//    "株式会社ユナイテッドアローズ",
//    "すき家",
//    "すかいらーくグループ",
//    "株式会社良品計画 ",
//    "吉野家",
//    "株式会社ジーユー",
//    "ケンタッキー",
//    "株式会社ニトリ",
//    "和民",
//    "ミスタードーナッツ",
//    "株式会社ユニクロ",
//    "力の源ホールディングス",
//    "株式会社ビックカメラ",
//    "スターバックスコーヒー",
//    "ドトール"
    static let texts: [String] = [
        "クルー募集！",
        "商品管理, 在庫仕分け！",
        "接客・調理・清掃などをお願いします。",
        "フロアースタッフ募集！！",
    ]
    static let detailTexts: [String] = [
    "主に、キッチン内でハンバーガー・サイドメニュー(マックフライポテト等)の調理を行う「キッチンクルー」、お客様を満面の笑顔(スマイル)でお迎えし、レジカウンターでの接客・商品注文(オーダー)受付を行う「フロントクルー」といったポジションがあります。",
        "お客様をきれいなお店でお迎え！おいしい牛丼を!あなたの笑顔で！すばやく提供！",
        "お客様のご案内、ご注文のご確認、料理・ドリンク運び、お会計など、店内での接客業務全般をお願いします。",
    "倉庫や本社から届く商品を段ボールから出して、バックヤードや店舗用の倉庫に保管する作業です。納品リストを見ながら商品は間違えていないか、数は合っているか、検品していきます。どんな業種のショップでも必要な作業で、アイドル時間（空いている時間）に担当になったスタッフがバックヤードなどで行ないます。"
    ]
    
    static let prices: [String] = [
        "6千円分の商品券をプレゼント！",
        "3千円分の商品券をプレゼント！",
        "7千円分の商品券をプレゼント！",
        "9千円分の商品券をプレゼント！"
    ]
}
