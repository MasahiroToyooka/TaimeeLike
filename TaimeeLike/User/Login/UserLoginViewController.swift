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
    
    // 名前を入力するラベル
    @IBOutlet weak var nameTextField: UITextField!
    // メールアドレスを入力するラベル
    @IBOutlet weak var emailTextField: UITextField!
    // パスワードを入力するラベル
    @IBOutlet weak var passwordTextField: UITextField!
    // 住所を入力するラベル
    @IBOutlet weak var addressTextField: UITextField!
    // 電話番号を入力するラベル
    @IBOutlet weak var phoneTextField: UITextField!
    // 生年月日を入力するピッカー
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // ログインボタン
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        // ログイン
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("ログイン失敗", error)
                return
            }
            self.dismiss(animated: true)
        }
    }
    
    // サインインボタン
    @IBAction func signupButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let address = addressTextField.text, let phone = phoneTextField.text, let date: Date = datePicker.date else {
            return
        }
        
        guard let phoneNum: Int = Int(phone) else { return }
        
        // アカウントを新規作成
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("新規作成失敗", error)
                return
            }

            // Userの初期設定
            db.add(user: User(userID: user!.user.uid, name: name, birthDay: date, address: address, phoneNumber: phoneNum, allTicket: []))
            self.dismiss(animated: true)
        }
    }
    
    // 企業側のログイン画面に移動する
    @IBAction func switchShop(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
