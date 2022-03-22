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
    
    
    private var pressToPlayText: String = "Precione Para Escuchar"
    private var youreListeningToText : String = "Estas Escuchando Radio Resplandecer"
    
    private var playerItemContext = 0
    
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    
    var titleAndContents = [TitleContentBlocks]()

    
    private func loadSampleData() {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vT3HsRGiTn6Lu7ie99Gh85WSpmT4aOXv9mNw2n49_5eFUbEnPPpbpaAtj7Qphj4wMd8WfaFofaTVv8H/pub?gid=1638222395&single=true&output=csv")! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            DispatchQueue.global(qos: .background).async {

                guard let data = data else { return }
                let csvData = String(data: data, encoding: .utf8)!
                let parsedCSV: [String] = csvData.components(separatedBy: ",")
                for i in 3..<parsedCSV.count  {
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
                    self.loadingSpinner.stopAnimating()
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
        
        
        if (contentData.title == "ESTACION PRINCIPAL") {
            cell.radioStation = contentData.content
            cell.playButton.isHidden = false
            cell.contentViewCell.textAlignment = .center
            cell.contentViewCell.layoutIfNeeded()
            cell.contentViewCell.isHidden = true
            cell.titleViewCell.isHidden = true
        } else {
            cell.titleViewCell.text = contentData.title
            cell.contentViewCell.text = contentData.content
            cell.playButton.isHidden = true
        
        }

        return cell
    }

}
