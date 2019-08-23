//
//  Shop.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/22.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseAuth

struct Shop {
    
    var shopName: String
    //    var images: [UIImage]?
    var issueTicket: [[String: Any]]?
    var address: String
    var shopID : String
}


extension Shop: DocumentSerializable {
    
    ///すべてのショップは、後で照会しやすくするために、ShopIDによって保存されます。
    var documentID: String {
        return shopID
    }
    
    private init?(documentID: String, dictionary: [String: Any]) {
        guard let shopID = dictionary["shopID"] as? String else {return nil}
        
        precondition(shopID == documentID)
        
        self.init(dictionary: dictionary)
    }
    
    init?(dictionary: [String: Any]) {
        guard let shopName = dictionary["shopName"] as? String,
            let shopID = dictionary["shopID"] as? String,
            let address = dictionary["address"] as? String,
            let issueTicket = dictionary["issueTicket"] as? [[String: Any]] else { return nil}
        
        
        self.init(shopName: shopName, issueTicket: issueTicket, address: address, shopID: shopID)
    }
    
    
    init?(document: QueryDocumentSnapshot) {
        self.init(documentID: document.documentID, dictionary: document.data())
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        self.init(documentID: document.documentID, dictionary: data)
    }
    
    //    ///新しいユーザーを返します。nilが渡された場合、または指定されていない場合、デフォルト名とphotoURLを提供します。
    //    public init(shopID: String, shopName: String? = "吉野家", address: String)
    
    
    //    /// uidの衝突をチェックせずに、ランダムに生成されたユーザーをデフォルト名で返します
    //          ///およびプロフィール写真。
    //    public init() {
    //        let uid = UUID().uuidString
    //        self.init(userID: uid)
    //    }
    
    /// Firestoreでのユーザーオブジェクトの表現。
    public var documentData: [String : Any] {
        return [
            "shopID": shopID,
            "shopName": shopName,
            "address": address
        ]
    }
}

extension Shop {
    
    static let shopName = [
        "マクドナルド",
        "株式会社ユナイテッドアローズ",
        "すき家",
        "すかいらーくグループ",
        "株式会社良品計画 ",
        "吉野家",
        "株式会社ジーユー",
        "ケンタッキー",
        "株式会社ニトリ",
        "和民",
        "ミスタードーナッツ",
        "株式会社ユニクロ",
        "力の源ホールディングス",
        "株式会社ビックカメラ",
        "スターバックスコーヒー",
        "ドトール"
    ]
    
    static let address = [
        "東京都青梅市末広町2-19-16",
        "東京都台東区小島1-8",
        "東京都新宿区愛住町3-6-12",
        "東京都あきる野市二宮東2-10-3",
        "東京都千代田区西神田2-8-20",
        "東京都新宿区二十騎町2-5二十騎町ロイヤルパレス116",
        "東京都品川区勝島4-20-16勝島ドリーム206",
        "東京都江東区東砂2-13-20レジデンス東砂212",
        "東京都港区西麻布1-13-4西麻布庵317",
        "東京都新宿区新小川町4-15-8新小川町マンション215",
        "東京都稲城市矢野口2-20-3",
        "東京都千代田区有楽町4-10-7有楽町プレイス316",
        "東京都新宿区二十騎町2-11-15",
        "東京都港区麻布十番4-6-13コート麻布十番114",
        "東京都港区三田2-4-12",
        "東京都立川市若葉町4-1若葉町ハイツ214",
    ]
}
