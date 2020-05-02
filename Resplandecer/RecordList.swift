//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//
import SwiftUI

struct RecordList: View {
     var recList:Int = 0

    var body: some View {
        
        ZStack {
                VStack {
                               List(totalRecs.allPlaylist[recList].recordings) { r in
                                   Record(id:r.id, title: r.title, author: r.author, radioURL: r.radioURL)
                                   }
                           }
            
           
            
        }.navigationBarTitle(LocalizedStringKey(totalRecs.allPlaylist[recList].name), displayMode: .inline)
    }
}


