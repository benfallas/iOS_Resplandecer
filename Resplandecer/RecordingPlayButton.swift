//
//  RecordingPlayButton.swift
//  Resplandecer
//
//  Created by Maria del Carmen Hernandez on 4/5/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//
import SwiftUI
struct recordingPlayButton<PlayRecord: View>: View{
    let action: () -> Void
    let content: PlayRecord
    init(action: @escaping() -> Void, @ViewBuilder content: () -> PlayRecord){
        self.action = action
        self.content = content()
        var buttonStatus: Bool = false
    }
    var body: some View{
        Button(action: action) {
            content
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .font(.largeTitle)
            .clipShape(Circle())
                .overlay( RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 2))
        }
    }
}
