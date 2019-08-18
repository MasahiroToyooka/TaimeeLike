//
//  HomeViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/18.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bounces = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
 

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        scrollView.contentOffset.y
        if scrollView.contentOffset.y > 20 {
            
            UIView.animate(withDuration: 0.3) {
                self.viewTopConstraint.constant = -120
                self.view.layoutIfNeeded()
            }
        } else if scrollView.contentOffset.y < 20 {
            UIView.animate(withDuration: 0.3) {
                self.viewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }

        }
        
          print(scrollView.contentOffset.y)
    }
    

    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
////        viewTopConstraint.constant = -scrollView.contentOffset.y
//
////        if scrollView.contentOffset.y > 0{
////
////        }
//        UIView.animate(withDuration: 0.3) {
//            self.viewTopConstraint.constant = -120
//            self.view.layoutIfNeeded()
//            print(scrollView.decelerationRate)
//        }
//
////        print(scrollView.contentOffset)
//    }
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}




