//
//  vhicalListingModalClass.swift
//  travelServe
//
//  Created by Developer on 03/08/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


class vhicalListingModalClass: NSObject {
    
     var VehicleId = 0
     var VehicleName = ""
     var MaxPax = 0
     var MaxHandBag = 0
     var MaxBag = 0
     var IsActive : Bool = false
     var CreatedBy = 0
     var AddTime = ""
    var dataCount : Array<AnyObject> = []

    convenience init(response : AnyObject) {
        self.init()
        
       // debugPrint(response)
        
        for item in [response] {
             self.VehicleId = item["VehicleId"] as? Int ?? 0
             self.VehicleName = item["VehicleName"] as? String ?? ""
        }
        
      // debugPrint(self.VehicleId)

    }
}


