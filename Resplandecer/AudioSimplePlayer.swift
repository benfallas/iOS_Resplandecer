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

final class AudioPlayer: AVPlayer, ObservableObject {
    
    @Published var currentTimeInSeconds: Double = 0.0
    private var timeObserverToken: Any?
    // ... some other staff
    
    // MARK: Publishers
    var currentTimeInSecondsPass: AnyPublisher<Double, Never>  {
        return $currentTimeInSeconds
            .eraseToAnyPublisher()
    }
    
    // in init() method I add observer, which update time in seconds
    override init() {
        super.init()
        registerObserves()
    }
    
    override init(playerItem item: AVPlayerItem?){
        super.init(playerItem: item)
        registerObserves()
    }
    
    private func registerObserves() {
        
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = self.addPeriodicTimeObserver(forInterval: interval, queue: .main) {
            [weak self] _ in
            self?.currentTimeInSeconds = self?.currentTime().seconds ?? 0.0
        }
        
    }
    
    // func for rewind song time
    func rewindTime(to seconds: Double) {
        let timeCM = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.seek(to: timeCM)
    }
    
    // sure I need to remove observer:
    deinit {
        
        if let token = timeObserverToken {
            self.removeTimeObserver(token)
            timeObserverToken = nil
        }
        
    }
    
}

// simplified slider

import SwiftUI

struct PlayerSlider: View {
    
    @EnvironmentObject var player: AudioPlayer
    @State private var currentPlayerTime: Double = 0.0
    //    var song: Song // struct which contains the song length as Int
    
    var body: some View {
        
        HStack {
            
            GeometryReader { geometry in
                Slider(value: self.$currentPlayerTime, in: 0.0...currentSongDuration)
                    .onReceive(self.player.currentTimeInSecondsPass) { _ in
                        // here I changed the value every second
                        self.currentPlayerTime = self.player.currentTimeInSeconds
                }
                    // controlling rewind
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ value in
                            let coefficient = abs(currentSongDuration / Double(geometry.size.width))
                            self.player.rewindTime(to: Double(value.location.x) * coefficient)
                        }))
            }
            .frame(height: 30)
            
        }
        
    }
    
}

var currentSongDuration: Double = 0.0

let globalPlayer = AudioSimplePlayer()

class AudioSimplePlayer {
    
    var player: AudioPlayer?
    
    // Given the ID of song find URL by accessing Recording
    func play(urlString: String) {
        
        print("playing \(urlString)")
        
        
        //        // For Slider
        //        let asset = AVURLAsset(url: NSURL(fileURLWithPath: urlString) as URL, options: nil)
        //        let audioDuration = asset.duration
        //        let audioDurationSeconds = CMTimeGetSeconds(audioDuration)
        
        
        guard let url = URL.init(string: urlString) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        
        NotificationCenter.default.addObserver(self, selector: Selector(("playNext:")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        do {
            self.player = try AudioPlayer(playerItem:playerItem)
            player!.volume = 1.0
            
            //            player!.seek(to: sameSeekTimeAsVideoPlayer)
            
            // For Slider
            //            currentSongDuration = player!.currentItem?.duration.seconds ?? 0.0
            //            print("   ?? HOW LONG is the Song ??: ", currentSongDuration)
            //
            player!.play()
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func playNext(note: NSNotification) {
        // play next song
        let sizeOfPlayList = totalRecs.allPlaylist[backgroundQ.currentPlayListIndex].recordings.count
        print(" 1. Size of Playlist", sizeOfPlayList)
        
        print("   2. current starting point", backgroundQ.startingPointIndex)
        
        if(sizeOfPlayList > backgroundQ.startingPointIndex+1){
            backgroundQ.updateStartingPointIndex(tappedIndex: backgroundQ.startingPointIndex+1)
        }
        print("       3 . Updated starting point", backgroundQ.startingPointIndex)
        //        self.play()
        
        globalPlayer.signalPlay(ID: backgroundQ.startingPointIndex)
    }
    
    func stop() {
        if let tempPlayer = player{
            tempPlayer.pause()
            self.player = nil
        }
    }
    
    func signalPlay(ID: Int) {
        //DELETE THIS MESSAGE!! (for now ID is URL String)
        print("    signaled play list",backgroundQ.currentPlayListIndex)
        print("    signaled play",ID)
                
        if(ID == backgroundQ.startingPointIndex){
            let urlString: String = totalRecs.allPlaylist[backgroundQ.currentPlayListIndex].recordings[ID].radioURL
            self.play(urlString: urlString)
        }
        
        // Recording.playlist
        //1-a. play a new song if it is a correct ID
        //1-b. don't play if it ID cannot be found or invalid
        //1-c. continue playing if ID is same as the current song playing
        
    }
    
    func signalPlayLiveRadio(){
        // call this only for main 24/7 radio station
//        let playlistNum = Int.random(in: 0..<3)
//        let songNum = Int.random(in: 0..<12)
//        //queue needs to cleared
//        //queue populated with totalRecs.allPlaylist[playlistNum]
//        let currentRecord = totalRecs.allPlaylist[playlistNum].recordings[songNum].radioURL
//        //queue starting point at currrentRecord
//
//        print(totalRecs.allPlaylist[playlistNum].recordings[songNum].title)
        self.play(urlString: "http://107.215.165.202:8000/resplandecer?hash=1573611071190.mp3")
    }
}
