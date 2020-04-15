//
//  AudioSimplePlayer.swift
//  Resplandecer
//
//  Created by Juhi on 2/27/20.
//  Copyright © 2020 Resplandecer. All rights reserved.
//

import Foundation
import AVFoundation

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
    
    class func stop() {
                
    }
    
    class func playNext() {
        // automatically playing next song in the playlist
        
        // update the current song -> stop
        // update the next song -> play
    }
    
    func signalPlay(ID: String) {
        
        //Using ID given:
        self.play(urlString: "http://radioresplandecer.com/wp-content/uploads/2016/09/A-Solas-Con-el-Maestro.mp3")
        
        // Recording.playlisty
        //1-a. play a new song if it is a correct ID
        //1-b. don't play if it ID cannot be found or invalid
        //1-c. continue playing if ID is same as the current song playing
        
    }
}
