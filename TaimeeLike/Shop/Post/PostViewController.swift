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
    
    // 遷移元でこれを呼び出す
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Post", bundle: nil), forShop shop: Shop) -> PostViewController {
        
        let controller = storyboard.instantiateViewController(withIdentifier: "Post") as! PostViewController
        controller.shop = shop
        return controller
    }
    

    @IBOutlet weak var startTime: UIDatePicker!
    
    @IBOutlet weak var endTime: UIDatePicker!
    
    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var detailtext: UITextField!
    
    @IBOutlet weak var priceText: UITextField!
    
    @IBOutlet weak var attentionLabel: UITextField!
    
    
    let db = Firestore.firestore()
    
    var shop: Shop!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        text.text = "タイトル情報"
    }
    
    

    
    @IBAction func PostButton(_ sender: UIButton) {
        guard let startDate: Date = startTime.date, let endDate: Date = endTime.date, let text = text.text, let detailText = detailtext.text, let attention = attentionLabel.text, let price = priceText.text else {
            return
        }
        
        let dictionary: [String: Any] = [
            "stockName": shop.stockName,
            "shopName": shop.shopName,
            "address": shop.address,
            "shopID": shop.shopID
        ]
        
        let ticket = Ticket(startDate: startDate, endDate: endDate, shopInfo: dictionary, price: nil, productText: price, text: text, detailText: detailText, attentionText: attention, ticketState: 0, imageUrls: Ticket.imageUrls, documentID: UUID().uuidString)
        
        db.add(ticket: ticket)
        navigationController?.popViewController(animated: true)
    }
}
