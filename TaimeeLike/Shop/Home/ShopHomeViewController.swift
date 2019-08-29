
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

class ShopHomeViewController: ButtonBarPagerTabStripViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCurrentUser()
        
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.white
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
    }
    
    func checkCurrentUser() {
        if userID == nil {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! ShopLoginViewController
                let navcontroller = UINavigationController(rootViewController: vc)
                
                self.present(navcontroller, animated: true)
            }
        } else {
            print("shopID: ",userID!)
        }
    }
    
    
    @IBAction func postButton(_ sender: UIButton) {
        guard let shop = shop else {
            
            print("postButtonにてショップのデータ取得失敗")
            return
        }
        
        let VC = UIStoryboard(name: "Post", bundle: nil).instantiateViewController(withIdentifier: "Post") as! PostViewController
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // 返すViewControllerの配列
        var childViewControllers: [UIViewController] = []
        
        let IssueVC = UIStoryboard(name: "ShopHome", bundle: nil).instantiateViewController(withIdentifier: "Issue") as! IssueTicket
        let haveVC = UIStoryboard(name: "ShopHome", bundle: nil).instantiateViewController(withIdentifier: "Enable") as! EnableTicket
        
        childViewControllers.append(IssueVC)
        childViewControllers.append(haveVC)
        return childViewControllers
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Login")
            let navController = UINavigationController(rootViewController: vc)
            present(navController, animated: true, completion: nil)
        
            
        } catch let signOutError  {
            print ("Error signing out: %@", signOutError)
        }
    }
}
