//
//  rideCompleteModalData.swift
//  travelServe
//
//  Created by Developer on 04/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


class rideCompleteModalData {
    
    
    var message = ""
    var Table:Array<Dictionary<String,AnyObject>> = []
    var BookingDate = ""
    var ContactNo = ""
    var DriverAssignedDate = ""
    var DriverId = 0
    var DropLocationName = ""
    var FileBookingId = ""
    var FlightDetail = ""
    var Imagepath = ""
    var IsAcknowledged = ""
    var IsBoard = ""
    var IsJobDone = ""
    var LeadPaxName = ""
    var PaymentType = 0
    var PaymentTypeName = ""
    var PickUpTime = ""
    var PickupDate = ""
    var PickupLocationName = ""
    var TotalBag = 0
    var TransferBookingId = ""
    var TravelServeTotalPrice: Double = 0.0
    var VehicleBookingId = 0
    var VehicleBookingId1 = 0
    var VehicleId = ""
    var VehicleName = ""
    var SpecialRequest = ""
    var max = 0
    var DriverTotalPriceNew: Double = 0.0
    var JobDoneDate = ""
    var pickupType = ""
    var dataCount : Array<AnyObject> = []
    
    convenience init(response : AnyObject) {
        self.init()
        self.Table = response["Table"] as! Array<Dictionary<String, AnyObject>>
        for item in self.Table {
            let modal = rideCompleteModalData.init(dict: item as AnyObject)
            dataCount.append(modal)
        }

    }
   
    convenience init(dict:AnyObject) {
        self.init()
        
            self.message =  dict["Message"]  as? String ?? ""
            self.BookingDate = dict["BookingDate"]  as? String ?? ""
            self.ContactNo = dict["ContactNo"]  as? String ?? ""
            self.DriverAssignedDate = dict["DriverAssignedDate"]  as? String ?? ""
            self.DriverId = dict["BookingDate"]  as? Int ?? 0
            self.DropLocationName = dict["DropLocationName"]  as? String ?? ""
            self.FileBookingId = dict["FileBookingId"]  as? String ?? ""
            self.FlightDetail = dict["FlightDetail"]  as? String ?? ""
            self.Imagepath = dict["Imagepath"]  as? String ?? ""
            self.IsAcknowledged = dict["IsAcknowledged"]  as? String ?? ""
            self.IsBoard = dict["IsBoard"]  as? String ?? ""
            self.IsJobDone = dict["IsJobDone"]  as? String ?? ""
            self.LeadPaxName = dict["LeadPaxName"]  as? String ?? ""
            self.PaymentType = dict["PaymentType"]  as? Int ?? 0
            self.PaymentTypeName = dict["PaymentTypeName"]  as? String ?? ""
            self.PickUpTime = dict["PickUpTime"]  as? String ?? ""
            self.PickupDate = dict["PickupDate"]  as? String ?? ""
            self.PickupLocationName = dict["PickupLocationName"]  as? String ?? ""
            self.TotalBag = dict["TotalBag"]  as? Int ?? 0
            self.TransferBookingId = dict["TransferBookingId"]  as? String ?? ""
            self.TravelServeTotalPrice = dict["TravelServeTotalPrice"]  as? Double ?? 0.0
            self.VehicleBookingId = dict["VehicleBookingId"]  as? Int ?? 0
            self.VehicleBookingId1 = dict["VehicleBookingId1"]  as? Int ?? 0
            self.VehicleId = dict["VehicleId"]  as? String ?? ""
            self.VehicleName = dict["VehicleName"]  as? String ?? ""
            self.max = dict["MaxPax"]  as? Int ?? 0
            self.SpecialRequest     = dict["SpecialRequest"] as? String ?? ""
            self.DriverTotalPriceNew  = dict["DriverTotalPrice"]  as? Double ?? 0.0
            self.JobDoneDate          = dict["JobDoneDate"] as? String ?? ""
            self.pickupType            = dict["PickupFromTypeName"]      as? String ?? ""
        //debugPrint(VehicleBookingId)
    }
}

