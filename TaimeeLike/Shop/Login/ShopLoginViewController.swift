//
//  LoginViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import FirebaseAuth

class ShopLoginViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // ユーザー新規作成
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        // FirebaseAuthの新規登録処理
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("新規作成失敗")
                return
            }
            // 認証成功
            print("新規作成成功")
        }
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    
}
