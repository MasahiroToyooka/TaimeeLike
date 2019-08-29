//
//  HaveCell.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/27.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import SDWebImage

class HaveCell: UITableViewCell {

    
    var ticketData: Ticket? {
        
        didSet {
            
            guard let image = ticketData?.imageUrls else { return }
            shopImage.sd_setImage(with: URL(string: image.first ?? ""))
            shopName.text = ticketData?.shopInfo["shopName"] as! String
            shopAddress.text = ticketData?.shopInfo["address"] as! String
            
            if ticketData?.price == nil {
                priceLabel.text = ticketData?.productText
            } else {
                priceLabel.text = "\(ticketData?.price)円券"
            }
        }
    }
            
       
    
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var shopAddress: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
