//
//  UserLoginViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/22.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserLoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("ログイン失敗", error)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func signupButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("新規作成失敗", error)
                return
            }
            self.dismiss(animated: true)
        }
    }
}
