//
//  menuView+webServices.swift
//  travelServe
//
//  Created by Developer on 19/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps



extension menuViewController {
    
   
    
    func upcoming_Rquest_listPage_Menu(AccessCode:String,DriverId:String,Password:String,UserName:String) -> Void {
        
        var json: [String: Any] = [:]
        json["AccessCode"] = AccessCode
        json["DriverId"] = DriverId
        json["Password"] = Password
        json["UserName"] = UserName
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.UPCOMEING_Requstes, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.upcomeingRequest) { (response, isSuccess) in
            if isSuccess{
                
                let responseModal = response as! upcomingModaldata
                self.dataCounttForCount = responseModal.dataCountHome
                self.dataCounttForJobQue = responseModal.dataCountAcknowlege
                
                UserDetail.shared.setJobQueCount("\(self.dataCounttForJobQue.count)")
                UserDetail.shared.setUpcomingCount("\(self.dataCounttForCount.count)")
                
                DispatchQueue.main.async { self.mainTableView.reloadData() }
            }
            //DispatchQueue.main.async { self.mainTableView.reloadData() }
        }
    }
    //MARK: deriver Active work Here/////////////////////////////////////////////////////
    
    func ACTIVE_DRIVER_API(DriverId:String,ALocation:String,ALongitude:String,ALatitude:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["ALatitude"] = ALatitude
        json["ALongitude"] = ALongitude
        json["ALocation"] = ALocation

        DataManager().dataManager(view: self.view, urlStr: UserModule.ACTIVE_DRIVER, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.startDriverJob) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success"{
                        
                      //PDAlert.shared.showAlertWith("Alert!", message: "You Are Online", onVC: self)
                        
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
            }
            
        }
        
    }
    
    func IN_ACTIVE_DRIVER_API(DriverId:String,ALocation:String,ALongitude:String,ALatitude:String) -> Void {
        
        var json: [String: Any] = [:]
        
        json["DriverId"] = DriverId
        json["ALatitude"] = ALatitude
        json["ALongitude"] = ALongitude
        json["ALocation"] = ALocation
        
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.IN_ACTIVE_DRIVER, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.startDriverJob) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success"{
                        
                        PDAlert.shared.showAlertWith("Alert!", message: "You Are Offline", onVC: self)
                        
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
 
            }
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
            
            if lati == "" || longi == ""  {
                
                forLocationAddress(UserDetail.shared.getUserLat(), longti: UserDetail.shared.getUserLong())
                
            }else{
                
                forLocationAddress(lati, longti: longi)
            }
            
            //forLocationAddress ()
        }
    }
 
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//            let location = locationManager.location?.coordinate
//            cameraMoveToLocation(toLocation: location)
//
//
//    }
    
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        
        if toLocation != nil {

            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(toLocation!) { response, error in
                guard let address = response?.firstResult(), let lines = address.lines else {
                    return
                }
                debugPrint(address)
               //lines.joined(separator: "\n")
                
                }

            }
            
            

    }
    
    
    func forLocationAddress (_ latit: String, longti: String) {
        
       // APIDataSource.fetchAddressComponentFromGoogleMapAPI(latitude: Double(latit) ??  0.0, lontitude:Double(longti) ??  0.0, handler: { (citiName, stateName, countryName, localaddress) in
            
        self.addressString = UserDetail.shared.getUserCurrentLocationAdress()

            self.ACTIVE_DRIVER_API(DriverId: UserDetail.shared.getUserDriverId(), ALocation: self.addressString, ALongitude: self.longi, ALatitude: self.lati)
            
            //debugPrint("\(localaddress) ")
            
        //})
        
    }
    
    
    func LogOut_API(ELatitude:String,DriverId:String,ELocation:String,ELongitude:String) -> Void {
        self.endBackgroundTask()
        var json: [String: Any] = [:]
        json["ELatitude"] = ELatitude
        json["DriverId"] = DriverId
        json["ELongitude"] = ELongitude
        json["ELocation"] = ELocation
        self.stopTimer()
        DataManager().dataManager(view: self.view, urlStr: UserModule.LOG_OUT, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.logOutDriver) { (response, isSuccess) in
            if isSuccess{
               //endBackgroundTask()
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        
                            UserDefaults.standard.removeObject(forKey: KeyMain)
                            UserDefaults.standard.set(false, forKey: ckStartDeriverShip)
                            UserDetail.shared.removePoolJobCount()
                            UserDefaults.standard.synchronize()
                            UserDetail.shared.removeUserDriverId()
                            UserDefaults.standard.set(false, forKey: IsLodingViewInScondeAPI)
                            UserDefaults.standard.set(false, forKey: logoutBackgroundNotification)
                            UserDetail.shared.removeUserLat()
                            UserDetail.shared.removeUserLong()
                        //self.locationManager.stopUpdatingLocation()
                       // UserDefaults.standard.removeObject(forKey: ckdataAfterLogout)
                          UserDefaults.standard.set(false, forKey: ckdataAfterLogout)
                   
                        if (UserDefaults.standard.bool(forKey: logoutBackgroundNotification)) == false  {
                        
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.loadLoginView()
                            
                        }
                        
                        else
                         {
                            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window?.rootViewController = redViewController
                        }

                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                      }
                }
            }
           
        }
    }
  
    func stopTimer() {

        if   AppDelegate.sharedInstance().timer != nil {
            AppDelegate.sharedInstance().timer!.invalidate()
            AppDelegate.sharedInstance().timer == nil
        }
    }
    

    
func jobPool_informnation(DriverId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.JOBPOOL, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.poolJob) { (response, isSuccess) in
            if isSuccess{
                
                UserDetail.shared.removePoolJobCount()
                let responseModal = response as! poolJobsModalData
               
                self.dataCountForJobPool = responseModal.Table
                
                for item in self.dataCountForJobPool {
                           
                        let modal = poolJobsModalData.init(dict: item as AnyObject)
                           
                   if modal.messagee == "No Data Found" {
    
                       UserDetail.shared.setpoolJobCount("\(0)")
                       debugPrint("\(responseModal.PoolJobsdataCount.count)")
    
                   }else{
    
                       UserDetail.shared.setpoolJobCount("\(responseModal.PoolJobsdataCount.count)")
                       debugPrint("\(responseModal.PoolJobsdataCount.count)")
                   }
    
                       
                }

            }
           
        }
    }
    
    
}


