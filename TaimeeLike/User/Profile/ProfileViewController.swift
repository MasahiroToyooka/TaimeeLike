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

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func editProfile(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
     
        let transitioningDelegate = SPStorkTransitioningDelegate()
        transitioningDelegate.showCloseButton = false
        transitioningDelegate.showIndicator = true
        transitioningDelegate.indicatorColor = .blue
        transitioningDelegate.hideIndicatorWhenScroll = true
        transitioningDelegate.indicatorMode = .auto
        
        controller.transitioningDelegate = transitioningDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        
        self.present(controller, animated: true, completion: nil)
    }
    
}
