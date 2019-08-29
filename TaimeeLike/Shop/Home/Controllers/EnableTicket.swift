//
//  EnableTicket.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/28.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class EnableTicket: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "EnableCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "負債チケット")
    }
}

extension EnableTicket: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EnableCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
