//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//
import SwiftUI
struct RecordList: View {

    @Binding var recList: [Record]

    var body: some View {
        ZStack {
            VStack {
                
                List(recList) { r in
//                    Playlist(id: UUID(), name: "hw", recordings: [Record()])
                    Record(id:r.id, title: r.title, author: r.author, radioURL: r.radioURL, playImage: r.playImage)
                }
            }
        }
    }

}


