//
//  poolJobsModalData.swift
//  travelServe
//
//  Created by Developer on 26/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


class poolJobsModalData:NSObject {
    
    
    var isStartJob = Bool()
    var messagee = ""
    var Table:Array<Dictionary<String,AnyObject>> = []
    var BookingDate = ""
    var ContactNo = ""
    var DriverAssignedDate = ""
    var DriverId = 0
    var DropLocationName = ""
    var FileBookingId = ""
    var FlightDetail = ""
    var Imagepath = ""
    var IsAcknowledged: Bool = false
    var IsBoard = ""
    var IsJobDone = ""
    var LeadPaxName = ""
    var PaymentType = 0
    var PaymentTypeName = ""
    var PickUpTime = ""
    var PickupDate = ""
    var PickupLocationName = ""
    var TotalBag = 0
    var TransferBookingId = 0
    var TravelServeTotalPrice: Double = 0.0
    var VehicleBookingId = 0
    var VehicleBookingId1 = 0
    var VehicleId = ""
    var VehicleName = ""
    var SpecialRequest = ""
    var max = 0
    var statusJobPool = 0
    var DriverTotalPriceNew: Double = 0.0
    var RequestCount = 0
    var PoolJobsdataCount : Array<AnyObject> = []
    var PoolJobsdataCountMy : Array<AnyObject> = []
    var pickupType = ""
    convenience init(response : AnyObject) {
        self.init()

        
        self.Table = response["Table"] as! Array<Dictionary<String, AnyObject>>
        debugPrint(response)

        for item in self.Table {
            
            let modal = poolJobsModalData.init(dict: item as AnyObject)
            
            if modal.statusJobPool == 0 {
                PoolJobsdataCount.append(modal)
            } else if modal.statusJobPool != 0 {
                PoolJobsdataCountMy.append(modal)
            }
        }
}
    
    convenience init(dict:AnyObject) {
        self.init()
        
        self.messagee            = dict["Message"]  as? String ?? ""
        self.BookingDate        = dict["BookingDate"]  as? String ?? ""
        self.ContactNo          = dict["ContactNo"]  as? String ?? ""
        self.DriverAssignedDate = dict["DriverAssignedDate"]  as? String ?? ""
        self.DriverId           = dict["DriverId"]  as? Int ?? 0
        self.DropLocationName   = dict["DropLocationName"]  as? String ?? ""
        self.FileBookingId      = dict["FileBookingId"]  as? String ?? ""
        self.FlightDetail       = dict["FlightDetail"]  as? String ?? ""
        self.Imagepath          = dict["Imagepath"]  as? String ?? ""
        self.IsAcknowledged     = dict["IsAcknowledged"]  as? Bool ?? false
        self.IsBoard            = dict["IsBoard"]  as? String ?? ""
        self.IsJobDone          = dict["IsJobDone"]  as? String ?? ""
        self.LeadPaxName        = dict["LeadPaxName"]  as? String ?? ""
        self.PaymentType        = dict["PaymentType"]  as? Int ?? 0
        self.PaymentTypeName    = dict["PaymentTypeName"]  as? String ?? ""
        self.PickUpTime         = dict["PickUpTime"]  as? String ?? ""
        self.PickupDate         = dict["PickupDate"]  as? String ?? ""
        self.PickupLocationName = dict["PickupLocationName"]  as? String ?? ""
        self.TotalBag           = dict["TotalBag"]  as? Int ?? 0
        self.TransferBookingId  = dict["TransferBookingId"]  as? Int ?? 0
        self.TravelServeTotalPrice = dict["TravelServeTotalPrice"]  as? Double ?? 0.0
        self.VehicleBookingId   = dict["VehicleBookingId"]  as? Int ?? 0
        self.VehicleBookingId1  = dict["VehicleBookingId1"]  as? Int ?? 0
        self.VehicleId          = dict["VehicleId"]  as? String ?? ""
        self.VehicleName        = dict["VehicleName"]  as? String ?? ""
        self.max                = dict["MaxPax"]  as? Int ?? 0
        self.SpecialRequest     = dict["SpecialRequest"] as? String ?? ""
        self.isStartJob         = dict["IsStrtJob"] as? Bool ?? false
        self.statusJobPool      = dict["Status"]  as? Int ?? 0
        self.RequestCount      = dict["RequestCount"]  as? Int ?? 0
        self.DriverTotalPriceNew = dict["DriverTotalPrice"]  as? Double ?? 0.0
        self.pickupType            = dict["PickupFromTypeName"]      as? String ?? ""
        //debugPrint(self.message)
            
    }
    
}
