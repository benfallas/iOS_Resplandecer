//
//  ContentView.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 2/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var menuOpen: Bool = false
    @State private var didTap:Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {

                
                    Button(action: {
                        //when user interacts with the button, check background queue
                        // if the current array that user access differ from background queue
                        // then update the backgroudn q
                        
                        // For now, directly passing radio url string.
                        // However, it must be changed later to some sort of ID
                        // to take care of other use cases such as 1. stop 2. play next
                        //                globalPlayer.signalPlay(ID: self.id)
                        
                        
                        if self.didTap == false{
                            self.didTap = true
//                            globalPlayer.signalPlay(ID: self.radioURL)
                        } else{
                            self.didTap = false
//                            globalPlayer.stop()
                        }
                        print(self.didTap)
                    } ) {
                        if self.didTap == true {
                            Image(systemName: "pause.fill").frame(width: 120, height: 120)
                        }
                        else{
                            Image(systemName: "play.fill").frame(width: 120, height: 120)
                        }
                    }
                    .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .font(.largeTitle)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                
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
