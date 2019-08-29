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
            // 受け取ったデータからそれぞれ代入
            
            guard let image = ticketData?.imageUrls else { return }
            shopImage.sd_setImage(with: URL(string: image.first ?? ""))
            shopName.text = ticketData?.shopInfo["shopName"] as? String
            addressLabel.text = ticketData?.shopInfo["address"] as? String
            
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
    
    // お店の画像
    @IBOutlet weak var shopImage: UIImageView!
    // お店の名前
    @IBOutlet weak var shopName: UILabel!
    // 仕事の日付
    @IBOutlet weak var dateLabel: UILabel!
    // お店の住所
    @IBOutlet weak var addressLabel: UILabel!
    // チケットの値段
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
