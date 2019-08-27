//
//  TicketViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/23.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

// ライブラリの使い方https://qiita.com/KikurageChan/items/35593dc3aac8d694db8e
import XLPagerTabStrip

class TicketViewController: ButtonBarPagerTabStripViewController {

    
    @IBOutlet weak var tableView: UITableView!

    var iteminfo: [IndicatorInfo] = ["申し込みチケット", "保有チケット"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.white
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        // 返すViewControllerの配列
        var childViewControllers: [UIViewController] = []
        
        let reservationVC = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "ReservationTicketController") as! ReservationTicketController
        let haveVC = UIStoryboard(name: "Have", bundle: nil).instantiateViewController(withIdentifier: "Have") as! HaveTicketController
        
        childViewControllers.append(reservationVC)
        childViewControllers.append(haveVC)
        return childViewControllers
    }
    
}



