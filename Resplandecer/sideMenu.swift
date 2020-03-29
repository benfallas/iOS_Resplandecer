//
//  sideMenu.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/12/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//
//
import SwiftUI

struct MenuContent: View {
    var body: some View {
        List {
            Text("Leaderboard")
            Text("Leaderboard")
            Text("Leaderboard")
            Text("Leaderboard")
            
//            NavigationLink(destination: leaderboard())
//            {
//                Text("Leaderboard")
//            }
//            NavigationLink(destination: userStats())
//            {
//                Text("User Stats")
//            }
//            NavigationLink(destination: createGroup())
//            {
//                Text("Create Group")
//            }
//            NavigationLink(destination: settings())
//            {
//                Text("Settings")
//            }
        }
    }
}

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

struct sideMenu: View {
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




struct sideMenu_Previews: PreviewProvider {
    static var previews: some View {
        sideMenu()
    }
}
