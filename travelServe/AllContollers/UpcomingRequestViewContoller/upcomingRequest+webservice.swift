//
//  upcomingRequest+webservice.swift
//  travelServe
//
//  Created by Developer on 28/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit




extension upcomingRequestViewController {
    
    
    //MARK: listing work Here/////////////////////////////////////////////////////
    
    func upcoming_Rquest_listPage(AccessCode:String,DriverId:String,Password:String,UserName:String) -> Void {
        
            var json: [String: Any] = [:]
            json["AccessCode"] = AccessCode
            json["DriverId"] = DriverId
            json["Password"] = Password
            json["UserName"] = UserName

        DataManager().dataManager(view: self.view, urlStr: UserModule.UPCOMEING_Requstes, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.upcomeingRequest) { (response, isSuccess) in
            if isSuccess{
                let responseModal = response as! upcomingModaldata
                self.dataCountt = responseModal.dataCountHome
                
                for dict in self.dataCountt {
                    
                    let modal = upcomingModaldata.init(dict: dict as AnyObject)
                    if modal.message ==  "No Data Found"{
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You Don't have any booking right now.", yes: "Ok", onVC: self){
                               
                               let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                               self.navigationController?.pushViewController(nextViewController, animated: true)
                                             
                            }
                      }
                    
                 }

                 UserDetail.shared.setUpcomingCount("\(self.dataCountt.count)")
                self.mainTableView.reloadData()
            }
       }
 }
    
    //MARK: Acknowldge_Bookimg_API work Here/////////////////////////////////////////////////////
    
    func Acknowldge_Bookimg_API(ALatitude:String,ALocation:String,ALongitude:String,VehicleBookingId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["ALatitude"] = ALatitude
        json["ALocation"] = ALocation
        json["ALongitude"] = ALongitude
        json["VehicleBookingId"] = VehicleBookingId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_ACKNOWLEDGE, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverAcknowledge) { (response, isSuccess) in
            if isSuccess{
                
                let data  = [response as! DriverAcknowledgeModal]
                for dict in data {
                    if dict.isSucess == true{
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Acknowledge successfully update.", yes: "Ok", onVC: self){
                            
                            let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                        //showAlertWith("Alert!", message: "Acknowledge successfully update.", onVC: self)
                    }
                    else{
                        
                         PDAlert.shared.showAlertWith("Alert!", message: "Acknowledge not update.", onVC: self)
                    }
                }
                self.mainTableView.reloadData()
            }
        }
    }
    //MARK: Cancal on PopUp work Here/////////////////////////////////////////////////////
    
    func Cancel_Bookimg_on_popup_API(Reason:String,fileBooking_id: String) -> Void {
        
        var json: [String: Any] = [:]
        json["Reason"] = Reason
        json["DriverId"] = UserDetail.shared.getUserDriverId()
        json["FileBookingId"] = fileBooking_id

        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_DENIED_BOOKING, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        self.Cancel_Acknowldge_Bookimg_API(ALatitude: self.lati, ALocation: self.addressString, ALongitude: self.longi, VehicleBookingId: "\(self.booking_id)", fileBooking_id: fileBooking_id)
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "You Can not this booking Again", onVC: self)
                    }
                }
            }
        }
    }

//MARK: Cancel_Bookimg_API work Here/////////////////////////////////////////////////////
    
    func Cancel_Acknowldge_Bookimg_API(ALatitude:String,ALocation:String,ALongitude:String,VehicleBookingId:String,fileBooking_id: String) -> Void {
        
        var json: [String: Any] = [:]
        json["CancelLatitude"] = ALatitude
        json["CancelLocation"] = ALocation
        json["CancelLongitude"] = ALongitude
        json["VehicleBookingId"] = VehicleBookingId
        json["DriverId"] = UserDetail.shared.getUserDriverId()
        json["FileBookingId"] = fileBooking_id

        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_CANCEL_BOOKING, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your trip successfully Cancel", yes: "Ok", onVC: self){
                            
                            let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                          
                        }
                        
                    }else{
                        
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
                self.mainTableView.reloadData()
            }
            
        }
        
    }
    
    
    
}
