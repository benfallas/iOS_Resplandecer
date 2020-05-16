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
import SwiftSpinner

let globalPlayer = AudioSimplePlayer()

class AudioSimplePlayer : NSObject {
    
    private var isPlaybackBufferEmptyObserver: NSKeyValueObservation?
    private var isPlaybackBufferFullObserver: NSKeyValueObservation?
    private var isPlaybackLikelyToKeepUpObserver: NSKeyValueObservation?
    
    private var player: AVPlayer?
    
    // Given the ID of song find URL by accessing Recording
    func play(urlString: String) {
        SwiftSpinner.show("Cargando...")

        print("playing \(urlString)")
        
        guard let url = URL.init(string: urlString) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        
        playerItem.addObserver(self, forKeyPath: "status",  options: .new, context: nil)

              playerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
              playerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
              playerItem.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)
              observeBuffering(for: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playNext(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        do {
            self.player = try AVPlayer(playerItem:playerItem)
            self.player!.volume = 1.0
            
            player!.play()
            
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
            SwiftSpinner.hide()
        } catch {
            print("AVAudioPlayer init failed")
            SwiftSpinner.hide()
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

    override func observeValue(
          forKeyPath keyPath: String?,
          of object: Any?, change: [NSKeyValueChangeKey : Any]?,
          context: UnsafeMutableRawPointer?) {

          if keyPath == #keyPath(AVPlayerItem.status) {
              let status: AVPlayerItem.Status
              if let statusNumber = change?[.newKey] as? NSNumber {
                  status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
              } else {
                  status = .unknown
              }

              // Switch over status value
              switch status {
              case .readyToPlay:
                    print("observeValue readyToPlay: ");
                    self.player?.play()
                  SwiftSpinner.hide()
                  break
              case .failed:
                  SwiftSpinner.show("No se pudo connectar a la internet", animated: false).addTapHandler ({
                      SwiftSpinner.hide()
                      }, subtitle: "Verifique su connexion y vuelva a intentar")
                  break
                  // Player item failed. See error.
              case .unknown:
                  SwiftSpinner.show("No se pudo connectar a la internet", animated: false).addTapHandler ({
                  SwiftSpinner.hide()
                  }, subtitle: "Vuelva a intentar")
                  SwiftSpinner.hide()
                  break
              }
          }
      }
      
      private func observeBuffering(for playerItem: AVPlayerItem) {
          isPlaybackBufferEmptyObserver = playerItem.observe(\.isPlaybackBufferEmpty, changeHandler: onIsPlaybackBufferEmptyObserverChanged)
          isPlaybackBufferFullObserver = playerItem.observe(\.isPlaybackBufferFull, changeHandler: onIsPlaybackBufferFullObserverChanged)
          isPlaybackLikelyToKeepUpObserver = playerItem.observe(\.isPlaybackLikelyToKeepUp, changeHandler: onIsPlaybackLikelyToKeepUpObserverChanged)
      }
      
      private func onIsPlaybackBufferEmptyObserverChanged(playerItem: AVPlayerItem, change: NSKeyValueObservedChange<Bool>) {
          if playerItem.isPlaybackBufferEmpty {
              self.player?.pause()
              
              print("onIsPlaybackBufferEmptyObserverChanged isPlaybackBufferEmpty: ");
              SwiftSpinner.show("Cargando...")
          }
      }

      private func onIsPlaybackBufferFullObserverChanged(playerItem: AVPlayerItem, change: NSKeyValueObservedChange<Bool>) {
          if playerItem.isPlaybackBufferFull {
              
              print("onIsPlaybackBufferFullObserverChanged isPlaybackBufferFull: ");
              SwiftSpinner.hide()
          }
      }

      private func onIsPlaybackLikelyToKeepUpObserverChanged(playerItem: AVPlayerItem, change: NSKeyValueObservedChange<Bool>) {
          if playerItem.isPlaybackLikelyToKeepUp {
              print("onIsPlaybackLikelyToKeepUpObserverChanged isPlaybackLikelyToKeepUp: ");

              SwiftSpinner.hide()
          }
      }
    
}
