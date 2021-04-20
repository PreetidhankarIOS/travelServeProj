//
//  loginView+webServices.swift
//  travelServe
//
//  Created by Developer on 25/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import GoogleMaps


extension loginViewController {

    //MARK: NormalLogin work Here/////////////////////////////////////////////////////
    
    func signInWithUserIdAndPassword(_ username:String,_ password:String) -> Void {

            var json: [String: Any] = [:]
            json["Username"] = username
            json["Password"] = password

        DataManager().dataManager(view: self.view, urlStr: UserModule.SIGN_IN, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.signin) { (response, isSuccess) in
            if isSuccess{
                let respons = response as! Array<SignInModalData>
                for dict in respons {

                    if dict.message == "User Successfully login"{
                        
                        if dict.DeviceId == "Not Available"{
                           UserDetail.shared.setUserDriverId("\(dict.DriverId)")
                           UserDetail.shared.setUserName("\(dict.UserName)")
                           UserDetail.shared.setUserPassword("\(dict.Password)")
                           UserDetail.shared.setAccessCodeId("\(dict.AccessCode)")
                           UserDetail.shared.setUserFirstName("\(dict.FirstName) \(dict.LastName)")
                           UserDetail.shared.setUserImage("\(dict.userImage)")
                           UserDefaults.standard.set(true, forKey: KeyMain)
                              self.AddMobDeviceId_API("\(dict.DriverId)")
                            
                        }else{

                             PDAlert.shared.showAlertWith("Alert!", message: "You have logged in another device. Please contact support ", onVC: self)
                        }

                        }else if dict.message == "Invalid UserName and Password"{
                        PDAlert.shared.showAlertWith("Alert!", message: dict.message, onVC: self)
                    }
                }
            }else{
                
               // mummua :- 7037343921
                
            }
        }
        
    }

    func AddMobDeviceId_API(_ driverId:String) -> Void {

        let modelName = UIDevice.modelName
        let systemVersion = UIDevice.current.systemVersion
        
        let deviceName = "\(modelName) \(systemVersion)"
        
        var json: [String: Any] = [:]
        json["DriverId"] = driverId
        json["DeviceType"] = "1"
        json["DeviceId"] = UserDetail.shared.getToken_Id()
        json["DeviceName"]  = deviceName
        DataManager().dataManager(view: self.view, urlStr: UserModule.ADD_MOB_DEVICEID, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.signin) { (response, isSuccess) in
            if isSuccess{
                let respons = response as! Array<SignInModalData>
                for dict in respons {
                    if dict.message == "Success"{
                        UserDefaults.standard.set(true, forKey: ckStartDeriverShip)
//                        if self.addressString == ""{
//                            self.curentLocationGet()
//                        }else{
                            self.goToNextViewContoller()
                       // }
                    }
                }
            }else{
                PDAlert.shared.showAlertWith("Alert!", message: "Server Error", onVC: self)
            }
        }
        
    }
    
    
func curentLocationGet(){
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
            if let lat = currentLocation?.coordinate.latitude{
                lati = "\(lat) login lat"
                debugPrint(lati)
                UserDetail.shared.setUserLat(lati)
            }
            if let lng = currentLocation?.coordinate.longitude{
                longi = "\(lng) loing long "
                debugPrint(longi)
                UserDetail.shared.setUserLat(longi)
            }
            let location = CLLocationCoordinate2D.init(latitude: (currentLocation?.coordinate.latitude)!, longitude:(currentLocation?.coordinate.longitude)!)
            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(location) { response, error in
                  guard let address = response?.firstResult(), let lines = address.lines else {
                      return
                  }

                 UserDetail.shared.setUserCurrentLocationAdress(lines.joined(separator: "\n"))
                 self.addressString = lines.joined(separator: "\n")
         }
            
            
        }
      

    }



}
