//
//  ViewController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/12/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        let url = URL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vT3HsRGiTn6Lu7ie99Gh85WSpmT4aOXv9mNw2n49_5eFUbEnPPpbpaAtj7Qphj4wMd8WfaFofaTVv8H/pub?gid=939886657&single=true&output=csv")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
            var csvData = String(data: data, encoding: .utf8)!
            let parsedCSV: [String] = csvData.components(separatedBy: ",")
            print(csvData)
            print(parsedCSV)
            
            for i in 5..<parsedCSV.count  {
                var title = ""
                var context = ""
                
                if (i % 2 != 0) {
                    title = parsedCSV[i]
                    context = parsedCSV[i + 1]
                }
        
                
                print("title: " + title)
                print("context: " + context)
                
               
            }

        }
    }


}

