//
//  VDEEViewController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/18/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class VDEEViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
        let url = URL(string: "http://www.evalverde.com/index.php/es/")!
    
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

    }
}
