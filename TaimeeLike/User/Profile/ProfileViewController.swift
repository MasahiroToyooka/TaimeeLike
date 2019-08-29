//
//  ProfileViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/19.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import SPStorkController
import RLBAlertsPickers
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // SPStorkControllerのライブラリによるpresent遷移
    @IBAction func editProfile(_ sender: UIButton) {
        
        // 遷移先を指定
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
     
        // 遷移内容を初期化
        let transitioningDelegate = SPStorkTransitioningDelegate()
        
        // ライブラリの初期設定
        // 閉じるボタンえをけす
        transitioningDelegate.showCloseButton = false
        // つまみを表示
        transitioningDelegate.showIndicator = true
        // つまみの色の指定
        transitioningDelegate.indicatorColor = .darkGray
        transitioningDelegate.hideIndicatorWhenScroll = true
        transitioningDelegate.indicatorMode = .auto
        
        // トランジッションのデリゲートの指定、遷移スタイルをカスタムに変更、　表示
        controller.transitioningDelegate = transitioningDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        
        
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
// 残しとく
//    @IBAction func logoutButton(_ sender: UIButton) {
//        print(123)
//
//        do {
//            try Auth.auth().signOut()
//
//            let storyboard = UIStoryboard(name: "Login", bundle: nil)
//
//            let vc = storyboard.instantiateViewController(withIdentifier: "Login")
//            let navController = UINavigationController(rootViewController: vc)
//            present(navController, animated: true, completion: nil)
//
//
//        } catch let signOutError  {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
}
