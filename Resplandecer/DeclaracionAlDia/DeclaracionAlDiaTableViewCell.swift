//
//  DeclaracionAlDiaTableViewCell.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/15/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import UIKit
import AVFoundation

class DeclaracionAlDiaTableViewCell: UITableViewCell {
    
    private var playText = "Play"
    private var pauseText = "Pause"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var playPauseButton: UIButton!
    
    var url: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
        authorLabel.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onDeclaracionAlDiaPlayClicked(_ sender: UIButton) {
        if (AvPlayerManager.manager.isPlaying() && AvPlayerManager.manager.getCurrentUrl()!.absoluteString == url) {
            AvPlayerManager.manager.pause()
            playPauseButton.setTitle(playText, for: .normal)
        } else {
            print("TRY loading")
            if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
               let newURL = URL(string: encoded) {
                
                print(newURL)
                AvPlayerManager.manager.loadMp3File(observer: self, url: newURL)
                AvPlayerManager.manager.play()
            } else {
                print("iddn't work")
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        // Only handle observations for the playerItemContext
        guard context == &AvPlayerManager.manager.self.playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            return
        }

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
                print("READY TO PLAY")
                if (AvPlayerManager.manager.getCurrentUrl()?.absoluteString == self.url) {
                    playPauseButton.setTitle(pauseText, for: .normal)

                } else {
                    playPauseButton.setTitle(playText, for: .normal)

                }
                break
                // Player item is ready to play.
            case .failed:
                playPauseButton.setTitle(playText, for: .normal)

                break
                // Player item failed. See error.
            case .unknown:
                break
                // Player item is not yet ready.
            }
        }
    }
    
//    deinit {
//        AvPlayerManager.manager.removeObserver()
//    }
}
