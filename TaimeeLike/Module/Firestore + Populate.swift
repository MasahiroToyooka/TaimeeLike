//
//  Firestore + Populate.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import FirebaseFirestore

// Firestoreドキュメントから初期化できるタイプ。
public protocol DocumentSerializable {
    
    /// Firestoreドキュメントからインスタンスを初期化します。 失敗する場合があります
    ///ドキュメントに必須フィールドがありません。
    init?(document: QueryDocumentSnapshot)
    
    /// Firestoreドキュメントからインスタンスを初期化します。 失敗する場合があります
    ///ドキュメントが存在しないか、必須フィールドがありません。
    init?(document: DocumentSnapshot)
    
    /// FirestoreのオブジェクトのdocumentID。
    var documentID: String { get }
    
    /// Firestoreのドキュメントシリアル化可能なオブジェクトの表現。
    var documentData: [String: Any] { get }
}


extension Firestore {
    
    var shops: CollectionReference {
        return self.collection("shops")
    }
    
    var tickets: CollectionReference {
        return self.collection("tickets")
    }
    
    var users: CollectionReference {
        return self.collection("users")
    }
}


extension Firestore {
    
    func add(shop: Shop) {
        self.shops.document(shop.documentID).setData(shop.documentData)
    }
    
    func add(ticket: Ticket) {
        self.tickets.document(ticket.documentID).setData(ticket.documentData)
    }
    
    func add(user: User) {
        self.users.document(user.documentID).setData(user.documentData)
    }
}

extension WriteBatch {
    
    func add(shop: Shop) {
        let document = Firestore.firestore().shops.document(shop.documentID)
        self.setData(shop.documentData, forDocument: document)
    }
    
    func add(ticket: Ticket) {
        let document = Firestore.firestore().tickets.document(ticket.documentID)
        self.setData(ticket.documentData, forDocument: document)
    }
    
    func add(user: User) {
        let document = Firestore.firestore().users.document(user.documentID)
        self.setData(user.documentData, forDocument: document)
    }
}



extension Firestore {
    
    func sampleData() -> (shops: [Shop], ticket: [Ticket]) {
        
        let shopCount = 16
        let ticketCount = 10
       
        let shops: [Shop] = (0..<shopCount).map { (num) in
            let shopID = UUID().uuidString
            let shopName = Shop.shopName[num]
            let address = Shop.address[num]
            return Shop(shopName: shopName, address: address, shopID: shopID)
        }
        
    }
}
