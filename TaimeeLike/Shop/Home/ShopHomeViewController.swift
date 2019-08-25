
//
//  ShopHomeViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/25.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FirebaseFirestore
import FirebaseAuth

class ShopHomeViewController: UIViewController {

    let db = Firestore.firestore()
    
    var shop: Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchShopData()
        
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
    
    @IBAction func postButton(_ sender: UIButton) {
        guard let shop = shop else { return }
        let controller = PostViewController.fromStoryboard(forShop: shop)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
