//
//  vehicleInfornation+webServices.swift
//  travelServe
//
//  Created by Developer on 04/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import Alamofire



extension VehicleInfromationViewController {
//MARK: listing work Here/////////////////////////////////////////////////////

func vehicle_informnation(DriverId:String) -> Void {
    
    var json: [String: Any] = [:]
    json["DriverId"] = DriverId

    
    DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_DETAIL, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverDetails) { (response, isSuccess) in
        if isSuccess{
            self.dataCount = response as! Array<driverDetailsModalClass>
           self.vehicle_Listing()
            self.mainTableView.reloadData()
        }
     }
   }

func vehicle_Listing() -> Void {

    DataManager().dataManager(view: self.view, urlStr: UserModule.VHICAL_LIST, parameter: [:], methodType: "GET", serviceHitId: serviceHitId.vhicalListing) { (response, isSuccess) in
       if isSuccess{

        let respons = response as! Array<vhicalListingModalClass>
        
          for dict in respons {
            let vhicalName = dict.VehicleName
            self.vhicalListData.append(vhicalName)
          }

       }
       else
            {
                PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
            }
       self.mainTableView.reloadData()

    }
    
  }
    
    
    func Update_vehicle_Detals_API() -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = UserDetail.shared.getUserDriverId()

        
        DataManager().dataManager(view: self.view, urlStr: UserModule.UPDATE_VEHICAL_DETAILS, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.updateVhicalDetales) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<updateVehicleInfomationModalClass>
                for dict in respons {
                    if dict.Message == "Success" {
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your Vehicle Information Update successfully", yes: "Ok", onVC: self){
                            
//                            let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                            let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
//                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
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
