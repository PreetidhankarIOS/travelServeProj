//
//  startTripWithConfirm+webServices.swift
//  travelServe
//
//  Created by Developer on 13/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import GoogleMaps
import CoreLocation
import UIKit



extension startWithConiformViewController {
    

    func GeoCoddingMeth(){
        
        let location = CLLocationCoordinate2D.init(latitude: Double(UserDetail.shared.getUserLat())!, longitude:Double(UserDetail.shared.getUserLong())!)
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { response, error in
              guard let address = response?.firstResult(), let lines = address.lines else {
                  return
              }
            self.addressString = lines.joined(separator: "\n")
            UserDetail.shared.setUserCurrentLocationAdress(self.addressString)
              debugPrint(address)
            
              
        }
    
    }

    func curentLocation(){
        
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
          currentLocation = locManager.location
         if let lat = currentLocation?.coordinate.latitude{
                lati = "\(lat)"
            }
         if let lng = currentLocation?.coordinate.longitude{
                longi = "\(lng)"
            }
                
                let marker = GMSMarker()
                self.mapview.clear()
                marker.position = CLLocationCoordinate2D(latitude: Double(lati) ?? 0.0, longitude: Double(longi) ?? 0.0)
                marker.icon = UIImage.init(named: "car")
                self.cameraMoveToLocation(toLocation: marker.position)
                marker.map = mapview

        }
    }
 
    func fetchMapData(_ toLat:String,toLog:String,fromLat:Double,fromLong:Double) {

                let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
                    "origin=\(toLat),\(toLog)&destination=\(self.dropLocationLib.text!)&" +
                "key=\(Configuration.googlePlaceAPIKey())"

        
        if let encoded = directionURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
         {
             Alamofire.request(url).validate().responseJSON { (json) in
                if let JSON = json.result.value {
                     debugPrint(JSON)
                     self.mapview.clear()
                     let mapResponse: [String: AnyObject] = JSON as! [String : AnyObject]
                     let routesArray = (mapResponse["routes"] as? Array) ?? []

                 let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                 let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]

                let legs = routes["legs"] as! Array<Dictionary<String, AnyObject>>
                let startLocationDictionary = legs[0]["start_location"] as! Dictionary<String, AnyObject>
                let originCoordinate = CLLocationCoordinate2DMake(startLocationDictionary["lat"] as! Double, startLocationDictionary["lng"] as! Double)

                let endLocationDictionary = legs[legs.count - 1]["end_location"] as! Dictionary<String, AnyObject>

                    self.destinationLat    = endLocationDictionary["lat"] as! Double
                    self.destinationLong  = endLocationDictionary["lng"] as! Double
                    debugPrint("\(self.destinationLat ),\(self.destinationLong)")
                    
                    
                let destinationCoordinate = CLLocationCoordinate2DMake(endLocationDictionary["lat"] as! Double, endLocationDictionary["lng"] as! Double)
                let originAddress = legs[0]["start_address"] as! String
                let destinationAddress = legs[legs.count - 1]["end_address"] as! String

                let originMarker = GMSMarker(position: originCoordinate)
                originMarker.map = self.mapview
                originMarker.icon = UIImage(named: "car")
                originMarker.title = originAddress

                let destinationMarker = GMSMarker(position: destinationCoordinate)
                destinationMarker.map = self.mapview
                destinationMarker.icon = UIImage(named: "standing_up_man")
                destinationMarker.title = destinationAddress


                  let distance = legs[0]["distance"] as! Dictionary<String, AnyObject>

                    let textm = distance["text"] as? String ?? ""
                    self.distanceLib.text = textm

                    let duration = legs[0]["duration"] as! Dictionary<String, AnyObject>

                    let texduration = duration["text"] as? String ?? ""
                    self.timeDistanceLib.text = texduration

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
        polyline.map = self.mapview
        let bounds = GMSCoordinateBounds(path:path! )
        self.mapview.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 100.0))
        
        self.tripCompletBtn.isHidden = false
        self.PNSbtn.isHidden = true
        self.POBbtn.isHidden = true


  }

    
func passenger_no_show_Driver(VehicleBooking_Id:String,DriverId:String,NoShowLatitude:String,NoShowLongitude:String,NoShowLocation:String) -> Void {
    
        var json: [String: Any] = [:]
        json["VehicleBookingId"] = VehicleBooking_Id
        json["DriverId"] = DriverId
        json["NoShowLatitude"] = NoShowLatitude
        json["NoShowLongitude"] = NoShowLongitude
        json["NoShowLocation"] = NoShowLocation
    
        DataManager().dataManager(view: self.view, urlStr: UserModule.NO_SHOW, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Booking Cancel Successfully", yes: "Ok", onVC: self){
                            let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
            }
            
        }
    
    }


    func forLocationAddress () {
        

        let location = CLLocationCoordinate2D.init(latitude: Double(self.dropLati), longitude:Double(self.dropLong))
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { response, error in
              guard let address = response?.firstResult(), let lines = address.lines else {
                  return
              }
            self.addressString = lines.joined(separator: "\n")
        }
            if   self.no_show_Driver == true{
            DispatchQueue.main.async {

                if Connectivity.isConnectedToInternet {

                    self.passenger_no_show_Driver(VehicleBooking_Id: self.VehicleBookingId, DriverId: UserDetail.shared.getUserDriverId(), NoShowLatitude: self.lati, NoShowLongitude: self.longi, NoShowLocation: self.addressString)
                    
                }else{
                    PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
                }
            }
        }else{

            if Connectivity.isConnectedToInternet {
                
                var driverWaitingcharge = Double()
                var TSWaitingcharge = Double()
                driverWaitingcharge =  Double(self.timerCount * self.DriverParkingCharges)
                TSWaitingcharge =  Double(self.timerCount * self.TSParkingCharges)
                 
                if self.jobPrice == "" {
                    self.jobPrice =  UserDefaults.standard.string(forKey: "jobPrice")!
                }
               
                if self.VehicleBookingId == "" {
                    self.VehicleBookingId =  UserDefaults.standard.string(forKey: "VehicleBooking_Id")!
                }
                         
                let jobPrice = Double(self.jobPrice)
                let TotalPayAmount: Double = (jobPrice! + driverWaitingcharge)
                //debugPrint(TotalPayAmount)
                self.amountAfterCalculate = "\(TotalPayAmount)"
                UserDefaults.standard.set(self.amountAfterCalculate, forKey: "amountAfterCalculate")
             
                
                self.UpdateWaitingChargesInfo_API(DriverWaitingCharge:"\(self.DriverParkingCharges)", FileBookingId: UserDetail.shared.getfileBookingId(), TSWaitingCharge: "\(self.TSParkingCharges)", VehicleBookingId: self.VehicleBookingId)

            }else{
                
                PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
            }
        }
}
    
    
func submitCashOrCard_Driver(VehicleBooking_Id:String,ReceivedAmount:String,PaymentTypeId:String,FileBookingId:String) -> Void {

        var json: [String: Any] = [:]
        json["VehicleBookingId"] = VehicleBooking_Id
        json["ReceivedAmount"] = ReceivedAmount
        json["PaymentTypeId"] = PaymentTypeId
        json["FileBookingId"] = FileBookingId
        DataManager().dataManager(view: self.view, urlStr: UserModule.SUBMIT_CASH_OR_CARD, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your payment Successfully Submit", yes: "Ok", onVC: self){
                            UserDefaults.standard.removeObject(forKey: ckTripComplet)
                            let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
            }
            
        }
        
    }
    
    
func trip_complet_Driver(VehicleBooking_Id:String,DriverId:String,JobDoneLatitude:String,JobDoneLongitude:String,JobDoneLocation:String) -> Void {

        var json: [String: Any] = [:]
        json["VehicleBookingId"] = VehicleBooking_Id
        json["JobDoneLatitude"] = JobDoneLatitude
        json["JobDoneLongitude"] = JobDoneLongitude
        json["JobDoneLocation"] = JobDoneLocation
        json["DriverId"] = DriverId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.TRIP_COMPLETE, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
    
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your Trip Completed Successfully", yes: "Ok", onVC: self){
                            UserDefaults.standard.set(true, forKey: ckTripComplet)
                            self.popUpViewBg.isHidden = false
                            self.cashBtn.isSelected = true
                            self.popUpView2.dropShadow()
                            self.submitBtn.ButtonWithShadow()
                            self.amountTxt.setLeftPaddingPoints(10)
                            self.amountTxt.text = self.amountAfterCalculate
                            self.amountTxt.isUserInteractionEnabled = false
                            
                        }
                    }
                    else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
            }
      }
}
    
    
   func DRIVER_CONFIRM_PICK_UP(VehicleBooking_Id:String,DriverId:String,BoardLatitude:String,BoardLongitude:String,BoardLocation:String) -> Void {

        var json: [String: Any] = [:]
        json["VehicleBookingId"] = VehicleBooking_Id
        json["BoardLatitude"] = BoardLatitude
        json["BoardLocation"] = BoardLocation
        json["BoardLongitude"] = BoardLongitude
        json["DriverId"] = DriverId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_CONFIRM_PICK_UP, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        self.waitingTimeEnable = true
                        self.startTimerAgain = true
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Passenger on Board Successfully", yes: "Ok", onVC: self){
                          self.tripCompletBtn.isHidden = false
                            //self.endTimer()
                            self.endTimer()
                          self.initialMethod()
                        }
                        
                    }else{
                        
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
            }
            
        }
        
    }

    func getWaitingInfoDetail(PriceModelId:String,PFCIId:String,LocationId:String) -> Void {

          var json: [String: Any] = [:]
          json["PriceModelId"] = PriceModelId
          json["PFCIId"] = PFCIId
          json["LocationId"] = LocationId

          DataManager().dataManager(view: self.view, urlStr: UserModule.PickupWaitingChargesInfo, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.getWaitingInfoDetails) { (response, isSuccess) in
              if isSuccess{
                
                let respons = response as! waitingChargeShowModal
                self.getDriverTime = respons.DriverForTimings
                self.TSParkingCharges = respons.TSParkingCharges
                self.DriverParkingCharges = respons.DriverParkingCharges
                
                if (UserDefaults.standard.bool(forKey: ckOnBoard)) == false {
                     self.startTimer(Int(self.getDriverTime)! * 60)
                }
                
                if (UserDefaults.standard.bool(forKey: ckOnBoard)) == true {
                    self.riderNameLib.text! = UserDefaults.standard.string(forKey: "psengerName")!
                    self.dropLocationLib.text! = UserDefaults.standard.string(forKey: "dropAdress")!
                    self.fetchMapData(self.lati, toLog: self.longi, fromLat: self.dropLati, fromLong: self.dropLong)
                    
                 }
             }
        }
   }

    func UpdateWaitingChargesInfo_API(DriverWaitingCharge:String,FileBookingId:String,TSWaitingCharge:String,VehicleBookingId:String) -> Void {

          var json: [String: Any] = [:]
          json["DriverWaitingCharge"] = DriverWaitingCharge
          json["FileBookingId"] = FileBookingId
          json["TSWaitingCharge"] = TSWaitingCharge
          json["VehicleBookingId"] = VehicleBookingId
          DataManager().dataManager(view: self.view, urlStr: UserModule.UpdateWaitingChargesInfo, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.getWaitingInfoDetails) { (response, isSuccess) in
              if isSuccess{
                self.trip_complet_Driver(VehicleBooking_Id: self.VehicleBookingId, DriverId: UserDetail.shared.getUserDriverId(), JobDoneLatitude: "\(self.dropLati)", JobDoneLongitude: "\(self.dropLong)", JobDoneLocation: self.addressString)
              }
        }
}

func ByDriverNotification_API(FileBookingId:String,message:String,driverId:String) -> Void {

          var json: [String: Any] = [:]
          json["FileBookingId"] = FileBookingId
          json["Message"] = message
          json["NotificationId"] = "0"
          json["DriverId"] = driverId

          DataManager().dataManager(view: self.view, urlStr: UserModule.ByDriverNotification, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
              if isSuccess{

                let respons = response as! Array<startJobModal>
                            for dict in respons {
                            if dict.message == "Success" {
                             self.waitingTimeEnable = true

                     }
                                
                  }
     
              }
             
          }
          
      }
}
