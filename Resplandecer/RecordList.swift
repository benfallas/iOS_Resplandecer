//
//  RecordList.swift
//  Resplandecer
//
//  Created by Elizabeth Hernandez on 3/15/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//
import SwiftUI

struct RecordList: View {
    var recList: Int = 0
    @State var didTap: Bool = false
    @State var tappedID: Int = -1
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List(totalRecs.allPlaylist[recList].recordings) { r in
                        Record(id:r.id, title: r.title, author: r.author, radioURL: r.radioURL, isPlaying: self.$didTap, currentPlayingID: self.$tappedID)
                            .onTapGesture {
                                //when user interacts with the button, check background queue
                                // if the current array that user access differ from background queue
                                // then update the backgroudn q
                                
                                // For now, directly passing radio url string.
                                // However, it must be changed later to some sort of ID
                                // to take care of other use cases such as 1. stop 2. play next
                                //                globalPlayer.signalPlay(ID: self.id)
                                print(r.id)
                                
                                print("#", currentPlayListIndex)
                                self.tappedID = r.id
                                
                                if (self.didTap == false){
                                    self.didTap = true
                                    
                                    backgroundQ.updatePlayListIndex(index: currentPlayListIndex)
                                    backgroundQ.updateStartingPointIndex(tappedIndex: self.tappedID)
                                    
                                    self.tappedID = backgroundQ.startingPointIndex
                                    //                                globalPlayer.signalPlay(ID: r.radioURL)
                                    globalPlayer.signalPlay(ID: self.tappedID)
                                    
                                } else{
                                    self.didTap = false
                                    globalPlayer.stop()
                                }
                        }
                    }
                }// VStack
            }.navigationBarTitle(LocalizedStringKey(totalRecs.allPlaylist[recList].name), displayMode: .inline)
            // ZStack
        }//Navigation View
    }
}
