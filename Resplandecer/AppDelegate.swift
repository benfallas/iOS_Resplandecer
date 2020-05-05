//
//  AppDelegate.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 2/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI
import UIKit
import Firebase

struct listLoadObj {
    @State var tempIsTapped: Bool = false
    let db =  Database.database().reference();

func getRecordList() {
    db.child("13APXRHCpHma6fFJgci5iSCfzh-1uBP5HwzKbuZ-utH8").observeSingleEvent(of: .value, with: { (snapshot) in
        // Get Database values
        var i = 0
        var playlistId = 0
        var tempRec:[Record] = []
        let value = snapshot.value as? NSDictionary
        for(key, _) in (value)! {
            print(key)
            let del = value?[key] as? NSDictionary ?? nil
            for (_, innerVal) in del ?? NSDictionary() {
                let realValue = innerVal as! NSDictionary
                if (realValue).count != 0 {
                    if(key as! String == "DeclaracionAlDia") {
                        let tempRecord =  Record(id: i, title: realValue["Titulo"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["Link"] as! String, isTapped: self.$tempIsTapped)
                        tempRec.append(tempRecord)
                    }else {
                        let tempRecord =  Record(id: i, title: realValue["TITULO"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["LINK"] as! String, isTapped: self.$tempIsTapped)
                        tempRec.append(tempRecord)
                        
                    }
                }
                i += 1
            }
            i = 0
            totalRecs.allPlaylist.append(Playlist(id: playlistId, name: key as! String, recordings: tempRec))
            tempRec.removeAll()
            playlistId = playlistId + 1
        }
    }) { (error) in
        print(error.localizedDescription)
    }
}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        listLoadObj().getRecordList()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

