//
//  Record.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import SwiftUI

struct Record: View, Identifiable {
    var id: Int
    var title: String
    var author: String
    var radioURL: String    
    @Binding var isPlaying: Bool
    @Binding var currentPlayingID: Int
    
    func printVals(){
        print(currentPlayingID)
        print(self.id)
        print(isPlaying)
    }
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
            
            ZStack{
                if((self.id == currentPlayingID) && isPlaying) {
                    Image(systemName: "pause.fill").frame(width: 40, height: 40)
                } else {
                    Image(systemName: "play.fill").frame(width: 40, height: 40)
                }
            } .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .font(.largeTitle)
                .overlay( RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 4))
                .clipShape(Circle()).position(x:0, y:50)
            .onTapGesture {
               
                    self.printVals()
            }
            
//            PlayesrSlider()
            
        }.frame(width: 375, height: 100, alignment: .center)
            .background(Color.black.opacity(0.8))
        
    }
}
