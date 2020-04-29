//
//  MenuView.swift
//
//  Created by Elizabeth Hernandez on 11/12/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//
//

import SwiftUI
class displayArray: ObservableObject {
    //background queue: Player directly refer to this list to automatically start next song in the array
    @Published var queue:[Record] = []
    //current array: keeps track of the currently opend playlist
    @Published var currArray:[Record] = []
    @Published var bigAray:[[Record]] = [[],[],[],[]]
}
struct MenuContent: View {
    @ObservedObject var list = displayArray()
    init() {
        self.getRecordList()
    }
    var body: some View {
        List {
            NavigationLink(destination: RecordList( recList: self.$list.bigAray[0])) {
                Text("DeclaracionAlDia")
            }
            NavigationLink(destination: RecordList( recList: self.$list.bigAray[1])) {
                Text("Himnos Del Pastor Valverde Sr")
            }
            NavigationLink(destination: RecordList( recList: self.$list.bigAray[2])) {
                Text("La Voz Del Evangelio Eterno (Bilingue)")
            }
            NavigationLink(destination: RecordList( recList: self.$list.bigAray[3])) {
                Text("Voz Que Clama En El Desierto")
            }
        }
    }
    
    func getRecordList() {
        db.child("13APXRHCpHma6fFJgci5iSCfzh-1uBP5HwzKbuZ-utH8").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get Database values
            var i = 0
            let value = snapshot.value as? NSDictionary
            for(key, _) in (value)! {
                self.list.bigAray.remove(at: 0)
                print(key)
                let del = value?[key] as? NSDictionary ?? nil
                for (_, innerVal) in del ?? NSDictionary() {
                    let realValue = innerVal as! NSDictionary
                    if (realValue).count != 0 {
                        if(key as! String == "DeclaracionAlDia") {
                            let tempRecord =  Record(id: i, title: realValue["Titulo"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["Link"] as! String)
                            self.list.currArray.append(tempRecord)
                        }else {
                            let tempRecord =  Record(id: i, title: realValue["TITULO"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["LINK"] as! String)
                            self.list.currArray.append(tempRecord)
                        }
                    }
                    i += 1
                }
                self.list.bigAray.append(self.list.currArray)
                self.list.currArray.removeAll()
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
