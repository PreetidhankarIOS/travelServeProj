//
//  home+webService.swift
//  travelServe
//
//  Created by Developer on 01/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation



extension homeViewController {
    
    
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

                
                if let slideMenuController = self.slideMenuController() {
                    slideMenuController.openLeft()
                }
               
            }
        }
    }

    
    func START_DEIVER_SHIFT_API(SLatitude:String,DriverId:String,SLongitude:String) -> Void {
        
        
        if UserDetail.shared.getUserCurrentLocationAdress() == "" {
            
            let location = CLLocationCoordinate2D.init(latitude: Double(UserDetail.shared.getUserLat())!, longitude:Double(UserDetail.shared.getUserLong())!)
                   let geocoder = GMSGeocoder()
                   geocoder.reverseGeocodeCoordinate(location) { response, error in
                         guard let address = response?.firstResult(), let lines = address.lines else {
                             return
                         }
            
                        self.addressString = lines.joined(separator: "\n")
                    UserDetail.shared.setUserCurrentLocationAdress(lines.joined(separator: "\n"))
                    
                }

        }
        

        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["SLatitude"] = SLatitude
        json["SLocation"] = UserDetail.shared.getUserCurrentLocationAdress()
        json["SLongitude"] = SLongitude

        DataManager().dataManager(view: self.view, urlStr: UserModule.STARTDEIVER_SHIFT, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.StartDriverShift) { (response, isSuccess) in
            if isSuccess{
                                                                                         
               print("Start DriverShip Call")
              UserDefaults.standard.set(false, forKey: ckStartDeriverShip)
                UserDefaults.standard.set(true, forKey: ckdataAfterLogout)
                
            self.UPDATE_LOCATION_IN_SECOND_API(SLatitude: UserDetail.shared.getUserLat(), DriverId: UserDetail.shared.getUserDriverId(), SLocation:  self.addressString, SLongitude: UserDetail.shared.getUserLong())

            }
            else
            {
                UserDefaults.standard.set(true, forKey: ckStartDeriverShip)

            }
        }
        
    }
    

    func UPDATE_LOCATION_IN_SECOND_API(SLatitude:String,DriverId:String,SLocation:String,SLongitude:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["CurrentLatt"] = SLatitude
        json["CurrentLong"] = SLongitude
        json["CurrentLocation"] = SLocation
        
         UserDefaults.standard.set(true, forKey: upadteForErrorJson)
        DataManager().dataManager(view: self.view, urlStr: UserModule.UPDATE_DRIVER_LOCATION, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.StartDriverShift) { (response, isSuccess) in
            if isSuccess{

                   UserDefaults.standard.set(false, forKey: IsLodingViewInScondeAPI)

               // debugPrint(ckStartDeriverShip)
                
              if (UserDefaults.standard.bool(forKey: ckStartDeriverShip)) == true  {

                     self.START_DEIVER_SHIFT_API(SLatitude: SLatitude, DriverId: UserDetail.shared.getUserDriverId(), SLongitude: SLongitude)
                }

            }
        }   
        
    }
    
    
 func signInWithUserIdAndPassword(_ username:String,_ password:String) -> Void {

            var json: [String: Any] = [:]
            json["Username"] = username
            json["Password"] = password

        DataManager().dataManager(view: self.view, urlStr: UserModule.SIGN_IN, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.signin) { (response, isSuccess) in
            if isSuccess{
                let respons = response as! Array<SignInModalData>
                for dict in respons {
                    if dict.DeviceId == "Not Available"{
                        
                   PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You have been Logged out from the system.", yes: "OK", onVC: self)
                   {
                       
                    self.LogOut_API(ELatitude: UserDetail.shared.getUserLat(), DriverId: UserDetail.shared.getUserDriverId(), ELocation: UserDetail.shared.getUserCurrentLocationAdress(), ELongitude: UserDetail.shared.getUserLong())
                    
                    }
                  }
                }
            }else{
                PDAlert.shared.showAlertWith("Alert!", message: "Server Error", onVC: self)
            }
        }
        
    }

    
 func LogOut_API(ELatitude:String,DriverId:String,ELocation:String,ELongitude:String) -> Void {
     
     var json: [String: Any] = [:]
     json["ELatitude"] = ELatitude
     json["DriverId"] = DriverId
     json["ELongitude"] = ELongitude
     json["ELocation"] = ELocation
    
      
     DataManager().dataManager(view: self.view, urlStr: UserModule.LOG_OUT, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.logOutDriver) { (response, isSuccess) in
         if isSuccess{
           // self.endBackgroundTask()
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
                        //self.mapView.snapshotView(afterScreenUpdates: false)
                         UserDetail.shared.removeUserLat()
                         UserDetail.shared.removeUserLong()

                 let appDelegate = UIApplication.shared.delegate as! AppDelegate
                 appDelegate.loadLoginView()
                 
                 }else{
                     PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                   }
             }
         }
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
