//
//  ContentView.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 2/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

let player = AudioSimplePlayer()

struct ContentView: View {
    @State var menuOpen: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
              VStack {



                    Text("Hello, Resplandecer!")
                }
                SideMenu(width: 270,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu)
                         
            }.navigationBarTitle("")
                //*************************Menu Icon******************************
                .navigationBarItems(leading:
                    Button(action:
                        {
                            self.openMenu()
                            print("menu button pressed!")
                            player.signalPlay(ID: "id1")
                        }, label: {
                            Image("barIcon")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image
                            .TemplateRenderingMode.original))
                            .resizable().frame(width:35, height:35)
                        }
                    )
                )
        }
    }
    func openMenu() {
        self.menuOpen.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
