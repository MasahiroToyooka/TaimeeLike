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
            shopImageView.sd_setImage(with: URL(string: image.first ?? ""), completed: nil)
            titleText.text = ticketData?.text
            detailText.text = ticketData?.detailText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
