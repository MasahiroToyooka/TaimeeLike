//
//  EditProfileViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/23.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditProfileViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var birthPicker: UIDatePicker!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func registerUser(_ sender: UIButton) {
        guard let name = nameTextField.text, let birthday: Date = birthPicker.date, let phone: Int = Int(phoneTextField.text!), let address = addressTextField.text else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return  }
        
        db.add(user: User(userID: uid, name: name, birthDay: birthday, address: address, phoneNumber: phone, allTicket: nil))
        dismiss(animated: true, completion: nil)
    }
}
