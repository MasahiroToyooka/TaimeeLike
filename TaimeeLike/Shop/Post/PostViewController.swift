//
//  PostViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PostViewController: UIViewController {

    @IBOutlet weak var startTime: UIDatePicker!
    
    @IBOutlet weak var endTime: UIDatePicker!
    
    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var detailtext: UITextField!
    
    @IBOutlet weak var priceText: UITextField!
    
    @IBOutlet weak var attentionLabel: UITextField!
    
    
    let db = Firestore.firestore()
    
    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkCurrentUser()
        
//        db.shops.getDocuments { (shop, error) in
//            let error = error {
//                print("shop情報の取得失敗",error)
//                return
//            }
//
//
//        }
    
        
        fetchShopData()
        
        text.text = "タイトル情報"
    }
    
    func fetchShopData() {
        db.shops.document(Auth.auth().currentUser!.uid).getDocument { (shapshot, error) in
            
            if let error = error {
                print("shop情報の取得失敗", error)
                return
            }
            
            guard let snapShot = shapshot else { return }
            
            self.shop = Shop(document: snapShot)
        }
    }
    
    
    func checkCurrentUser() {
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! ShopLoginViewController
                
                self.present(vc, animated: true)
            }
        } else {
            print(Auth.auth().currentUser!.uid)
        }
    }
    
    @IBAction func PostButton(_ sender: UIButton) {
        guard let startDate: Date = startTime.date, let endDate: Date = endTime.date, let text = text.text, let detailText = detailtext.text, let attention = attentionLabel.text, let price = priceText.text else {
            return
        }
        
        let dictionary: [String: Any] = [
            "stockName": shop?.stockName,
            "shopName": shop?.shopName,
            "address": shop?.address,
            "shopID": shop?.shopID
        ]

//        let ticket = Ticket(startDate: startTime, endDate: endDate, shopInfo: <#T##[String : Any]#>, price: <#T##String#>, text: <#T##String#>, detailText: <#T##String#>, imageUrls: <#T##[String]?#>, documentID: <#T##String#>)
        
        let ticket = Ticket(startDate: startDate, endDate: endDate, shopInfo: dictionary, price: nil, productText: price, text: text, detailText: detailText, attentionText: attention, ticketState: 0, imageUrls: Ticket.imageUrls, documentID: UUID().uuidString)
        
        db.add(ticket: ticket)
    }
}
