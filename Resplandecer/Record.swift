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
    @State private var didTap:Bool = false
    
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
            
            Button(action: {
                //when user interacts with the button, check background queue
                // if the current array that user access differ from background queue
                // then update the backgroudn q
                
                // For now, directly passing radio url string.
                // However, it must be changed later to some sort of ID
                // to take care of other use cases such as 1. stop 2. play next
                //                globalPlayer.signalPlay(ID: self.id)
                
                
                if self.didTap == false{
                    self.didTap = true
                    globalPlayer.signalPlay(ID: self.radioURL)
                } else{
                    self.didTap = false
                    globalPlayer.stop()
                }
                print(self.didTap)
            } ) {
                if self.didTap == true {
                    Image(systemName: "pause.fill").frame(width: 40, height: 40)
                }
                else{
                    Image(systemName: "play.fill").frame(width: 40, height: 40)
                }
            }.padding()
                .foregroundColor(.white)
                .background(Color.red)
                .font(.largeTitle)
                .overlay( RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 4))
                .clipShape(Circle()).position(x:0, y:50)
            
        }.frame(width: 375, height: 100, alignment: .center)
            .background(Color.black.opacity(0.8))
        
    }
}

struct Record_Previews: PreviewProvider {
    static var previews: some View {
        Record(id: 0, title:"Apreciar la Palabra de Dios", author:"Pastor Arturo Rios", radioURL:"")
        //            .previewLayout(.fixed(width:450, height:100))
        
    }
}
