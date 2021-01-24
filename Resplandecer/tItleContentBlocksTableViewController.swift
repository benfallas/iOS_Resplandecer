//
//  tItleContentBlocksTableViewController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/12/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import UIKit
import AVFoundation


struct TitleContentBlocks {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

class tItlecContentBlocksTableViewController: UITableViewController {
    
    let loadingMessage = "cargando..."
    let errorMessage = "Algo Salio Mal. Vuelva a intentarlo."
    private var alert: UIAlertController?
    
    
    private var pressToPlayText: String = "Precione Para Escuchar Radio"
    private var youreListeningToText : String = "Estas Escuchando Radio Resplandecer"
    
    private var playerItemContext = 0
    @IBOutlet var pressToPlayButton: UIButton!
    
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    
    var titleAndContents = [TitleContentBlocks]()

    @IBAction func onPlayRadioClicked(_ sender: Any) {        
        if (AvPlayerManager.manager.isPlaying()) {
            AvPlayerManager.manager.pause()
            pressToPlayButton.setTitle(pressToPlayText, for: .normal)

        } else {
            AvPlayerManager.manager.loadMp3File(observer: self, url: URL(string: "http://107.215.165.202:8000/resplandecer?hash=1573611071190.mp3"))
            AvPlayerManager.manager.play()
            alert = UIAlertController(title: nil, message: loadingMessage, preferredStyle: .alert)
            if (alert != nil) {
                self.present(alert!, animated: true)
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

            switch status {
            
            case .readyToPlay:
                pressToPlayButton.setTitle(youreListeningToText, for: .normal)
                if (alert != nil) {
                    alert!.dismiss(animated: true)
                }
                break
                
            case .failed:
                if (alert != nil) {
                    alert!.dismiss(animated: true) { () -> Void in
                        self.alert = UIAlertController(title: nil, message: self.errorMessage, preferredStyle: .alert)
                        self.alert!.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
                            self.alert?.dismiss(animated: false)
                                })
                        self.present(self.alert!, animated: false)

                    }
                    alert = nil
                }
                break
                
            case .unknown:
                break
            @unknown default:
                break
            }
        }
    }
    
    
    private func loadSampleData() {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vT3HsRGiTn6Lu7ie99Gh85WSpmT4aOXv9mNw2n49_5eFUbEnPPpbpaAtj7Qphj4wMd8WfaFofaTVv8H/pub?gid=939886657&single=true&output=csv")! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            DispatchQueue.global(qos: .background).async {

                guard let data = data else { return }
                let csvData = String(data: data, encoding: .utf8)!
                let parsedCSV: [String] = csvData.components(separatedBy: ",")
                            
                for i in 5..<parsedCSV.count  {
                    var title = ""
                    var context = ""
                    
                    if (i % 2 != 0) {
                        title = parsedCSV[i]
                        context = parsedCSV[i + 1]
                    }
        
                    if (!title.isEmpty && !context.isEmpty) {
                        let stuff = TitleContentBlocks(title: title, content: context)
                        self.titleAndContents += [stuff]
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
        self.tableView.reloadData()
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pressToPlayButton.setTitle(pressToPlayText, for: .normal)
        
        loadSampleData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleAndContents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as? MainTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
       
        let contentData = titleAndContents[indexPath.row]
        
        cell.titleViewCell.text = contentData.title
        cell.contentViewCell.text = contentData.content

        return cell
    }

}
