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
var user: User?
var userID = Auth.auth().currentUser?.uid

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        // 初期化
        super.init()
        FirebaseApp.configure()
    }
    
    
    var userListener: ListenerRegistration?
    
    func startListeningForUser() {
        // チケットの状態が０のやつ(企業が投稿して申し込みがされていない状態)のだけ取得
        let basicQuery = db.users.whereField("userID", isEqualTo: userID)
        
        userListener = basicQuery.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                print("ホームビューコントローラーにてチケットのデータ取得失敗: ", error)
                return
            }
            guard let document = snapshot?.documents.first else {
                print("appdelegateのguard文でk弾かれています", snapshot)
                return
            }
           
            user = User(document: document)
        })
    }
    
    private func stopListeningForUser() {
        userListener?.remove()
        userListener = nil
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startListeningForUser()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        stopListeningForUser()
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

