//
//  DeclaracionAlDiaTableViewController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/15/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import UIKit


struct MusicTrack {
    var title: String
    var subtitle: String
    var url: String
    
    init(title: String, subtitle: String, url: String) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
}

class DeclaracionAlDiaTableViewController: UITableViewController {
    
    var declaracionAlDiaTracks = [MusicTrack]()
    
    private func loadSampleData() {
        
        let url = URL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vT3HsRGiTn6Lu7ie99Gh85WSpmT4aOXv9mNw2n49_5eFUbEnPPpbpaAtj7Qphj4wMd8WfaFofaTVv8H/pub?gid=0&single=true&output=csv")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
            var csvData = String(data: data, encoding: .utf8)!
            let parsedCSV: [String] = csvData.components(separatedBy: ",")
            
            print(parsedCSV)
            
            for i in stride(from: 7, to: parsedCSV.count - 3, by: 3)  {
                var title = ""
                var subtitle = ""
                var url = ""
                
                title = parsedCSV[i]
                url = parsedCSV[i + 1]
                subtitle = parsedCSV[i + 2]
                
        
                print("Title")
                print(title)
                print("Subtitle")
                print(subtitle)
                print("URL")
                print(url)
                
                
            
                let stuff = MusicTrack(title: title, subtitle: subtitle, url: url)
                print("STUFF")
                print(stuff)
                self.declaracionAlDiaTracks += [stuff]
                print(self.declaracionAlDiaTracks)
            }
            
            print("FINAL VALUES")
            print(self.declaracionAlDiaTracks)
            print(self.tableView)
            self.tableView.reloadData()

        }
        
        
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did load")

       // Uncomment the following line to preserve selection between presentations
       // self.clearsSelectionOnViewWillAppear = false

       // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       // self.navigationItem.rightBarButtonItem = self.editButtonItem
           
        loadSampleData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("tableViewStuff")
        print("declaracionAlDia numberOfSections")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("tableViewStuff")
        print("declaracionAlDia count")
        return declaracionAlDiaTracks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableViewStuff 2")
        print("declaracionAlDia 2")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "declaracionAlDiaTableViewCell", for: indexPath) as? DeclaracionAlDiaTableViewCell  else {
            print("error")
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        cell.authorLabel.numberOfLines = 0
        
        print("table view title and contents")
        print("==================================")
        print(cell)
        print(declaracionAlDiaTracks)
        let contentData = declaracionAlDiaTracks[indexPath.row]
        
        cell.titleLabel.text = contentData.title
        cell.authorLabel.text = contentData.subtitle
        cell.url = contentData.url
    
        cell.layoutIfNeeded()

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

