//
//  HaveTicketController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/27.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HaveTicketController: UIViewController, IndicatorInfoProvider {

    
    @IBOutlet weak var tableView: UITableView!
    
//    var itemInfo: IndicatorInfo = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "HaveCell", bundle: nil), forCellReuseIdentifier: "Cell")


    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "保有チケット")
    }
    

}

extension HaveTicketController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HaveCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}