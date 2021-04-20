//
//  deniedDuty+webServices.swift
//  travelServe
//
//  Created by Developer on 23/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

extension DeniedDutyViewController {
    
    //MARK: listing work Here/////////////////////////////////////////////////////
    
    func DeniedDuty_api(DriverId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] =   DriverId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.GETCANCEL_BOOKING, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.deniedDuty) { (response, isSuccess) in
            if isSuccess{
                
                let responseModal = response as! rideCompleteModalData
                self.dataCountt = responseModal.dataCount

                self.mainTableView.reloadData()
            }
            
        }
        
    }
    
}

