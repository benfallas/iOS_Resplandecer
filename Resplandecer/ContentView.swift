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
    
    init() {
         UINavigationBar.appearance().backgroundColor = UIColor.red
     }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
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
                        
                        Spacer().frame(height: 70)
                        
                        Text("¿Quiénes Somos?").foregroundColor(Color.white)
                            .font(.headline)
                            .frame(width: 400, height: 30)
                            .background(Color.red)
                            .shadow(radius: 25)
                            .cornerRadius(5)
                        
                        Text("¡Bienvenido a Radio Resplandecer! Gracias por visitarnos. Somos una estacion al servicio de la comunidad con programas educativos enfocados en creencias y enseñansas biblicas. Nuestra meta es proveer informaciones fundamentales para el crecimiento espiritual del Pueblo de Dios.").foregroundColor(Color.white)
                            .padding()
                            .frame(width: 400, height: 230)
                            .background(Color.red)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .shadow(radius: 25)
                            .cornerRadius(5)
                        
                        Spacer().frame(height: 30)
                        
                        
                    }//vstack center
                    HStack{
                        Button(action: {
                            print("Conctact us clicked!")
                        }, label: {
                            Text("¡Contáctanos!").foregroundColor(Color.white)
                                .font(.headline)
                                .frame(width: 150, height: 30)
                                .background(Color.red)
                                .shadow(radius: 25)
                        })
                        
                        Spacer().frame(width: 10)
                        
                        Button(action: {
                            
                        }, label: {
                            Text("¡Localizanos!").foregroundColor(Color.white)
                                .font(.headline)
                                .frame(width: 150, height: 30)
                                .background(Color.red)
                                .shadow(radius: 25)
                                .cornerRadius(5)
                        })
                    }//hstack
                }//vstack
                
                
                
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
                        Image("redMenu")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image
                                .TemplateRenderingMode.original))
                            .resizable().frame(width:35, height:35).position(x: 10, y: 20)
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
