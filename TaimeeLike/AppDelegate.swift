//
//  AppDelegate.swift
//  TaimeeLike
//
//  Created by 豊岡正紘 on 2019/08/16.
//  Copyright © 2019 Masahiro Toyooka. All rights reserved.
//

import UIKit
import Firebase


let db = Firestore.firestore()

var userID = Auth.auth().currentUser?.uid

/// ログインしているのユーザーのデータを入れるやつ
var user: User?

/// ログインしているショップのデータを入れるやつ
var shop: Shop?


/// UserのallTicketのチケット
var userTicket = [Ticket]()

/// 申し込みしたチケット
var reservationTicket = [Ticket]()

/// 仕事をして使えるようになったチケット
var haveTicket = [Ticket]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        // 初期化
        super.init()
        FirebaseApp.configure()
    }
    
    // Userデータを監視するやつ
    var userListener: ListenerRegistration?
    
    // Shopのデータを監視するやつ
    var shopLisner: ListenerRegistration?
    
    // ユーザーのデータを監視する
    func startListeningForUser() {
        
        guard let userID = userID else {
            print("appdetegateにてuid取得失敗")
            return
        }
        
        let basicQuery = db.users.document(userID)
        
        userListener = basicQuery.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("ホームビューコントローラーにてチケットのデータ取得失敗: ", error)
                return
            }
            guard let document = snapshot else {
                print("appdelegateのguard文で弾かれています", snapshot)
                return
            }
           
            // 取得したデータをuserに格納
            user = User(document: document)
            print("appdetegateにてuserのdocumentID: ",user?.documentID)
            
            self.fetchUserTicket()
        })
    }
    
    // allTicketに入っているdocumentIDと同じIDのTicketを取得
    func fetchUserTicket() {
        guard let allTicket = user?.allTicket else {
            print("AllTicketのデータがありません")
            return
        }
        
        userTicket = []
        
        for i in 0..<allTicket.count {
            
            db.tickets.document(allTicket[i]).getDocument { (snapshot, error) in
                
                if let error = error {
                    print("allTicketのデータ取得失敗: ",error)
                    return
                }
                
                guard let document = snapshot else { return }
                
                if let newTicket = Ticket(document: document) {
                    
                    // とってきたTicketデータをuserTicketに格納する
                    userTicket.append(newTicket)
                    
                    print("userTicketの数: ",userTicket.count)
                }
                if i == 0 {
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
    
    // データを監視するのをやめる
    private func listeningStop() {
        userListener?.remove()
        userListener = nil
        shopLisner?.remove()
        shopLisner = nil
    }
    
    
    // shopのデータの変更を監視する
    func startListeningForShop() {
        
        guard let userID = userID else {
            print("appdetegateにてuid取得失敗")
            return
        }
        
        
        let basicQuery = db.shops.document(userID)
        
        shopLisner = basicQuery.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("ホームビューコントローラーにてチケットのデータ取得失敗: ", error)
                return
            }
            guard let document = snapshot else {
                print("appdelegateのguard文で弾かれています", snapshot)
                return
            }
            
            
            shop = Shop(document: document)
            print("appdetegateにてshopのdocumentID: ",shop?.documentID)
        })
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startListeningForUser()
        startListeningForShop()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        listeningStop()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

