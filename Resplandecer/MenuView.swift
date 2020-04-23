//
//  MenuContent.swift
//  myPart
//
//  Created by Elizabeth Hernandez on 11/12/19.
//  Copyright © 2019 Elizabeth Hernandez. All rights reserved.
//
//
import SwiftUI

class displayArray: ObservableObject {
    @Published var currArray:[Record] = []
//    @Published var name:String = "DeclaracionAlDia" //dynamically change this based on what nav is pressed
//    @Published var bigAray:[String:[Record]] = ["DeclaracionAlDia":[],
//                                                "Voz Que Clama En El Desierto": []]
    @Published var bigAray:[[Record]] = [[],[],[],[]]
    @Published var play:[Playlist] = []


}


struct MenuContent: View {
    @ObservedObject var list = displayArray()
//    @State var bigAray:[String:[Record]] = [:]
    var body: some View {

        List {
            
                   
//            Button(action: {
//                                                   self.getRecordList()
//                print(self.list.bigAray)
////                print(self.list.play)
//
//                                               }){
//                                                   Text("Next View")// trigger
//
//                                               }
            NavigationLink(destination: RecordList( recList: self.$list.bigAray[0])) {
                                   Text("DeclaracionAlDia")

            }.onAppear {
                self.getRecordList()

            }
          
            
//            Button(action: {
//                                                   self.getRecordList(name: "Himnos Del Pastor Valverde Sr")
//                                               }){
//                                                   Text("Next View2")// trigger
//
//            }
            NavigationLink(destination: RecordList( recList: self.$list.bigAray[1])) {
                                   Text("Himnos Del Pastor Valverde Sr")

//                 self.getRecordList(name: "Himnos Del Pastor Valverde Sr")

            }

//            Button(action: {
//                                                             self.getRecordList(name: "La Voz Del Evangelio Eterno (Bilingue)")
//                                                         }){
//                                                             Text("Next View3")// trigger
//
//                      }
                      NavigationLink(destination: RecordList( recList: self.$list.bigAray[2])) {
                                             Text("La Voz Del Evangelio Eterno (Bilingue)")


                                          }

//            Button(action: {
//                                                             self.getRecordList(name: "Voz Que Clama En El Desierto")
//                print(self.list.bigAray)
//
//                                                         }){
//                                                             Text("Next View4")// trigger
//
//            }
                      NavigationLink(destination: RecordList( recList: self.$list.bigAray[3])) {
                                             Text("Voz Que Clama En El Desierto")


                                          }
            

             }

    }
    
//    func getRecordList(name: String) {
//                    //        var tempList: [Record] = []
//        self.list.currArray.removeAll()
//                db.child("13APXRHCpHma6fFJgci5iSCfzh-1uBP5HwzKbuZ-utH8").observeSingleEvent(of: .value, with: { (snapshot) in
//                                // Get Database values
////                    self.list.play.append(Playlist(name: "ja", recordings: [Record()]))
//
//                                let value = snapshot.value as? NSDictionary
//                                let del = value?[name] as? NSDictionary ?? nil
//                                //traverse through the playlist and print the children.
//                                for (key, val) in del ?? NSDictionary() {
//                                    let realV = val as! NSDictionary
////                                                    print("Print REALV:", realV)
//                                    if (realV).count != 0 {
//                                        if(name == "DeclaracionAlDia") {
//                                            let tempRecord =  Record(id: UUID(), title: realV["Titulo"] as! String, author: realV["AUTOR"] as! String, radioURL: realV["Link"] as! String, playImage: Image("redplay"))
////                                            print(tempRecord)
//
//                                            self.list.bigAray[0].append(tempRecord)
//
//                                            self.list.currArray.append(tempRecord)
//                                        }else {
//                                            let tempRecord =  Record(id: UUID(), title: realV["TITULO"] as! String, author: realV["AUTOR"] as! String, radioURL: realV["LINK"] as! String, playImage: Image("redplay"))
////                                            self.list.bigAray[name]?.append(tempRecord)
////                                            self.list.bigAray[1].append(tempRecord)
//
//                                            self.list.currArray.append(tempRecord)
//                                        }
//                                    }
////
//                                }
//
//                    self.list.play.append(Playlist(name: name, recordings: self.list.currArray))
//
//
//                            }) { (error) in
//                                print(error.localizedDescription)
//                            }
////        print("\n\n\n\n\n\n\n\n ##@@@@@## PRINT RECLIST:", self.list.bigAray)
//
//                        }
//    }
         func getRecordList() {
            
                        db.child("13APXRHCpHma6fFJgci5iSCfzh-1uBP5HwzKbuZ-utH8").observeSingleEvent(of: .value, with: { (snapshot) in
                                        // Get Database values
                                        let value = snapshot.value as? NSDictionary
                            for(key, _) in (value)! {
                                self.list.bigAray.remove(at: 0)
                                print(key)
                                
                                let del = value?[key] as? NSDictionary ?? nil
                                    
                                for (_, innerVal) in del ?? NSDictionary() {
                                    let realValue = innerVal as! NSDictionary
        //                            print("Print REALV:", realValue)
                                    if (realValue).count != 0 {
                                        
                                        if(key as! String == "DeclaracionAlDia") {
                                            let tempRecord =  Record(id: UUID(), title: realValue["Titulo"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["Link"] as! String, playImage: Image("redplay"))
                                //                                            print(tempRecord)
                                                                                        self.list.currArray.append(tempRecord)
                                        }else {
                                            let tempRecord =  Record(id: UUID(), title: realValue["TITULO"] as! String, author: realValue["AUTOR"] as! String, radioURL: realValue["LINK"] as! String, playImage: Image("redplay"))
                                                                                        self.list.currArray.append(tempRecord)

                                          }
                                    }

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

