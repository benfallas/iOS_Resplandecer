//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

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
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordList()
    }
}
