//
//  DetailJobController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/19.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import SDWebImage
import FSPagerView
import FirebaseAuth

class DetailTicketController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {

    
    // 遷移元でこれを呼び出す
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "DetailJob", bundle: nil), forTicket ticket: Ticket) -> DetailTicketController {
        
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailTicketController") as! DetailTicketController
        controller.ticketData = ticket
        return controller
    }
    
    // 仕事のタイトル内容
    @IBOutlet weak var textLabel: UILabel!
    // 仕事の日付を書くラベル
    @IBOutlet weak var dateLabel: UILabel!
    // 仕事の詳細をかくラベル
    @IBOutlet weak var detailText: UILabel!
    
    // 仕事の注意事項を乗せるラベル
    @IBOutlet weak var attentionLabel: UILabel!
    
    // 下のボタンとかラベルがまとめてあるView
    @IBOutlet weak var bottomContantView: UIView!
    
    // チケットの値段がl書かれているラベル
    @IBOutlet weak var bottomPriceLabel: UILabel!
    // 日付を乗せるラベル
    @IBOutlet weak var bottomDateLabel: UILabel!
    
    // 遷移せれるときにデータを受け取る用の変数
    private var ticketData: Ticket!
    
    // お店についての画像
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = CGSize(width: 370 , height: 180)
            self.pagerView.interitemSpacing = 10
        }
    }
    
    // pagerviewが何番目かを表示するやつ
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.ticketData.imageUrls?.count ?? 0
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.delegate = self
        pagerView.dataSource = self
        
        setupData()
        
        // 下のbottomContantViewに影をつけている
        bottomContantView.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomContantView.layer.shadowColor = UIColor.black.cgColor
        // 濃さ
        bottomContantView.layer.shadowOpacity = 0.4
        // ぼかし
        bottomContantView.layer.shadowRadius = 10
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return ticketData.imageUrls?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string: ticketData.imageUrls?[index] ?? ""), completed: nil)
        return cell
    }
    
    // 受け取ったチケットのデータからコンポーネントに反映させる処理
    func setupData() {
        navigationItem.title = ticketData.shopInfo["shopName"] as? String
        textLabel.text = ticketData.text
        detailText.text = ticketData.detailText
        attentionLabel.text = ticketData.attentionText
        
        // Date型から各々好みのフォーマットに変える
        let startFormatter = DateFormatter()
        startFormatter.dateFormat = "yyyy年M月dd日 HH:mm"
        let startDate: String = startFormatter.string(from: ticketData.startDate)
        
        let endFormatter = DateFormatter()
        endFormatter.dateFormat = "HH:mm"
        let endTime: String = endFormatter.string(from: ticketData!.endDate)
        
    
        // 2019年8月31日　18:00 ~ 22:00みたいにしている
        dateLabel.text = "\(startDate) 〜 \(endTime)"
        bottomDateLabel.text = "\(startDate) 〜 \(endTime)"
        
        guard let price = ticketData?.price else { return }
        bottomPriceLabel.text = "\(price)円券"

    }
    
    // チケットの状態を0から１に変える
    func updateTicketState() {
        db.tickets.document(ticketData.documentID).updateData([
            "ticketState": 1
            ])
    }
    

    @IBAction func applyButton(_ sender: UIButton) {
        
        updateTicketState()
        
        guard var user = user else {
            print("userデータ取得失敗")
            return
        }
        // userの所有チケットに変更を加える
        user.allTicket.append(ticketData.documentID)
        
        // userデータの更新
        db.users.document(userID!).updateData([
            "allTicket": user.allTicket
        ])

        self.navigationController?.popViewController(animated: true)
    }

}
