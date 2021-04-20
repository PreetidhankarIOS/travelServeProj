//
//  driverStatementModal.swift
//  travelServe
//
//  Created by Developer on 28/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit

class driverStatementModal:NSObject {
    ////table One data
    
    var Table1:Array<Dictionary<String,AnyObject>> = []
    var TotalSales: Double = 0.0
    var TotalCash : Double = 0.0
    var TotalCard : Double = 0.0
    var TotalAccount : Double = 0.0
    var CommissionOnCash : Double = 0.0
    var CommissionOnCard: Double = 0.0
    var CommissionOnAccount: Double = 0.0
    var CommissionToTSL: Double = 0.0
    var PaymentFromTSL: Double = 0.0
    var DriverEarnings: Double = 0.0
    var dataCountDriverData : Array<AnyObject> = []


    
    var Table:Array<Dictionary<String,AnyObject>> = []
    var message = ""
    var FileBookingId = ""
    var LeadPaxName = ""
    var TotalBag = 0
    var TotalPax = 0
    var PickUpTime = ""
    var PickupDate = ""
    var PickupLocationName = ""
    var DropLocationName = ""
    var VehicleName = ""
    var PaymentTypeName = ""
    var TravelServeTotalPrice: Double = 0.0
    var DriverName = ""
    var VehicleBookingId = 0
    var dataCountListData : Array<AnyObject> = []
    var StatementStatus = ""
    var StatementQuery = ""
    var notRequtestdataCountListData : Array<AnyObject> = []
    var pickupType = ""
    var ContactNo = ""
    
    convenience init(response : AnyObject) {
        self.init()
        debugPrint(response)
        self.Table = response["Table"] as! Array<Dictionary<String, AnyObject>>
        for item in self.Table {
            let modal = driverStatementModal.init(dictList: item as AnyObject)
            dataCountListData.append(modal)
            
            if modal.message == "Success"{
               
                if modal.StatementStatus == "No Request"{
                    
                    let modal = driverStatementModal.init(dictList: item as AnyObject)
                    notRequtestdataCountListData.append(modal)
                }
        }
    }

            self.Table1 = response["Table1"] as! Array<Dictionary<String, AnyObject>>
            
            for item in self.Table1 {
                
                let modal = driverStatementModal.init(dict: item as AnyObject)
                dataCountDriverData.append(modal)
                
        }
        

    }
    
    convenience init(dict:AnyObject) {
        self.init()
        
         self.TotalSales = dict["TotalSales"]  as? Double ?? 0.0
         self.TotalCash = dict["TotalCash"]  as? Double ?? 0.0
         self.TotalCard = dict["TotalCard"]  as? Double ?? 0.0
         self.TotalAccount = dict["TotalAccount"]  as? Double ?? 0.0
         self.CommissionOnCash = dict["CommissionOnCash"]  as? Double ?? 0.0
         self.CommissionOnCard = dict["CommissionOnCard"]  as? Double ?? 0.0
         self.CommissionOnAccount = dict["CommissionOnAccount"] as? Double ?? 0.0
         self.CommissionToTSL = dict["CommissionToTSL"]  as? Double ?? 0.0
         self.PaymentFromTSL = dict["PaymentFromTSL"]  as? Double ?? 0.0
         self.DriverEarnings = dict["DriverEarnings"]  as? Double ?? 0.0
       
        
    }
    
    
    convenience init(dictList:AnyObject) {
        self.init()
        
         self.message                = dictList["message"]  as? String ?? ""
         self.FileBookingId          = dictList["FileBookingId"]  as? String ?? ""
         self.LeadPaxName            = dictList["LeadPaxName"]  as? String ?? ""
         self.TotalBag               = dictList["TotalBag"]  as? Int ?? 0
         self.TotalPax               = dictList["TotalPax"]  as? Int ?? 0
         self.PickUpTime             = dictList["PickUpTime"]  as? String ?? ""
         self.PickupDate             = dictList["PickupDate"] as? String ?? ""
         self.PickupLocationName     = dictList["PickupLocationName"] as? String ?? ""
         self.DropLocationName       = dictList["DropLocationName"]  as? String ?? ""
         self.VehicleName            = dictList["VehicleName"]  as? String ?? ""
         self.PaymentTypeName        = dictList["PaymentTypeName"]  as? String ?? ""
         self.TravelServeTotalPrice  = dictList["TravelServeTotalPrice"]  as? Double ?? 0.0
         self.DriverName             = dictList["DriverName"]  as? String ?? ""
         self.VehicleBookingId       = dictList["VehicleBookingId"]  as? Int ?? 0
         self.StatementStatus        = dictList["StatementStatus"]  as? String ?? ""
         self.StatementQuery         = dictList["StatementQuery"]  as? String ?? ""
         self.pickupType            = dictList["PickupFromTypeName"]      as? String ?? ""
         self.ContactNo             = dictList["ContactNo"]           as? String ?? ""
       //debugPrint(self.StatementStatus)

    }
}

 
