//
//  HimnarioTableViewCell.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/15/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import UIKit
import AVFoundation


class VDEEBilingueTableViewCell: UITableViewCell {
    
    private var playText = "Play"
    private var pauseText = "Pause"
    
    let loadingMessage = "cargando..."
    let errorMessage = "Algo Salio Mal. Vuelva a intentarlo."
    private var alert: UIAlertController?
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    
    var url: String = ""

    @IBAction func onPlayPauseButtonClicked(_ sender: Any) {
        if (AvPlayerManager.manager.isPlaying()) {
            AvPlayerManager.manager.pause()
            playPauseButton.setTitle(playText, for: .normal)
        } else {
            if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
               let newURL = URL(string: encoded) {

                AvPlayerManager.manager.loadMp3File(observer: self, url: newURL)
                AvPlayerManager.manager.play()
                
                alert = UIAlertController(title: nil, message: loadingMessage, preferredStyle: .alert)
                if (alert != nil) {
                    self.parentViewController!.present(alert!, animated: true)
                }
            } else {
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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

            switch status {
            
            case .readyToPlay:
                playPauseButton.setTitle(pauseText, for: .normal)

                if (alert != nil) {
                    alert!.dismiss(animated: true)
                }
                break
                
            case .failed:
                playPauseButton.setTitle(playText, for: .normal)

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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
