//
//  currentLocationUpadte.swift
//  travelServe
//
//  Created by Developer on 23/08/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


extension AppDelegate{
    
    func curentLocation(){
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
            if let lat = currentLocation?.coordinate.latitude{
                lati = "\(lat)"
            }
            if let lng = currentLocation?.coordinate.longitude{
                longi = "\(lng)"
            }
            //forLocationAddress()
            
        }
    }

}
