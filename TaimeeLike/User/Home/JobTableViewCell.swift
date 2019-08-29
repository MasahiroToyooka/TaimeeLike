//
//  JobTableViewCell.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/19.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import SDWebImage

class JobTableViewCell: UITableViewCell {
    
    /// お店の画像とか乗せるやつ
    @IBOutlet weak var shopImageView: UIImageView!

    ///
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var priceText: UILabel!
    /// 日付のラベル
    @IBOutlet weak var dateLabel: UILabel!
    
    var ticketData: Ticket? {
        didSet {
            
            // 受け取ったデータからlabel, imageViewに反映
            guard let image = ticketData?.imageUrls else { return }
            shopImageView.sd_setImage(with: URL(string: image.first ?? ""))
            shopNameLabel.text = ticketData?.shopInfo["shopName"] as! String
            titleText.text = ticketData?.text
            
            // Date型から各々好みのフォーマットに変える
            let startFormatter = DateFormatter()
            startFormatter.dateFormat = "yyyy年M月dd日 HH:mm"
            let startDate: String = startFormatter.string(from: ticketData!.startDate)
            
            let endFormatter = DateFormatter()
            endFormatter.dateFormat = "HH:mm"
            let endTime: String = endFormatter.string(from: ticketData!.endDate)
            
            // 2019年8月31日　18:00 ~ 22:00みたいにしている
            dateLabel.text = "\(startDate) 〜 \(endTime)"
            
            
            guard let price = ticketData?.price else { return }
            priceText.text = "\(price)円券"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white

//　残しとく
// imageviewに影と角丸を加えるためのやつ、
//        shopImageView.layer.shadowOffset = CGSize(width: 100, height: -200)
//        shopImageView.layer.shadowColor = UIColor.black.cgColor
//        shopImageView.layer.shadowOpacity = 0.8
//        shopImageView.layer.shadowRadius = 0
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
