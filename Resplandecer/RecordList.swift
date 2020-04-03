//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI
import Firebase

struct RecordList: View {
    
    @State var recList = [
        Record(id: UUID(), title: String("A Solas Con el Maestro"), author: "Pastor Arturo Rios", radioURL: "link1", playImage: Image("redplay")),
        Record(id: UUID(), title: "Apreciar la Palabra de Dios", author: "Pastor Arturo Rios", radioURL: "link2", playImage: Image("redplay")),
        Record(id: UUID(), title: "Apreciemos al hombre de Dios", author: "Pastor Arturo Rios", radioURL: "link2", playImage: Image("redplay"))
    ]
    
    var body: some View {
        ZStack {
            VStack {
                List(recList) { r in
                    Record(id:r.id, title: r.title, author: r.author, radioURL: r.radioURL, playImage: r.playImage)
                    
                }
            }
            
        }
    }
    
//    func getRecordList(playlist: String) {
//        var ref: DatabaseReference!
//        var recordList: [String: AnyObject]
//
//        ref.child("DeclaracionAlDia").observe(DataEventType.value, with: { (SnapshotMetadata) in
//            recordList = SnapshotMetadata.value as! [String : AnyObject]
//        })
//
//        print(recordList)
//    }
    
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordList()
    }
}
