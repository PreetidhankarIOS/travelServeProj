//
//  signUpModalData.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


class signUpModalData {
    
    var AccessCode = 0
    var message = ""
    var status = 0
    var IsParent = ""
    var DriverId : NSNumber = 0
    var AirportCityId = ""
    var DepartmentId = ""
    var DesignationId = ""
    var UserName = ""
    var Password = ""
    var EmailId = ""
    var Title = ""
    var FirstName = ""
    var LastName = ""
    var CheckIP = ""
    var IsActive = ""
    var Profit = ""
    var Cost = ""
    var BranchCode = ""
    var CountryCode = ""
    
    
    
    convenience init(response : AnyObject) {
        self.init()
        
        debugPrint(response)
        self.message = response["Message"] as? String ?? ""
        
        
    }
    
}
