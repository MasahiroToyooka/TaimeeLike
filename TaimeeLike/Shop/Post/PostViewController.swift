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
    
    
    
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkCurrentUser()
        
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
        guard let startTime: Date = startTime.date, let endDate: Date = endTime.date, let text = text.text, let detailText = detailtext.text, let price = priceText.text else {
            return
        }
//        let document = db.shops.document("32455259-E1D6-4B1D-9311-BA4EA4C53368")
        
//        let ownerID = Auth.auth().currentUser?.uid
//
//        let shopDocument = db.shops.document("\(ownerID)")
//
//        let shop = Shop(document: shopDocument)
//
//        let dictionary: [String: Any] = [
//            "shopName": shop?.shopName, "issueTicket": ]
//
//        let ticket = Ticket(startDate: startTime, endDate: endDate, shopInfo: <#T##[String : Any]#>, price: <#T##String#>, text: <#T##String#>, detailText: <#T##String#>, imageUrls: <#T##[String]?#>, documentID: <#T##String#>)
        
        
    }
}
