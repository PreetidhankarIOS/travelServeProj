//
//  profile+webServices.swift
//  travelServe
//
//  Created by Developer on 01/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage


extension profileViewController {
    
    func driver_informnation(DriverId:String) -> Void {
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId

        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_DETAIL, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverDetails) { (response, isSuccess) in
            if isSuccess{
                self.dataCountf = response as! Array<driverDetailsModalClass>

                if self.dataCountf.count > 0 {
                    
                    let dict = self.dataCountf[0] as driverDetailsModalClass
                    self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
                    self.profileImage.layer.masksToBounds = true
                    let image = dict.driverImage
                    self.profileImage.sd_setImage(with: URL(string: image))
                    self.nameLib.text = "\(dict.FirstName)\(dict.lastName)"
                    self.vehicalNameLib.text  = dict.MobileNo
                    self.firstName = dict.FirstName
                    self.lastName = dict.lastName
                    self.mobileNo = dict.MobileNo
                    self.email_id = dict.emailId
                    self.password = dict.password
                }
                self.mainTableView.reloadData()
            }
        }
}
    func update_Profile_api(Title:String,DriverId:String,Password:String,UserName:String,FirstName:String,LastName:String,Mobile1:String,DeviceId:String,DOB:String,Email:String,Mobile:String) -> Void {
        
        var json: [String: Any] = [:]
        json["Title"] = Title
        json["DriverId"] =   DriverId
        json["Password"] =   Password
        json["UserName"] =   UserName
        json["FirstName"] =  FirstName
        json["LastName"] =   LastName
        json["DOB"] =        DOB
        json["Email"] =      Email
        json["Mobile"] =     Mobile
        json["Mobile1"] =    Mobile1
        json["DeviceId"] =   DeviceId
        json["Check"] =      "e"
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.UPDATE_PROFILE, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverDetails) { (response, isSuccess) in
            if isSuccess{

                self.dataCountu = response as! Array<driverDetailsModalClass>
                if self.dataCountu.count > 0 {
                let dict = self.dataCountu[0] as driverDetailsModalClass
                if dict.message == "Success"{
                    
                    PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Profile Updated Successfully", yes: "Ok", onVC: self){
                      
                        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }
                }else{
                     PDAlert.shared.showAlertWith("Alert!", message: dict.message, onVC: self)
                  }
                }
                self.mainTableView.reloadData()
            }
        }
        
    }
    
    func API_Calling_For_SaveUserProfileData(){

        var json: [String: Any] = [:]
        json["DriverId"] =   UserDetail.shared.getUserDriverId()
        json["DriverImage"] =   self.convertedImage64
        json["DriverImageName"] =  "Profile_Image.jpg"
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.UPDATE_PROFILE_IMAGE, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.registration_Image) { (response, isSuccess) in
            if isSuccess{

               // let responsnew = response as! Array<driverImageUplordModel>
                let data  = [response as! driverImageUplordModel]
                   
                         for dict in data {
                            if dict.message == "Success" {
                                
                                PDAlert.shared.showAlertWith("Alert!", message: "Profile pic Updated Successfully", onVC: self)
                                 UserDetail.shared.setUserImage("\(self.saveChosenImage)")
                                
                            }else{
                                PDAlert.shared.showAlertWith("Alert!", message: dict.message, onVC: self)
                            }
                    }

                }
                self.mainTableView.reloadData()
            }
        }

}

