//
//  updateVehicleInfomationModalClass.swift
//  travelServe
//
//  Created by Developer on 05/08/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

class updateVehicleInfomationModalClass: NSObject {
    
    var UserId = 0
    var Message = ""
    var IsSuccess : Bool = false
    
    var dataCount : Array<AnyObject> = []
    
    convenience init(response : AnyObject) {
        self.init()
        
       // debugPrint(response)
        
        for item in [response] {
            
             self.UserId = item["VehicleId"] as? Int ?? 0
             self.IsSuccess     = item["IsAcknowledged"]  as? Bool ?? false
             self.Message = item["Message"] as? String ?? ""
        }
        
        // debugPrint(self.VehicleId)
        
    }
}
