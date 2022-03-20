//
//  Contactanos.swift
//  Resplandecer
//
//  Created by Benito Sanchez on 3/13/22.
//  Copyright © 2022 Resplandecer. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ContactanosViewController : UIViewController {
    
    @IBAction func onNavigationClicked(_ sender: Any) {
        let coordinate = CLLocationCoordinate2DMake(36.212339, -121.126109)
        
        let placemark : MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary:nil)

        let mapItem:MKMapItem = MKMapItem(placemark: placemark)

            mapItem.name = "Iglesia De Jesucristo"
        
        let launchOptions:NSDictionary = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey as NSCopying)

        let currentLocationMapItem:MKMapItem = MKMapItem.forCurrentLocation()

        MKMapItem.openMaps(with: [currentLocationMapItem, mapItem], launchOptions: launchOptions as? [String : Any])

    }
    
    @IBAction func onEmailClicked(_ sender: Any) {
        let email = "radioresplandecer93930@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
}
