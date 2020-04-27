//
//  Record.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

struct Record: View, Identifiable {
    var id: UUID
    var idInt: Int
    var title: String
    var author: String
    var radioURL: String
    var playImage: Image
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                //record title
                Text(title).foregroundColor(Color.white).underline().bold()
                Spacer().frame(height:20)
                
                //record author
                Text(author).foregroundColor(Color.white).underline()
            }.padding()
                .frame(width: 275, height: 50, alignment: .leading)
            
            Spacer().frame(width:40)
            
            HStack {
            //record Image
              Image("redplay")
                .resizable().frame(width: 50, height: 50)
            }.frame(width: 50, height: 50).position(x:0, y:50)
            
        }.frame(width: 375, height: 100, alignment: .center)
            .background(Color.black.opacity(0.8))

    }
}

struct Record_Previews: PreviewProvider {
    static var previews: some View {
        Record(id: UUID(), title:"Apreciar la Palabra de Dios", author:"Pastor Arturo Rios", radioURL:"", playImage: Image("play"))
//            .previewLayout(.fixed(width:450, height:100))
        
    }
}
