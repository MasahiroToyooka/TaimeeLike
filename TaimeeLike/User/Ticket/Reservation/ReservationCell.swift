//
//  ReservationCell.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/27.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class ReservationCell: UITableViewCell {
    
    var ticketData: Ticket? {
        
        didSet {
            
            guard let image = ticketData?.imageUrls else { return }
            shopImage.sd_setImage(with: URL(string: image.first ?? ""))
            shopName.text = ticketData?.shopInfo["shopName"] as! String
            addressLabel.text = ticketData?.shopInfo["address"] as! String
            
            //Date型から各々好みのフォーマットに変える
            let startFormatter = DateFormatter()
            startFormatter.dateFormat = "yyyy年M月dd日 HH:mm"
            let startDate: String = startFormatter.string(from: ticketData!.startDate)

            let endFormatter = DateFormatter()
            endFormatter.dateFormat = "HH:mm"
            let endTime: String = endFormatter.string(from: ticketData!.endDate)

            // 2019年8月31日　18:00 ~ 22:00みたいにしている
            dateLabel.text = "\(startDate) 〜 \(endTime)"
            
            guard let price = ticketData?.price else { return }
            priceLabel.text = "\(price)円券"
        }
    }
    

    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
