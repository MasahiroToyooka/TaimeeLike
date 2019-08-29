//
//  ReservationTicketController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/27.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ReservationTicketController: UIViewController, IndicatorInfoProvider {
  

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "Cell")

    }

    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "予約チケット")
    }
}

extension ReservationTicketController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationTicket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReservationCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        // ReservationCellにデータを渡す
        cell.ticketData = reservationTicket[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(123)
    }
    
}
