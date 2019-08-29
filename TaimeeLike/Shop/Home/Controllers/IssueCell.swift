//
//  IssueCell.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/28.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell {

    
    var ticketData: Ticket? {
        didSet {
            print("ticketData: ",ticketData)
            
            guard let image = ticketData?.imageUrls else { return }
            shopImage.sd_setImage(with: URL(string: image.first ?? ""))
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
            
            
            if ticketData?.price == nil {
                priceText.text = ticketData?.productText
            } else {
                priceText.text = "\(ticketData?.price)円券"
            }
        }
    }
    
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
