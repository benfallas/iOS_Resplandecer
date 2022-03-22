//
//  MainScreenContentController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/12/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet var mainCellContentView: UIView!
    @IBOutlet var titleViewCell: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var contentViewCell: UILabel!
    
    private var pressToPlayText: String = "Precione Para Escuchar"
    private var sintonizando = "Sintonizando"
    let loadingMessage = "cargando..."
    let errorMessage = "Algo Salio Mal. Vuelva a intentarlo."
    private var alert: UIAlertController?
    
    var radioStation: String = ""
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        titleViewCell.numberOfLines = 0
        contentViewCell.numberOfLines = 0
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption),
                                               name: AVAudioSession.interruptionNotification,
                                               object: AVAudioSession.sharedInstance())
    }
    
    @objc func handleInterruption(_ notification: Notification) {
        guard let info = notification.userInfo,
                let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt,
                let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                    return
            }
            if type == .began {
                // Interruption began, take appropriate actions (save state, update user interface)
                AvPlayerManager.manager.pause()
            }
            else if type == .ended {
                guard let optionsValue =
                        notification.userInfo?[AVAudioSessionInterruptionOptionKey] as? UInt else {
                        return
                }
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    onMainTableCellClicked("")
                }
            }
        }

    @IBAction func onMainTableCellClicked(_ sender: Any) {
        if !radioStation.isEmpty {
            if (AvPlayerManager.manager.isPlaying()) {
                AvPlayerManager.manager.pause()
                contentViewCell.text = pressToPlayText

            } else {
                if let encoded = radioStation.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                   let newURL = URL(string: encoded) {
                    
                    AvPlayerManager.manager.loadMp3File(observer: self, url: newURL, title: "Radio Resplandecer", subtitle: "Sintonizando")
                    AvPlayerManager.manager.play()
                    
                    alert = UIAlertController(title: nil, message: loadingMessage, preferredStyle: .alert)
                    if (alert != nil) {
                        self.parentViewController!.present(alert!, animated: true)
                    }
                } else {
                }
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
                    contentViewCell.text = sintonizando

                
                if (alert != nil) {
                    alert!.dismiss(animated: true)
                }
                break
            case .failed:
                contentViewCell.text = pressToPlayText
                if (alert != nil) {
                    alert!.dismiss(animated: true) { () -> Void in
                        self.alert = UIAlertController(title: nil, message: self.errorMessage, preferredStyle: .alert)
                        self.alert!.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
                            self.alert?.dismiss(animated: false)
                                })
                        self.parentViewController!.present(self.alert!, animated: false)
                    }
                    alert = nil
                }
                
                break
            case .unknown:
                break
            @unknown default:
                break;
            }
        }
    }
}
