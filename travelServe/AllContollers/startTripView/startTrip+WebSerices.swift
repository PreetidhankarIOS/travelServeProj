//
//  startTrip+WebSerices.swift
//  travelServe
//
//  Created by Developer on 10/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import CoreLocation

extension StartTripViewController {
    


    func fetchMapData(_ toLat:String,toLog:String) {
        
                let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
                    "origin=\(toLat),\(toLog)&destination=\(self.addressLabel.text!)&" +
                "key=\(Configuration.googlePlaceAPIKey())"

        
        if let encoded = directionURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
             Alamofire.request(url).validate().responseJSON { (json) in
                 print(json)
                if let JSON = json.result.value {
                     debugPrint(JSON)
                     let mapResponse: [String: AnyObject] = JSON as! [String : AnyObject]
                     let routesArray = (mapResponse["routes"] as? Array) ?? []
                   
                let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]

                let legs = routes["legs"] as! Array<Dictionary<String, AnyObject>>
                let startLocationDictionary = legs[0]["start_location"] as! Dictionary<String, AnyObject>
                let originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat"] as! Double, startLocationDictionary["lng"] as! Double)

                let endLocationDictionary = legs[legs.count - 1]["end_location"] as! Dictionary<String, AnyObject>
                let destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat"] as! Double, endLocationDictionary["lng"] as! Double)
                    
                self.userPicUpLat =  endLocationDictionary["lat"] as! Double
                self.userPicUpLong = endLocationDictionary["lng"] as! Double

                let originAddress = legs[0]["start_address"] as! String
                let destinationAddress = legs[legs.count - 1]["end_address"] as! String

                let originMarker = GMSMarker(position: originCoordinate)
                originMarker.map = self.mapView
                originMarker.icon = UIImage(named: "car")
                originMarker.title = originAddress

                let destinationMarker = GMSMarker(position: destinationCoordinate)
                destinationMarker.map = self.mapView
                destinationMarker.icon = UIImage(named: "standing_up_man")
                destinationMarker.title = destinationAddress
                    

                  let distance = legs[0]["distance"] as! Dictionary<String, AnyObject>
                      let textm = distance["text"] as? String ?? ""
                      self.distanceLib.text = textm
                    
                    let duration = legs[0]["duration"] as! Dictionary<String, AnyObject>
                    
                    let texduration = duration["text"] as? String ?? ""
                    self.durationLib.text = texduration
      
                     let polypoints = (overviewPolyline["points"] as? String) ?? ""
                     let line  = polypoints
                     self.addPolyLine(encodedString: line)

                 }
             }
        }
    }
    
    func addPolyLine(encodedString: String) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        polyline.map = self.mapView
        UserDefaults.standard.set(true, forKey: ckStartTrip)
        let bounds = GMSCoordinateBounds(path:path! )
        self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 100.0))
        
    }
    

    //MARK: listing work Here/////////////////////////////////////////////////////
    
    func start_On_Site_Driver(VehicleBooking_Id:String,DriverId:String,OnSideLatitude:String,OnSideLongitude:String,OnSideLocation:String) -> Void {
        
        var json: [String: Any] = [:]
        json["VehicleBookingId"] = VehicleBooking_Id
        json["DriverId"] = DriverId
        json["OnSideLatitude"] = OnSideLatitude
        json["OnSideLongitude"] = OnSideLongitude
        json["OnSideLocation"] = OnSideLocation

        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_ON_SIDE, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        
                        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBord.instantiateViewController(withIdentifier: "startWithConiformViewController") as! startWithConiformViewController

                        if (UserDefaults.standard.bool(forKey: ckStartTrip)) == true {
                            
                            nextViewController.dropLocation = UserDefaults.standard.string(forKey: "dropAdress")!
                            nextViewController.pickUpaddress = UserDefaults.standard.string(forKey: "pickUpAdress")!
                            nextViewController.curentLocationNext =  self.Alocation
                            nextViewController.riderName = UserDefaults.standard.string(forKey: "psengerName")!
                            nextViewController.VehicleBookingId = UserDefaults.standard.string(forKey: "VehicleBooking_Id")!
                            
                            nextViewController.PriceModelId = Int(UserDefaults.standard.string(forKey: "PriceModelId")!)!
                            nextViewController.PFCIId = Int(UserDefaults.standard.string(forKey: "PFCIId")!)!
                            nextViewController.LocationId = Int(UserDefaults.standard.string(forKey: "LocationId")!)!
                            nextViewController.jobPrice = UserDefaults.standard.string(forKey: "jobPrice")!

                        }else{
                            
                            nextViewController.dropLocation = self.toAddress
                            nextViewController.pickUpaddress = self.adressTo
                            nextViewController.curentLocationNext =  self.Alocation
                            nextViewController.riderName = self.userPaxName
                            nextViewController.VehicleBookingId = VehicleBooking_Id
                            nextViewController.PriceModelId = self.PriceModelId
                            nextViewController.PFCIId = self.PFCIId
                            nextViewController.LocationId = self.LocationId
                            nextViewController.jobPrice = self.jobPrice
                            
                        }
                        
                        
                        UserDefaults.standard.set(true, forKey: ckOnSiteTrip)
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
                        
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }

            }
            
        }
     
    }
   
    

    
}
        

