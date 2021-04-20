//
//  waitingChargeShowModal.swift
//  travelServe
//
//  Created by Developer on 01/11/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

class waitingChargeShowModal:NSObject {
    
    
    var DriverForTimings = ""
    var DriverParkingCharges = 0
    var LocationId = 0
    var PFCIId = 0
    var PriceModelId = 0
    var TSForTimings = 0
    var TSParkingCharges = 0
     
    
    
    convenience init(response : AnyObject) {
        self.init()
       

        debugPrint(response)
  
          self.DriverForTimings       = response["DriverForTimings"]  as? String ?? ""
          self.DriverParkingCharges   = response["DriverParkingCharges"]  as? Int ?? 0
          self.LocationId             = response["LocationId"]  as? Int ?? 0
          self.PFCIId                 = response["PFCIId"]  as? Int ?? 0
          self.PriceModelId           = response["PriceModelId"]  as? Int ?? 0
          self.TSForTimings           = response["TSForTimings"]  as? Int ?? 0
          self.TSParkingCharges       = response["TSParkingCharges"]   as? Int ?? 0

        debugPrint(self.DriverForTimings)
    }
}
