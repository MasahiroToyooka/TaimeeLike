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

class DetailTicketController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {

    
    // 遷移元でこれを呼び出す
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "DetailJob", bundle: nil), forTicket ticket: Ticket) -> DetailTicketController {
        
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailTicketController") as! DetailTicketController
        controller.ticket = ticket
        return controller
    }
    
    // 遷移せれるときにデータを受け取る用の変数
    private var ticket: Ticket!
    
    
    // お店についての画像
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.ticket.imageUrls?.count ?? 0
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            pagerView.delegate = self
            pagerView.dataSource = self
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return ticket.imageUrls?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string: ticket.imageUrls?[index] ?? ""), completed: nil)
        return cell
    }
}
