//
//  Record.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

struct Record: View, Identifiable {
    
    @State var sliderValue = 0.0
    
    var id: Int
    var title: String
    var author: String
    var radioURL: String    
    @Binding var isTapped: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                //record title
                Text(title).foregroundColor(Color(red: 0.72, green: 0.05, blue: 0.04)).underline().bold()
                Spacer().frame(height:20)
                
                //record author
                Text(author).foregroundColor(Color(red: 0.72, green: 0.05, blue: 0.04))
                
                
            }.padding()
                .frame(width: 275, height: 50, alignment: .leading)
            
            Spacer().frame(width:40)
            
            ZStack{
                if((self.id == backgroundQ.startingPointIndex) && (currentPlayListIndex == backgroundQ.currentPlayListIndex)) {
                    Image(systemName: "pause.fill").frame(width: 40, height: 40)
                } else {
                    Image(systemName: "play.fill").frame(width: 40, height: 40)
                }
            } .padding()
                .foregroundColor(.white)
                .background(Color(red: 0.945, green: 0.317, blue: 0.337))
                .font(.largeTitle)
                .overlay( RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 4))
                .clipShape(Circle()).position(x:0, y:50)      
        
        }.frame(width: 375, height: 100, alignment: .center)
            .background(Color.init(red: 0.992, green: 0.858, blue: 0.709))
        
    }
}
