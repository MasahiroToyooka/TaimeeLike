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
    
    /// 仕事の始まりの時間
    var startDate: Date
    /// 仕事の終わりの時間
    var endDate: Date
    /// チケットを発行する店の情報
    var shopInfo: [String: Any]
    /// 商品券の値段
    var price: Int?
    /// 商品の情報
    var productText: String?
    /// 仕事内容のタイトル
    var text: String
    /// 仕事内容の詳細
    var detailText: String
    /// 働く時の店が提供する注意事項
    var attentionText: String

    /// 企業がチケットを発行したら0, userが申し込んだら１、 仕事が完了したら２、　チケットを消費したら３
    var ticketState: Int
    /// チケットの画像
    var imageUrls: [String]?
    
    /// ドキュメントID
    var documentID: String
    
    /// お店のID
    var shopID: String
}


extension Ticket: DocumentSerializable {
    
    public init?(dictionary: [String: Any]) {

        guard let startDate = dictionary["startDate"] as? Timestamp,
            let endDate = dictionary["endDate"] as? Timestamp,
            let shopInfo = dictionary["shopInfo"] as? [String: Any],
            let price = dictionary["price"] as? Int,
            let productText = dictionary["productText"] as? String,
            let text = dictionary["text"] as? String,
            let detailText = dictionary["detailText"] as? String,
            let attentionText = dictionary["attentionText"] as? String,
            let ticketState = dictionary["ticketState"] as? Int,
            let imageUrls = dictionary["imageUrls"] as? [String],
            let documentID = dictionary["documentID"] as? String,
            let shopID = dictionary["shopID"] as? String else {
                print("Ticket 初期化失敗")
                return nil
        }
        self.init(startDate: startDate.dateValue(), endDate: endDate.dateValue(), shopInfo: shopInfo, price: price, productText: productText, text: text, detailText: detailText, attentionText: attentionText, ticketState: ticketState, imageUrls: imageUrls, documentID: documentID, shopID: shopID)
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
            "shopID": shopID,
            "shopInfo": shopInfo,
            "price": price ?? 0,
            "productText": productText ?? "",
            "ticketState": ticketState,
            "startDate": startDate,
            "endDate": endDate,
            "imageUrls": imageUrls ?? "",
            "text": text,
            "detailText": detailText,
            "attentionText": attentionText
        ]
    }
}



extension Ticket {
    
    // サンプルデータを作るときに使うかものやつ
    
    static func imageURL(number: Int) -> String {
        let URLString =
        "https://storage.googleapis.com/firestorequickstarts.appspot.com/food_\(number).png"
        return URLString
    }
    
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
