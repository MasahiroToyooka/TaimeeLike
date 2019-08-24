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
    var haveTicket: [[String: Any]]?
    var ticketPlan: [[String: Any]]?
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
        precondition(userID == documentID)
        
        self.init(dictionary: dictionary)
    }
    
    /// Usersコレクションに書き込まれないユーザーデータ用の便利な初期化子
    /// Firestoreで。 他のデータタイプとは異なり、ユーザーはFirestoreに依存しません。
    ///一意の識別子が無料で付属しているため、一意の識別子を生成します。
    public init?(dictionary: [String: Any]) {
        
        guard let userID = dictionary["userID"] as? String,
            let name = dictionary["name"] as? String,
            let birthDay = dictionary["birthDay"] as? Date,
            let address = dictionary["address"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? Int,
            let haveTicket = dictionary["haveTicket"] as? [[String: Any]],
            let ticketPlan = dictionary["ticketPlan"] as? [[String: Any]] else { return nil }
   
        self.init(userID: userID, name: name, birthDay: birthDay, address: address, phoneNumber: phoneNumber, haveTicket: haveTicket, ticketPlan: ticketPlan)
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
            "haveTicket": haveTicket,
            "ticketPlan": ticketPlan
        ]
    }
}

