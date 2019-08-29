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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchUserTicket()
        
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.white
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
        
    }
    
    
    func fetchUserTicket() {
        guard let allTicket = user?.allTicket else {
            print("AllTicketのデータがありません")
            return
        }
        
//        userTicket = []
        
        for i in 0..<allTicket.count {
            
            db.tickets.document(allTicket[i]).getDocument { (snapshot, error) in
                
                if let error = error {
                    print("allTicketのデータ取得失敗: ",error)
                    return
                }
                
                guard let document = snapshot else { return }
                
                if let newTicket = Ticket(document: document) {
                    print("newTicket: ",newTicket)
                    userTicket.append(newTicket)
                    
                    print("userTicketの数: ",userTicket.count)
                }
                if i == allTicket.count - 1 {
                    self.checkTicketState()
                }
            }
        }
        
        print("userTicketの数!: ",userTicket.count)
    }
    
    // stateでticketを振り分ける
    func checkTicketState() {
        print("userTicketの数!!: ",userTicket.count)

        
        reservationTicket = []
        haveTicket = []
        
        for i in 0..<userTicket.count {
            
            if userTicket[i].ticketState == 1 {
                reservationTicket.append(userTicket[i])
            } else if userTicket[i].ticketState == 2 {
                haveTicket.append(userTicket[i])
            }
        }
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



