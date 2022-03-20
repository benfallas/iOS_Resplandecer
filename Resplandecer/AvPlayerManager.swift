//
//  AvPlayerManager.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/14/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer


class AvPlayerManager: NSObject {
    
    static let manager = AvPlayerManager()
    var playerItemContext = 0
    var currentUrl: URL?
    var observer: NSObject?
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    
    func loadMp3File(observer: NSObject, url : URL?, title: String, subtitle: String) {
        
        self.observer = observer
        currentUrl = url!
        playerItem = AVPlayerItem(url: url!)
        
        playerItem!.addObserver(observer,
                                   forKeyPath: "status",
                                   options: [.old, .new],
                                   context: &playerItemContext)
        
            
    
        
        player = AVPlayer(playerItem: playerItem)
        
        
        setupRemoteCommandCenter(enable: true, title: title, subtitle: subtitle)

    }
    
    func setupRemoteCommandCenter(enable: Bool, title: String?, subtitle: String?) {
        
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = subtitle
        
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            let remoteCommandCenter = MPRemoteCommandCenter.shared()
        
            if enable {
            
                remoteCommandCenter.pauseCommand.addTarget(self, action: #selector(remoteCommandCenterPauseCommandHandler))
                remoteCommandCenter.playCommand.addTarget(self, action: #selector(remoteCommandCenterPlayCommandHandler))
                remoteCommandCenter.stopCommand.addTarget(self, action: #selector(remoteCommandCenterStopCommandHandler))
                remoteCommandCenter.togglePlayPauseCommand.addTarget(self, action: #selector(remoteCommandCenterPlayPauseCommandHandler))
            
            } else {
            
                remoteCommandCenter.pauseCommand.removeTarget(self, action: #selector(remoteCommandCenterPauseCommandHandler))
                remoteCommandCenter.playCommand.removeTarget(self, action: #selector(remoteCommandCenterPlayCommandHandler))
                remoteCommandCenter.stopCommand.removeTarget(self, action: #selector(remoteCommandCenterStopCommandHandler))
                remoteCommandCenter.togglePlayPauseCommand.removeTarget(self, action: #selector(remoteCommandCenterPlayPauseCommandHandler))
            
            }
        
            remoteCommandCenter.pauseCommand.isEnabled = enable
            remoteCommandCenter.playCommand.isEnabled = enable
            remoteCommandCenter.stopCommand.isEnabled = enable
            remoteCommandCenter.togglePlayPauseCommand.isEnabled = enable
        
    }
    
    
    func handlePlayCommandEvent() -> MPRemoteCommandHandlerStatus {
            
            return .success
        }

    deinit {
        
        do {
            try AVAudioSession.sharedInstance()
                                  .setCategory(AVAudioSession.Category.playback)
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ as NSError { }
        } catch _ as NSError { }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
        } catch {
        }
        
        setupRemoteCommandCenter(enable: false, title: nil, subtitle: nil)
    }

    @objc func remoteCommandCenterPauseCommandHandler() -> MPRemoteCommandHandlerStatus {
            
        // handle pause
        player?.pause()
        return .success
    
    }

    @objc func remoteCommandCenterPlayCommandHandler() -> MPRemoteCommandHandlerStatus {
        // handle play
        player?.play()
        return .success
    }

    @objc func remoteCommandCenterStopCommandHandler() -> MPRemoteCommandHandlerStatus {
        // handle stop
        player?.pause()
        return .success
    }

    @objc func remoteCommandCenterPlayPauseCommandHandler() -> MPRemoteCommandHandlerStatus {
        
        // handle play pause
        if player?.rate == 0.0 {
            player?.play()
        } else {
            player?.pause()
        }
        
        return .success
    }
    
    func play()  {
        player!.play()
    }

    
    func pause() {
        player?.pause()
        player = nil
    }
    
    
    func isPlaying() -> Bool {
        if (player != nil) {
            return player!.rate != 0 && player!.error == nil
        }
        return false
    }
    
    func getCurrentUrl() -> URL? {
        return currentUrl
    }
    
    func removeObserver() {
        if (playerItem != nil) {
            if (self.observer != nil) {
                playerItem!.removeObserver(self.observer!, forKeyPath: "status")
                observer = nil
            }
        }
    }
}
