//
//  rideCompleted+webServices.swift
//  travelServe
//
//  Created by Developer on 03/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit


@available(iOS 13.0, *)
extension RideCompletedViewController {

//MARK: listing work Here/////////////////////////////////////////////////////

func GetPastMobDriver_TransferBooking_api(AccessCode:String,DriverId:String,Password:String,UserName:String) -> Void {
    
    var json: [String: Any] = [:]
    json["AccessCode"] = AccessCode
    json["DriverId"] =   DriverId
    json["Password"] =   Password
    json["UserName"] =   UserName
    
    DataManager().dataManager(view: self.view, urlStr: UserModule.RIDE_COMPLETED, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.completRideAll) { (response, isSuccess) in
        if isSuccess{

            let responseModal = response as! rideCompleteModalData
            self.dataCountt = responseModal.dataCount as! Array<rideCompleteModalData>
            self.mainTableView.reloadData()
        }
        
      self.mainTableView.reloadData()
    }
    
   }
    
    
    func API_Calling_For_UploadAirlineBookingVaucher(){
        
        let dateFormatter : DateFormatter = DateFormatter()
         dateFormatter.dateFormat = "ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        //let currentTimeInMiliseconds = Date().timeIntervalSince1970.milliseconds
        
         debugPrint(dateString)
        
        var json: [String: Any] = [:]
        json["VehicleBookingId"] =   self.VehicleBookingId
        json["VaucherImagePath"] =  self.convertedImage64
        json["VaucherName"] =  "\(dateString)" + ".jpg"
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.UploadAirlineBookingVaucher, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.registration_Image) { (response, isSuccess) in
            if isSuccess{
                let data  = [response as! driverImageUplordModel]
                         for dict in data {
                            if dict.message == "Success" {
                                PDAlert.shared.showAlertWith("Alert!", message: "Attach Voucher Uploaded Successfully", onVC: self)
                            }else{
                             PDAlert.shared.showAlertWith("Alert!", message: dict.message, onVC: self)
                         }
                     }
                }
                self.mainTableView.reloadData()
            }
        }
}

extension Date {

   func today(format : String = "dd-MM-yyyy") -> String{
      let date = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = format
      return formatter.string(from: date)
   }
}
