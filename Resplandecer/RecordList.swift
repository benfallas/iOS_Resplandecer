//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

struct RecordList: View {
    
    let currentPlaylistName: String// menuView
    
//    @State var recList = [
//        Record(id: UUID(), title: String("A Solas Con el Maestro"), author: "Pastor Arturo Rios", radioURL: "link1", playImage: Image("redplay")),
//        Record(id: UUID(), title: "Apreciar la Palabra de Dios", author: "Pastor Arturo Rios", radioURL: "link2", playImage: Image("redplay")),
//        Record(id: UUID(), title: "Apreciemos al hombre de Dios", author: "Pastor Arturo Rios", radioURL: "link2", playImage: Image("redplay"))
//    ]
    
    @State var recList = [Record]() // CHANGE TO -> observable object!!!!!!!
    
    init(currentPlaylistName: String) {
        self.currentPlaylistName = currentPlaylistName
        
//        getRecordList()
        
    }
    
    var body: some View {
        ZStack {
            VStack {
                List(recList) { r in
                    Record(id:r.id, title: r.title, author: r.author, radioURL: r.radioURL, playImage: r.playImage)
                    
                }
            }
        }
    }
    
    func getRecordList() {
        var tempList = [Record]()

//        var tempList: [Record] = []
        
        db.child("13APXRHCpHma6fFJgci5iSCfzh-1uBP5HwzKbuZ-utH8").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get Database values
            let value = snapshot.value as? NSDictionary
            
            let del = value?[self.currentPlaylistName] as? NSDictionary ?? nil
            
            //traverse through the playlist and print the children.
            for (key, val) in del ?? NSDictionary() {
                let realV = val as! NSDictionary
                
                //                print("Print REALV:", realV)
                
                if (realV).count != 0 {
                    if(self.currentPlaylistName == "DeclaracionAlDia") {
                        
                        let tempRecord =  Record(id: UUID(), title: realV["Titulo"] as! String, author: realV["AUTOR"] as! String, radioURL: realV["Link"] as! String, playImage: Image("redplay"))
                        
//                        print("    $   Temp record:", tempRecord)
                        
                        tempList.append(
                            //                            Record(id: UUID(), title: realV["Titulo"] as! String, author: realV["AUTOR"] as! String, radioURL: realV["Link"] as! String, playImage: Image("redplay"))
                            tempRecord
                        )
                        
                        
                    }else {
                        
                        let tempRecord =  Record(id: UUID(), title: realV["TITULO"] as! String, author: realV["AUTOR"] as! String, radioURL: realV["LINK"] as! String, playImage: Image("redplay"))
                        
                        
                        tempList.append(
                            //                            Record(id: UUID(), title: realV["TITULO"] as! String, author: realV["AUTOR"] as! String, radioURL: realV["LINK"] as! String, playImage: Image("redplay"))
                            tempRecord
                        )
                    }
                }
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        self.recList = tempList
        
        print("\n\n\n\n\n\n\n\n ##@@@@@## PRINT RECLIST:", recList)
        
        print("\n\n\n\n\n\n\n\n ##@@@@@## PRINT TEMPLIST:", tempList)
        
        
    }
    
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordList(currentPlaylistName: "")
    }
}
