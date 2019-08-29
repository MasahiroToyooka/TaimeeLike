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
import FirebaseAuth



func RandomUniform(_ upperBound: Int) -> Int {
    return Int(arc4random_uniform(UInt32(upperBound)))
}

struct User {
    
    var userID: String
    var name: String
    // var profileImage
    var birthDay: Date
    var address: String
    var phoneNumber: Int
    // 申し込んだチケットを全て入れる documentIDを
    var allTicket: [String]?
}

extension User: DocumentSerializable {
    
    ///すべてのユーザーは、後で照会しやすくするために、ユーザーIDによって保存されます。
    var documentID: String {
        return userID
    }
    
    ///ドキュメントのスナップショットデータからユーザーを初期化します。
    private init?(documentID: String, dictionary: [String: Any]) {
        guard let userID = dictionary["userID"] as? String else { return nil}
        
        //これは、セキュリティルールを使用してサーバーで確認する必要があるものです。
        //一貫性のあるデータベースを維持するには、すべてのユーザーを最上位に保存する必要があります
        //ユーザーIDによるユーザーコレクション。 一部のクエリは、この一貫性に依存しています。
        print("userID: \(userID), documentID: \(documentID)")
        precondition(userID == documentID)
        
        self.init(dictionary: dictionary)
    }
    
    /// Usersコレクションに書き込まれないユーザーデータ用の便利な初期化子
    /// Firestoreで。 他のデータタイプとは異なり、ユーザーはFirestoreに依存しません。
    ///一意の識別子が無料で付属しているため、一意の識別子を生成します。
    public init?(dictionary: [String: Any]) {
        
  
//        使うかもだから残しとく
//        print(dictionary["userID"] as? String)
//        print(dictionary["name"] as? String)
//        let birth = dictionary["birthDay"] as? Timestamp
//        print(birth)
//        print(dictionary["address"] as? String)
//        print(dictionary["phoneNumber"] as? Int)
//        print(dictionary["allTicket"] as? [String])

        
        guard let userID = dictionary["userID"] as? String,
            let name = dictionary["name"] as? String,
            let birthDay = dictionary["birthDay"] as? Timestamp,
            let address = dictionary["address"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? Int else {
                print("user初期化失敗")
                return nil
        }
        
        // allTicketがnilの時の場初期化の場合分け
        if let allTicket = dictionary["allTicket"] as? [String] {
        
            self.init(userID: userID, name: name, birthDay: birthDay.dateValue(), address: address, phoneNumber: phoneNumber, allTicket: allTicket)
            
        } else {
            self.init(userID: userID, name: name, birthDay: birthDay.dateValue(), address: address, phoneNumber: phoneNumber, allTicket: nil)
        }
    }
    
    public init?(document: QueryDocumentSnapshot) {
        self.init(documentID: document.documentID, dictionary: document.data())
    }
    
    public init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        self.init(documentID: document.documentID, dictionary: data)
    }
    
    var documentData: [String : Any] {
        return [
            "userID": userID,
            "name": name,
            "birthDay": birthDay,
            "address": address,
            "phoneNumber": phoneNumber,
            "allTicket": allTicket
        ]
    }
}

