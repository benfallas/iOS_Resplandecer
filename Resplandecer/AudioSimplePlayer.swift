//
//  AudioSimplePlayer.swift
//  Resplandecer
//
//  Created by Juhi on 4/27/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

let globalPlayer = AudioSimplePlayer()

class AudioSimplePlayer {
    
    private var player: AVPlayer?
    
    // Given the ID of song find URL by accessing Recording
    func play(urlString: String) {
        
        print("playing \(urlString)")
        
        guard let url = URL.init(string: urlString) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playNext(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        do {
            self.player = try AVPlayer(playerItem:playerItem)
            self.player!.volume = 1.0
            
            player!.play()
            
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    @objc func playNext(sender : AnyObject) {
        let sizeOfPlayList = totalRecs.allPlaylist[backgroundQ.currentPlayListIndex].recordings.count
        
        if(sizeOfPlayList > backgroundQ.startingPointIndex+1){
            backgroundQ.updateStartingPointIndex(tappedIndex: backgroundQ.startingPointIndex+1)
            globalPlayer.signalPlay(ID: backgroundQ.startingPointIndex)
        } else {
            self.stop()
        }
    }
    
    func stop() {
        if let tempPlayer = player{
            tempPlayer.pause()
            self.player = nil
        }
    }
    
    func signalPlay(ID: Int) {
        // Signal the player after considering following:
        //1-a. play a new song if it is a correct ID
        //1-b. don't play if it ID cannot be found or invalid
        //1-c. continue playing if ID is same as the current song playing
        
        if(ID == backgroundQ.startingPointIndex){
            let urlString: String = totalRecs.allPlaylist[backgroundQ.currentPlayListIndex].recordings[ID].radioURL
            self.play(urlString: urlString)
        }else {
            self.stop()
        }
    }
    
    func signalPlayLiveRadio(){
        // call this only for main 24/7 radio station
        
        self.play(urlString: "http://107.215.165.202:8000/resplandecer?hash=1573611071190.mp3")
    }
}
