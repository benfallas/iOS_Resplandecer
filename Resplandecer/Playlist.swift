//
//  Playlist.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 2/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

struct Playlist: View, Identifiable{
    var id = UUID()

    var name:String = ""
    var recordings:[Record] = []
    
    var body: some View {
        Text("Hello, World!")
    }
    
    mutating func setName(updatedName: String){
        self.name = updatedName
    }
    
    mutating func addRecord(newRecord: Record){
        self.recordings.append(newRecord)
    }
    func getName() -> String{
        return self.name
    }
    
    func getRecordings() -> [Record]{
         return self.recordings
     }
    init(name:String, recordings:[Record]) {
        
        self.name = name
        self.recordings = recordings
    }
}

struct Playlist_Previews: PreviewProvider {
    static var previews: some View {
        Playlist(name: "String", recordings: [Record()])
    }
}
