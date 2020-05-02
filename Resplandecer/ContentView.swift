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
    
    @State var startAnimation = false
       
       @State private var outerArc: CGFloat = 80
       @State private var innerArc: CGFloat = 60
       @State private var triW: CGFloat = 20
       @State private var circleWidth: CGFloat = 10
       @State private var circleHeight: CGFloat = 10
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.72, green: 0.05, blue: 0.04, alpha: 1)

     }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    VStack(alignment: .center) {
                        BigRadioButton(beginAnimation:self.beginAnimation, outer: outerArc, inner: innerArc, triWidth: triW,
                                       circleWidth: 10 ,cicleHeight: 10).onTapGesture {
                                        globalPlayer.playLive()
                        }
                        
                        
                         
                        Spacer().frame(height: 70)
                        
                        Text("¿Quiénes Somos?").foregroundColor(Color.white)
                            .font(.headline)
                            .frame(width: 400, height: 30)
                            .background(Color(red: 0.72, green: 0.05, blue: 0.04))
                            .shadow(radius: 25)
                            .cornerRadius(5)
                        
                        Text("¡Bienvenido a Radio Resplandecer! Gracias por visitarnos. Somos una estacion al servicio de la comunidad con programas educativos enfocados en creencias y enseñansas biblicas. Nuestra meta es proveer informaciones fundamentales para el crecimiento espiritual del Pueblo de Dios.").foregroundColor(Color.white)
                            .padding()
                            .frame(width: 400, height: 230)
                            .background(Color(red: 0.72, green: 0.05, blue: 0.04))
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
                                .background(Color(red: 0.72, green: 0.05, blue: 0.04))
                                .shadow(radius: 25)
                        })
                        
                        Spacer().frame(width: 10)
                        
                        Button(action: {
                            
                        }, label: {
                            Text("¡Localizanos!").foregroundColor(Color.white)
                                .font(.headline)
                                .frame(width: 150, height: 30)
                                .background(Color(red: 0.72, green: 0.05, blue: 0.04))
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
    func beginAnimation() {
        self.startAnimation.toggle()
        print("after call being animation")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

