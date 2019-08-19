//
//  HomeViewController.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/18.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // 日付とかのまとめて貼ってあるビュー
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var shopImageView: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // カレンダー用のコレクションビュー
    @IBOutlet weak var calendarCollection: UICollectionView!
    
    // 日付のらラベル
    @IBOutlet weak var dateLabel: UILabel!
    
    // 過去にスクロールdされた合計のオフセット
    var pastDistance: CGFloat = 0
    
    // 画面遷移の進み具合に関する情報を保持するクラス
    private var detailInteractor: DetailInteractor?
    
    
    // カスタムトランジション側のクラスに引き渡す画像の情報とセルの位置情報
    private var selectedFrame: CGRect?
    private var selectedImage: UIImage?
//    let now = Date()
//    var cal = Calendar.current
//    let dateFormatter = DateFormatter()
//    var components = DateComponents()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bounces = false
        
        calendarCollection.delegate = self
        calendarCollection.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
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
        print(distanceDif)
        
        pastDistance =  scrollView.contentOffset.y
    }
    
    
    
    @IBAction func showProfile(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Profile", bundle: nil)
        
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        
        navigationController?.pushViewController(vc, animated: false)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .yellow
        return cell
    }
    
    
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath)

        // タップしたセルよりセル内の画像と表示位置を取得する
        selectedImage = shopImageView.image
        selectedFrame = view.convert(shopImageView.frame, from: shopImageView.superview)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}







// MARK: - UINavigationControllerDelegate

extension HomeViewController: UINavigationControllerDelegate {
    
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



