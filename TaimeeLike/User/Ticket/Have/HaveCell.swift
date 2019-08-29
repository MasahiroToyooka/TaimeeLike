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
            // データを受け取ったらそれぞれ代入
            
            guard let image = ticketData?.imageUrls else { return }
            shopImage.sd_setImage(with: URL(string: image.first ?? ""))
            shopName.text = ticketData?.shopInfo["shopName"] as? String
            shopAddress.text = ticketData?.shopInfo["address"] as? String
            
            guard let price = ticketData?.price else { return }
            priceLabel.text = "\(price)円券"
        }
    }
            
       
    // お店の画像を表示するイメージビュー
    @IBOutlet weak var shopImage: UIImageView!
    // お店の名前
    @IBOutlet weak var shopName: UILabel!
    // ぽ店の住所
    @IBOutlet weak var shopAddress: UILabel!
    
    // チケットの値段
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
