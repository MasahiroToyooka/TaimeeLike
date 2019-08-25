//
//  LoginViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/21.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShopLoginViewController: UIViewController {

    
    // 公式の株式会社〇〇的な名前のやつ　企業登録として使う
    @IBOutlet weak var stockName: UITextField!
    // メールアドレスを入力する
    @IBOutlet weak var emailTextField: UITextField!
    // パスワードを入力する
    @IBOutlet weak var passwordTextField: UITextField!
    // 認知されてるお店の名前 なんでもok
    @IBOutlet weak var shopNameTextField: UITextField!
    // お店の住所
    @IBOutlet weak var addressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = "shop1@gmail.com"
        passwordTextField.text = "shopshop1"
        addressTextField.text = "東京都目黒区自由が丘２丁目１１−９"
        stockName.text = "日本マクドナルド株式会社"
        shopNameTextField.text = "マクドナルド"

    }
    
    // ユーザー新規作成
    @IBAction func signUpButton(_ sender: Any) {
        
        print("サインインボタンが押されました")
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let shopName = shopNameTextField.text,
            let address = addressTextField.text,
            let stockName = stockName.text else {
            return
        }
        
        
        // FirebaseAuthの新規登録処理
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("新規作成失敗", error)
                return
            }
            // 認証成功
            print("新規作成成功")
            
            self.dismiss(animated: true, completion: {
                db.add(shop: Shop(stockName: stockName, shopName: shopName, address: address, shopID: user!.user.uid))
            })
        }
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        print("ログインボタンが押されました")

        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("新規作成失敗",error)
                return
            }
            // 認証成功
            print("新規作成成功")
            
            self.dismiss(animated: true)
        }
    }
}
