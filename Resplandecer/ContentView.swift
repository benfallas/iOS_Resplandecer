//
//  ContentView.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 2/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

enum ActiveAlert {
    case first, second
}

struct ContentView: View {
    @State var menuOpen: Bool = false
    @State private var didTap:Bool = false
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .first
    @State var startAnimation = false
    
    @State private var outerArc: CGFloat = 80
    @State private var innerArc: CGFloat = 60
    @State private var triW: CGFloat = 20
    @State private var circleWidth: CGFloat = 10
    @State private var circleHeight: CGFloat = 10
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.72, green: 0.05, blue: 0.04, alpha: 1)
        UITableView.appearance().backgroundColor = UIColor.init(red: 0.929, green: 0.933, blue: 0.788, alpha: 1)

    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(red: 0.929, green: 0.933, blue: 0.788)

                VStack{
                    VStack(alignment: .center) {
                        //                        Button(action: {
                        //                            if self.didTap == false{
                        //                                self.didTap = true
                        //                                globalPlayer.signalPlayString(urlString: "http://radioresplandecer.com/radio-24/7")
                        //                            } else{
                        //                                self.didTap = false
                        //                                globalPlayer.stop()
                        //                            }
                        //                            print(self.didTap)
                        //                        } ) {
                        //                            if self.didTap == true {
                        //                                Image(systemName: "pause.fill").frame(width: 120, height: 120)
                        //                            }
                        //                            else{
                        //                                Image(systemName: "play.fill").frame(width: 120, height: 120)
                        //                            }
                        BigRadioButton(beginAnimation:self.beginAnimation, outer: outerArc, inner: innerArc, triWidth: triW,
                                       circleWidth: 10 ,cicleHeight: 10)
                        
                        
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
                    HStack {
                        Button("¡Contáctanos!") {
                            self.showAlert = true
                            self.activeAlert = .first
                            print("Contact us!")
                        }.foregroundColor(Color.white)
                        .font(.headline)
                        .frame(width: 150, height: 30)
                        .background(Color(red: 0.72, green: 0.05, blue: 0.04))
                        .shadow(radius: 25)

                        
                        Button("¡Localizanos!") {
                            self.showAlert = true
                            self.activeAlert = .second
                            print("Locate us!")
                        }.foregroundColor(Color.white)
                            .font(.headline)
                            .frame(width: 150, height: 30)
                            .background(Color(red: 0.72, green: 0.05, blue: 0.04))
                            .shadow(radius: 25)
                    }.alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .first:
                            return Alert(title: Text("¿PREGUNTAS?"), message: Text("Mandenos su pregunta o comentario via correo electrónico gmail: radioresplandecer93930@gmail.com. Estamos a su dispocision."))
                        case .second:
                            return Alert(title: Text("Para Mas Informacion"), message: Text("Iglesia De Jesucristo\n116 S. 3rd St.\nKing City, CA 93930\nTel. 831 386-9112"))
                        }
                    }
                }//vstack
                
                
                
                SideMenu(width: 270,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu)
                
            }.navigationBarTitle("", displayMode: .inline).navigationBarItems(leading: Button(action: {
                    self.openMenu();
                    print("menu icon cliced!")
                }, label: {
                    Image("redMenu").resizable().frame(width:40, height:40)
            }))
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

