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
    
    @IBOutlet weak var shopImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    
    var ticketData: Ticket? {
        didSet {
            
            guard let image = ticketData?.imageUrls else { return }
            shopImageView.sd_setImage(with: URL(string: image.first ?? ""))
            titleText.text = ticketData?.text
            detailText.text = ticketData?.detailText
            
            // Date型から各々好みのフォーマットに変える
            let startFormatter = DateFormatter()
            startFormatter.dateFormat = "yyyy年M月dd日 HH:mm"
            let startDate: String = startFormatter.string(from: ticketData!.startDate)
            
            let endFormatter = DateFormatter()
            endFormatter.dateFormat = "HH:mm"
            let endTime: String = endFormatter.string(from: ticketData!.endDate)
            
            // 2019年8月31日　18:00 ~ 22:00みたいにしている
            dateLabel.text = "\(startDate) 〜 \(endTime)"
            
            
            if ticketData?.price == nil {
                priceText.text = ticketData?.productText
            } else {
                priceText.text = "\(ticketData?.price)円券"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
      
//        shopImageView.layer.shadowOffset = CGSize(width: 100, height: -200)
//        shopImageView.layer.shadowColor = UIColor.black.cgColor
//        shopImageView.layer.shadowOpacity = 0.8
//        shopImageView.layer.shadowRadius = 0
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
