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
        
    /// カレンダーが入っているビュ-のtopConstraint
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    /// カレンダー表示用のビュー
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
    
    
    // チケットの変更内容を監視するやつ
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

    // ユーザーのログイン状況に合わせてログイン画面を表示する
    func checkCurrentUser() {
        if Auth.auth().currentUser == nil {
            // ログインされていない場合
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "UserLogin", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! UserLoginViewController
                
                self.present(vc, animated: true)
            }
        } else {
            print("Current userのid: ",Auth.auth().currentUser!.uid)
        }
    }
    
    // チケットのデータを監視するやつ
    func startListeningForTickets() {
        // チケットの状態が０のやつ(企業が投稿して申し込みがされていない状態)のだけ取得
        let basicQuery = db.tickets.whereField("ticketState", isEqualTo: 0)
        
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
            // テーブルビューを更新
            self.tableView.reloadData()
        })
    }
    
    // データベースの監視をストップする
    func stopListeningForTickets() {
        ticketListener?.remove()
        ticketListener = nil
    }
    
    
    // カレンダーの初期設定
    func setupCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        // カレンダーの表示をweekに指定
        calendarView.scope = .week
        

//        https://teratail.com/questions/207602?whotofollow=
//        calendarView.setScope(.week, animated: true)
//        calendarView.collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)

        
        let weekDayLabel = self.calendarView.calendarWeekdayView.weekdayLabels
        
        // カレンダーの色を土曜日は青,日曜日は赤, 平日は黒
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
    
    // スクロールの量でビューを上げ下げする
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let distanceDif = scrollView.contentOffset.y - pastDistance
        if distanceDif > 10 {
            // viewを隠す
            UIView.animate(withDuration: 0.3) {
                self.viewTopConstraint.constant = -120
                self.view.layoutIfNeeded()
            }
        } else if distanceDif < 10 {
            // 元に戻す
            UIView.animate(withDuration: 0.3) {
                self.viewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        pastDistance =  scrollView.contentOffset.y
    }
}


// MARK:- カレンダーライブラリのデリゲート

extension UserHomeController: FSCalendarDelegate, FSCalendarDataSource {

    // カレンダーのタップイベントを検知
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let plusDate = date.adding(.day, value: 1)

        // タップされた日付から1日足した日にちの期間で求人があるか検索する
        db.tickets.whereField("startDate", isGreaterThan: date)
                  .whereField("startDate", isLessThan: plusDate).getDocuments { (snapshot, error) in
            if let error = error {
                print("カレンダーの日にちあったデータ取得　失敗！ error =>",error)
            }
            guard let snapshot = snapshot else {return}
                    
            self.ticketData = []
    
            for ticketDocument in snapshot.documents {
                
                
                if let newTicket = Ticket(document: ticketDocument) {
                    self.ticketData.append(newTicket)
                }
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! JobTableViewCell

        // タップしたセルよりセル内の画像と表示位置を取得する
        selectedImage = cell.shopImageView.image
        selectedFrame = view.convert(cell.shopImageView.frame, from: cell.shopImageView.superview)
        
        // 画面遷移時に遷移先のticketにticketdataを渡す
        let controller = DetailTicketController.fromStoryboard(forTicket: ticketData[indexPath.row])

        // 画面遷移を実行する際にUINavigationControllerDelegateの処理が実行される
        self.navigationController?.pushViewController(controller, animated: true)
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



