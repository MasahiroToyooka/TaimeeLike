//
//  DetailJobController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/19.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class DetailJobController: UIViewController {
    
    var imageCount = 4
    
    var imageViews: [UIImage] = [#imageLiteral(resourceName: "profile1"), #imageLiteral(resourceName: "profile3"), #imageLiteral(resourceName: "profile2"), #imageLiteral(resourceName: "profile6")]
    
 
    // お店についての画像
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBOutlet weak var barsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopImage.image = #imageLiteral(resourceName: "profile1")
        
        (0..<imageCount).forEach { (_) in
            
            let barView = UIView()
            barView.backgroundColor = UIColor(white: 0, alpha: 0.1)

            barsStackView.addArrangedSubview(barView)
        }
    }
    
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        let tapLocation = sender.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > shopImage.frame.width / 2 ? true : false
        
        if shouldAdvanceNextPhoto {
            
            print("次の画像へ")
            
            
        } else {
            print("前の画像へ")
        }
        
    }
}
