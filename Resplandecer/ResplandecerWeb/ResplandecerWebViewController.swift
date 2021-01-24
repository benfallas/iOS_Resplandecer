//
//  ResplandecerWebViewController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/18/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ResplandecerWebViewController: UIViewController, WKNavigationDelegate {
    
    let errorMessage = "Algo Salio Mal. Vuelva a intentarlo."
    private var alert: UIAlertController?
    
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let url = URL(string: "http://radioresplandecer.com/")!
    
        webView = WKWebView(frame: self.view.frame)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isUserInteractionEnabled = true
        self.view.addSubview(self.webView)
        let request = URLRequest(url: url)
        webView.load(request)
        
        // add activity
        self.webView.addSubview(self.loadingSpinner)
        self.loadingSpinner.startAnimating()
        self.webView.navigationDelegate = self
        self.loadingSpinner.hidesWhenStopped = true
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingSpinner.stopAnimating()
    }

    
    func webView(_ webView: WKWebView, didFailLoadWithError error: Error) {
        loadingSpinner.stopAnimating()

        alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        self.alert!.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
            self.alert?.dismiss(animated: false)
                })
        if (alert != nil) {
            self.parent!.present(alert!, animated: false)
        }
    }
    
    private func webView(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
        loadingSpinner.stopAnimating()

        alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        self.alert!.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
            self.alert?.dismiss(animated: false)
                })
        if (alert != nil) {
            self.parent!.present(alert!, animated: false)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadingSpinner.stopAnimating()

        alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        self.alert!.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
            self.alert?.dismiss(animated: false)
                })
        if (alert != nil) {
            self.parent!.present(alert!, animated: false)
        }
    }
    
    private func webView(_ webView: WKWebView, didFail: WKNavigation!, withError: Error) {
        loadingSpinner.stopAnimating()

        alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        self.alert!.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
            self.alert?.dismiss(animated: false)
                })
        if (alert != nil) {
            self.parent!.present(alert!, animated: false)
        }
    }
}
