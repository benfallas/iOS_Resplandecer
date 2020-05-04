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

class Queue{
    var currentPlayListIndex: Int
    var list: [Record]
    var currnetPlayListSize: Int
    var startingPointIndex: Int
    
    //    private var totalSize: Int = totalRecs.allPlaylist[backgroundQ.currentPlayListIndex].recordings.count
    
    init(){
        self.currentPlayListIndex = -1
        self.list = []
        self.currnetPlayListSize = 0
        self.startingPointIndex = -1
        //        self.totalSize = 0
    }
    init(index: Int){
        self.currentPlayListIndex = index
        self.list = totalRecs.allPlaylist[index].recordings
        self.currnetPlayListSize = totalRecs.allPlaylist[index].recordings.count
        self.startingPointIndex = -1
        //        self.totalSize = list.count
    }
    
    // setters and getters
    //when someone presses button
    func updatePlayListIndex(index: Int){
        print("Hello World")
        if(self.currentPlayListIndex != index){
            self.currentPlayListIndex = index
            self.currnetPlayListSize = totalRecs.allPlaylist[self.currentPlayListIndex].recordings.count
        }
        dump(self.currentPlayListIndex)
    }
    
    func updateStartingPointIndex(tappedIndex: Int){
        if(self.startingPointIndex != tappedIndex){
            self.startingPointIndex = tappedIndex
        }
    }
    
}

var backgroundQ = Queue()
let totalRecs = allRecords()
var currentPlayListIndex = -1

struct MenuContent: View {
    @State var tempIsTapped: Bool = false
    @State var tempTappedID: Int = -1
    @State var isPlayList_0_Presented = false
    @State var isPlayList_1_Presented = false
    @State var isPlayList_2_Presented = false
    @State var isPlayList_3_Presented = false
    
    //    init() {
    //        self.getRecordList()
    //    }
    let listOfPlayList = [
        RecordList( recList: 0),
        RecordList( recList: 1),
        RecordList( recList: 2),
        RecordList( recList: 3)
    ]
    
    var body: some View {
        List {
            NavigationLink(destination: listOfPlayList[0], isActive: $isPlayList_0_Presented) {
                Text("DeclaracionAlDia")
            }.onTapGesture {
                currentPlayListIndex = 0
                self.isPlayList_0_Presented = true
                self.isPlayList_1_Presented = false
                self.isPlayList_2_Presented = false
                self.isPlayList_3_Presented = false
            }
            NavigationLink(destination: listOfPlayList[1], isActive: $isPlayList_1_Presented) {
                Text("Himnos Del Pastor Valverde Sr")
            }.onTapGesture {
                currentPlayListIndex = 1
                self.isPlayList_0_Presented = false
                self.isPlayList_1_Presented = true
                self.isPlayList_2_Presented = false
                self.isPlayList_3_Presented = false
            }
            NavigationLink(destination: listOfPlayList[2], isActive: $isPlayList_2_Presented) {
                Text("La Voz Del Evangelio Eterno (Bilingue)")
            }.onTapGesture {
                currentPlayListIndex = 2
                self.isPlayList_0_Presented = false
                self.isPlayList_1_Presented = false
                self.isPlayList_2_Presented = true
                self.isPlayList_3_Presented = false
            }
            NavigationLink(destination: listOfPlayList[3], isActive: $isPlayList_3_Presented) {
                Text("Voz Que Clama En El Desierto")
            }.onTapGesture {
                currentPlayListIndex = 3
                self.isPlayList_0_Presented = false
                self.isPlayList_1_Presented = false
                self.isPlayList_2_Presented = false
                self.isPlayList_3_Presented = true
            }
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
