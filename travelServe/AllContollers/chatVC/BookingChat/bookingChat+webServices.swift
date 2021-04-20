//
//  bookingChat+webServices.swift
//  travelServe
//
//  Created by Developer on 19/10/2019.
//  Copyright © 2019 UV Soft & Tech. All rights reserved.
//

import Foundation


extension bookingChatViewController {


func chat_Booking_List(driiverId:String) -> Void {
    
    var json: [String: Any] = [:]
    json["DriverId"] = driiverId

    
    DataManager().dataManager(view: self.view, urlStr: UserModule.GETBOOKINGCHATLIST, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.completRideAll) { (response, isSuccess) in
        
        if isSuccess{
            let responseModal = response as! rideCompleteModalData
            self.dataCountt = responseModal.dataCount as! Array<rideCompleteModalData>
            self.filteredData = responseModal.dataCount as! Array<rideCompleteModalData>
        }
          self.mainTableView.reloadData()
       }
   
    }

}


