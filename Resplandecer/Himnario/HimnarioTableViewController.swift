//
//  DeclaracionAlDiaTableViewController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/15/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import UIKit


class HimnarioTableViewController: UITableViewController {
    
    var himnarioTracks = [MusicTrack]()
    
    private func loadSampleData() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vT3HsRGiTn6Lu7ie99Gh85WSpmT4aOXv9mNw2n49_5eFUbEnPPpbpaAtj7Qphj4wMd8WfaFofaTVv8H/pub?gid=902385560&single=true&output=csv")! as URL)
        
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            DispatchQueue.global(qos: .background).async {

                guard let data = data else { return }
                let csvData = String(data: data, encoding: .utf8)!
                let parsedCSV: [String] = csvData.components(separatedBy: ",")
                            
                for i in stride(from: 7, to: parsedCSV.count - 2, by: 3)  {
                    var title = ""
                    var subtitle = ""
                    var url = ""
                    
                    title = parsedCSV[i]
                    url = parsedCSV[i + 1]
                    subtitle = parsedCSV[i + 2]
                
                    let stuff = MusicTrack(title: title, subtitle: subtitle, url: url)
                    self.himnarioTracks += [stuff]
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
        loadSampleData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return himnarioTracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "himnarioTableViewCellIdentifier", for: indexPath) as? HimnarioTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HimnarioTableViewCell.")
        }
                
        let contentData = himnarioTracks[indexPath.row]
        
        cell.titleLabel.text = contentData.title
        cell.url = contentData.url
    
        cell.layoutIfNeeded()

        return cell
    }
}

