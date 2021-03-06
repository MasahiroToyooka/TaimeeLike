//
//  HomeViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/18.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import FSCalendar
import FirebaseAuth

class UserHomeController: UIViewController {
    
    let db = Firestore.firestore()
    
    /// カレンダー用のビュー
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendarView: FSCalendar!

    // 過去にスクロールされた合計のオフセット
    var pastDistance: CGFloat = 0
    
    // 画面遷移の進み具合に関する情報を保持するクラス
    private var detailInteractor: DetailInteractor?
    
    
    // カスタムトランジション側のクラスに引き渡す画像の情報とセルの位置情報
    private var selectedFrame: CGRect?
    private var selectedImage: UIImage?

    /// firebaseから受け取ったデータを格納するやつ
    var ticketData: [Ticket] = []
    
    
    var ticketListener: ListenerRegistration?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCurrentUser()
        
        setupCalendar()
        
        tableView.bounces = false

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "JobTableViewCell", bundle: nil), forCellReuseIdentifier: "JobTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startListeningForTickets()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopListeningForTickets()
    }
    
    func checkCurrentUser() {
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "UserLogin", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! UserLoginViewController
                
                self.present(vc, animated: true)
            }
        } else {
            print(Auth.auth().currentUser!.uid)
        }
    }
    
    
    func startListeningForTickets() {
        
        let basicQuery = db.tickets.limit(to: 20)
        
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
            self.tableView.reloadData()
        })
    }
    
    private func stopListeningForTickets() {
        ticketListener?.remove()
        ticketListener = nil
    }
    
    
    // カレンダーの初期設定
    func setupCalendar() {
        calendarView.scope = .week
//        calendarView.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)

        let weekDayLabel = self.calendarView.calendarWeekdayView.weekdayLabels
        weekDayLabel[0].text = "日"
        weekDayLabel[0].textColor = .red
        weekDayLabel[1].text = "月"
        weekDayLabel[1].textColor = .black
        weekDayLabel[2].text = "火"
        weekDayLabel[2].textColor = .black
        weekDayLabel[3].text = "水"
        weekDayLabel[3].textColor = .black
        weekDayLabel[4].text = "木"
        weekDayLabel[4].textColor = .black
        weekDayLabel[5].text = "金"
        weekDayLabel[5].textColor = .black
        weekDayLabel[6].text = "土"
        weekDayLabel[6].textColor = .blue
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let distanceDif = scrollView.contentOffset.y - pastDistance
        if distanceDif > 10 {
            
            UIView.animate(withDuration: 0.3) {
                self.viewTopConstraint.constant = -120
                self.view.layoutIfNeeded()
            }
        } else if distanceDif < 10 {
            UIView.animate(withDuration: 0.3) {
                self.viewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
//        print(distanceDif)
        
        pastDistance =  scrollView.contentOffset.y
    }
}

//extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
//
//
//}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! JobTableViewCell

        // タップしたセルよりセル内の画像と表示位置を取得する
        selectedImage = cell.shopImageView.image
        selectedFrame = view.convert(cell.shopImageView.frame, from: cell.shopImageView.superview)
        
        // 画面遷移時に遷移先のticketにticketdataを渡す
        let controller = DetailTicketController.fromStoryboard(forTicket: ticketData[indexPath.row])
//        self.tabBarController?.navigationController?.present(controller, animated: false, completion: nil)

        self.navigationController?.pushViewController(controller, animated: true)
        
        // 画面遷移を実行する際にUINavigationControllerDelegateの処理が実行される

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell", for: indexPath) as! JobTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.ticketData = ticketData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


// MARK: - UINavigationControllerDelegate

extension UserHomeController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let targetInteractor = detailInteractor else { return nil }
        return targetInteractor.transitionInProgress ? detailInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // カスタムトランジションのクラスに定義したプロパティへFrame情報とUIImage情報を渡す
        guard let frame = selectedFrame else { return nil }
        guard let image = selectedImage else { return nil }
        let detailTransition = DetailTransition()
        
        detailTransition.originFrame = frame
        detailTransition.originImage = image
        
        switch operation {
        case .push:
            self.detailInteractor = DetailInteractor(attachTo: toVC)
            detailTransition.presenting  = true
            return detailTransition
        default:
            detailTransition.presenting  = false
            return detailTransition
        }
    }
}



