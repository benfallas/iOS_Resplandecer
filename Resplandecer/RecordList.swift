//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//
import SwiftUI

final class RecordListViewModel : ObservableObject {
    
    var recList: Int
    @Published var tappedID: Int = -1
    
    init(){
        recList = 0
        _tappedID = .init(initialValue: -1)
    }
    
    init(recList: Int){
        self.recList = recList
        _tappedID = .init(initialValue: -1)
    }
    
    public func setTappedID(id: Int){
        tappedID = id
    }
    
}

struct RecordList: View {
    @State var didTap: Bool = false
    @ObservedObject var model: RecordListViewModel
    
    var body: some View {
        ZStack {
            VStack {
                List(totalRecs.allPlaylist[model.recList].recordings) { r in
                    Record(id:r.id, title: r.title, author: r.author, radioURL: r.radioURL, isTapped: self.$didTap)
                        .onTapGesture {
                            // When user interacts by clicking, update background queue
                            // if the current play list that user access differs from background queue,
                            // then update the background q
                            
                            self.model.setTappedID(id: r.id)
                            
                            if(self.didTap == false){
                                self.didTap = true
                                
                                backgroundQ.updatePlayListIndex(index: currentPlayListIndex)
                                backgroundQ.updateStartingPointIndex(tappedIndex: self.model.tappedID)
                                self.model.tappedID = backgroundQ.startingPointIndex
                                
                                //Signal player to play
                                globalPlayer.signalPlay(ID: self.model.tappedID)
                                
                            } else {
                                self.didTap = false
                                
                                backgroundQ.updateStartingPointIndex(tappedIndex: -1)
                                
                                //Signal player to stop
                                globalPlayer.stop()
                            }
                    }
                }
            }// VStack
        }.navigationBarTitle(LocalizedStringKey(totalRecs.allPlaylist[model.recList].name), displayMode: .inline)
        // ZStack
    }
}
