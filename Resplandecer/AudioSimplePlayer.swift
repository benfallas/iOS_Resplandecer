//
//  AudioSimplePlayer.swift
//  Resplandecer
//
//  Created by Juhi on 4/27/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import Foundation
import AVFoundation

let globalPlayer = AudioSimplePlayer()

class AudioSimplePlayer {
    
    var player: AVPlayer?
    
    // Given the ID of song find URL by accessing Recording
    func play(urlString: String) {
        
        print("playing \(urlString)")
        
        guard let url = URL.init(string: urlString) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        
        do {
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    func stop() {
        if let tempPlayer = player{
            tempPlayer.pause()
            self.player = nil
        }
    }
    
    class func playNext() {
        // automatically playing next song in the playlist
        
        // update the current song -> stop
        // update the next song -> play
        
    }
    
    func signalPlay(ID: String) {
        //DELETE THIS MESSAGE!! (for now ID is URL String)
        self.play(urlString: ID)
        
        //Using ID given, find the correct url string.
        //        for(){
        //            queue
        //        }
        //self.play(urlString: "http://radioresplandecer.com/wp-content/uploads/2016/09/A-Solas-Con-el-Maestro.mp3")
        
        // Recording.playlist
        //1-a. play a new song if it is a correct ID
        //1-b. don't play if it ID cannot be found or invalid
        //1-c. continue playing if ID is same as the current song playing
        
    }
}
