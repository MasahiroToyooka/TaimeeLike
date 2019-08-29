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
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let address = addressTextField.text, let phone = phoneTextField.text, let date: Date = datePicker.date else {
            return
        }
        
        guard let phoneNum: Int = Int(phone) else { return }
        
        

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("新規作成失敗", error)
                return
            }

            db.add(user: User(userID: user!.user.uid, name: name, birthDay: date, address: address, phoneNumber: phoneNum, allTicket: nil))
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func switchShop(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
