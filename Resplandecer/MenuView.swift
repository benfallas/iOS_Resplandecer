//
//  MenuView.swift
//
//  Created by Elizabeth Hernandez on 11/12/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//
//

import SwiftUI

class allRecords {
    var allPlaylist:[Playlist] = []
}
//class queue {
//    var name: String
//    var records: [Record]
//    setters and getters
//}
//let currentQ = queue()



//when someone presses button
//func(namePlaylist: String, startingPoint: Int)
// if(currentQ.name == namePlaylistt)
// scoot everything
// else
// currentQ.name = namePlaulist
// currentQ.records.removeAll
//currentQ.records = totalRecs.allPlaylist.
let totalRecs = allRecords()

struct MenuContent: View {
    
    init() {
        self.getRecordList()
//        for(i in totalRecs.allPlaylist){
//            i.name
//            currentQ.records = i.recordings
//        }
    }
    
    var body: some View {
        List {
         
            NavigationLink(destination: RecordList( recList: 0)) {
                Text("DeclaracionAlDia")
            }
                NavigationLink(destination: RecordList( recList: 1)) {
                    Text("Himnos Del Pastor Valverde Sr")
                }
                NavigationLink(destination: RecordList( recList: 2)) {
                    Text("La Voz Del Evangelio Eterno (Bilingue)")
                }
                NavigationLink(destination: RecordList( recList: 3)) {
                    Text("Voz Que Clama En El Desierto")
                }
        }
    }
    
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
                            let tempRecord =  Record(id: i, title: realValue["Titulo"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["Link"] as! String)
                            tempRec.append(tempRecord)
                        }else {
                            let tempRecord =  Record(id: i, title: realValue["TITULO"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["LINK"] as! String)
                            tempRec.append(tempRecord)

                        }
                    }
                    i += 1
                }
                totalRecs.allPlaylist.append(Playlist(id: playlistId, name: key as! String, recordings: tempRec))
                tempRec.removeAll()
                playlistId = playlistId + 1
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}


//put database function impleementation

//return the array

struct SideMenu: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
            
            HStack {
                MenuContent()
                    .frame(width: self.width)
                    .background(Color.white)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                
                Spacer()
            }
        }
    }
}

struct SideMenuView: View {
    @State var menuOpen: Bool = false
    
    var body: some View {
        ZStack {
            if !self.menuOpen {
                Button(action: {
                    self.openMenu()
                }, label: {
                    Text("Open")
                })
            }
            
            SideMenu(width: 270,
                     isOpen: self.menuOpen,
                     menuClose: self.openMenu)
        }
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
}




struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
