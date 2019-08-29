//
//  IssueTicket.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/28.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Firebase

class IssueTicket: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var tableView: UITableView!
    
    var ticketListener: ListenerRegistration?

    /// firebaseから受け取ったデータを格納するやつ
    var ticketData: [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "IssueCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startListeningForTickets()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopListeningForTickets()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "発行したチケット")
    }
    
    func startListeningForTickets() {
        // チケットの状態が０のやつ(企業が投稿して申し込みがされていない状態)のだけ取得
        
        let basicQuery = db.tickets.whereField("shopID", isEqualTo: userID)
        
        ticketListener = basicQuery.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("ホームビューコントローラーにてチケットのデータ取得失敗: ", error)
                return
            }
            guard let snapshot = snapshot else { return }
            self.ticketData = []
            for ticketDocument in snapshot.documents {
                if let newTicket = Ticket(document: ticketDocument) {
                    self.ticketData.append(newTicket)
                }
            }
            print("ticketdata: ",self.ticketData.count)
        })
        
        self.tableView.reloadData()

    }
    
    func stopListeningForTickets() {
        ticketListener?.remove()
        ticketListener = nil
    }
}

extension IssueTicket: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IssueCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.ticketData = ticketData[indexPath.row]
        cell.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}
