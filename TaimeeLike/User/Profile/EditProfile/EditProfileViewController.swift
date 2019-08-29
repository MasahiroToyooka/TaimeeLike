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
import SPFakeBar
import RLBAlertsPickers


class EditProfileViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var birthPicker: UIDatePicker!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    let navBar = SPFakeBarView(style: .stork)

    // ステータスバーを白くして背景とのコントラストをよくする
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBar.titleLabel.text = "ユーザー情報"
        self.navBar.leftButton.setTitle("Cancel", for: .normal)
        self.navBar.leftButton.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
        
        self.view.addSubview(self.navBar)
    }

    
    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func setImageView(_ sender: UIButton) {
        
        let alert = UIAlertController(style: .actionSheet)
        alert.addPhotoLibraryPicker(
            flow: .vertical,
            paging: false,
            selection: .single(action: { image in

//                sender.setImage(image, for: .normal)
            }))
        alert.addAction(title: "閉じる", style: .cancel)
        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func openPickerAlert(_ sender: UIButton) {

        
        let alert = UIAlertController(style: .actionSheet)
        
        // ライブラリでローカル指定できるように書いたけどダメでした
        alert.addDatePicker(mode: .date, date: nil) { (date) in
            sender.titleLabel?.text = "123erty"
            
        }
        alert.addAction(title: "OK", style: .cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        
        guard let name = nameTextField.text, let birthday: Date = birthPicker.date, let phone = phoneTextField.text, let address = addressTextField.text else { return }
        guard let phoneNum: Int = Int(phone) else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.add(user: User(userID: uid, name: name, birthDay: birthday, address: address, phoneNumber: phoneNum, allTicket: []))
        dismiss(animated: true, completion: nil)
    }
}
