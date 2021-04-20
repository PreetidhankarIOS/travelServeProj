//
//  curentLatLogView.swift
//  travelServe
//
//  Created by Developer on 03/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import GooglePlaces
import GoogleMaps

extension homeViewController{
    
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
            
            
                debugPrint(UserDetail.shared.getUserLat())
                debugPrint(UserDetail.shared.getUserLong())

            
            if lati == "" || longi == ""  {
                
                //forLocationAddress(UserDetail.shared.getUserLat(), longi: UserDetail.shared.getUserLong())

            }else{
           
               // forLocationAddress(lati, longi: longi)
                
               // self.START_DEIVER_SHIFT_API(SLatitude: lati, DriverId: UserDetail.shared.getUserDriverId(), SLocation:  self.addressString, SLongitude: longi)
                
            }
            
        }
    }
    
    func forLocationAddress (_ lati: String, longi:String, addressLocation: String) {
        
            if (UserDefaults.standard.bool(forKey: ckStartDeriverShip)) == true  {
                UserDefaults.standard.set(false, forKey: ckStartDeriverShip)

                DispatchQueue.main.async {
                    self.START_DEIVER_SHIFT_API(SLatitude: lati, DriverId: UserDetail.shared.getUserDriverId(), SLongitude: longi)
                }

            }else{
                
                if(UserDefaults.standard.bool(forKey: ckdataAfterLogout)) == true {
                    
                  //  self.UPDATE_LOCATION_IN_SECOND_API(SLatitude: UserDetail.shared.getUserLat(), DriverId: UserDetail.shared.getUserDriverId(), SLocation:  addressLocation, SLongitude: UserDetail.shared.getUserLong())
                           
               }
                
     
            }

        
    }
    

 //////////////////////////////////////////////// All Check Here /////////////////////////////////////////////////////////////
    
    func forAllCheckWhereWasDeriver(){
        
         if (UserDefaults.standard.bool(forKey: ckTripComplet)) == true {
             
             PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You have On going trip. Click ok to Proceed", yes: "Ok", onVC: self){
                
                let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = storyBord.instantiateViewController(withIdentifier: "startWithConiformViewController") as! startWithConiformViewController
                UserDefaults.standard.set(true, forKey: "FinalAmountPopUp")
                self.navigationController?.pushViewController(nextViewController, animated: true)
 
             }
             
        }
            
        else if (UserDefaults.standard.bool(forKey: ckOnBoard)) == true{
            
            PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You have On going trip. Click ok to Proceed", yes: "Ok", onVC: self){
                
                  let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let nextViewController = storyBord.instantiateViewController(withIdentifier: "startWithConiformViewController") as! startWithConiformViewController
                  self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        else if (UserDefaults.standard.bool(forKey: ckOnSiteTrip)) == true {
            
            PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You have On going trip. Click ok to Proceed", yes: "Ok", onVC: self){
                           
                   let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let nextViewController = storyBord.instantiateViewController(withIdentifier: "startWithConiformViewController") as! startWithConiformViewController
                   nextViewController.dropLocation = UserDefaults.standard.string(forKey: "dropAdress")!
                   nextViewController.pickUpaddress = UserDefaults.standard.string(forKey: "pickUpAdress")!
                   nextViewController.curentLocationNext =  self.addressStringNew
                   nextViewController.riderName = UserDefaults.standard.string(forKey: "psengerName")!
                   nextViewController.VehicleBookingId = UserDefaults.standard.string(forKey: "VehicleBooking_Id")!
                   nextViewController.PriceModelId = Int(UserDefaults.standard.string(forKey: "PriceModelId")!)!
                   nextViewController.PFCIId = Int(UserDefaults.standard.string(forKey: "PFCIId")!)!
                   nextViewController.LocationId = Int(UserDefaults.standard.string(forKey: "LocationId")!)!
                   nextViewController.jobPrice = UserDefaults.standard.string(forKey: "jobPrice")!
                   self.navigationController?.pushViewController(nextViewController, animated: true)
                           
            }
            
        }
        else if (UserDefaults.standard.bool(forKey: ckStartTrip)) == true {
            
            PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You have On going trip. Click ok to Proceed", yes: "Ok", onVC: self){
                
                let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextViewController = storyBord.instantiateViewController(withIdentifier: "StartTripViewController") as! StartTripViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
        }
                
    }

}
