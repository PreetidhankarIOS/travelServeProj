//
//  PaymentHistoryModal.swift
//  travelServe
//
//  Created by Developer on 12/08/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

class PaymentHistoryModal:NSObject {
    ////table One data
    
        var Table:Array<Dictionary<String,AnyObject>> = []
        var WeekNo = 0
        var WeekStartDate = ""
        var WeekEndDate = ""
        var TotalBookings = 0
        var TotalAmount = 0
        var dataCountWeek : Array<AnyObject> = []

        var Table1:Array<Dictionary<String,AnyObject>> = []
        var message = ""
        var AckDate = ""
        var BoardDate = ""
        var BookingDate = ""
        var DriverAssignedDate = ""
        var DriverId = 0
        var DriverReceived = 0
        var DriverTotalPrice: Double = 0.0
        var DropLocationName = ""
        var FileBookingId = ""
        var FlightDetail = ""
        var imagepath = ""
        var IsAcknowledged = 0
        var IsBoard = 0
        var IsJobDone = 0
        var JobDoneDate = ""
        var LeadPaxName = ""
        var MaxPax = 0
        var PaymentType = 0
        var PaymentTypeName = ""
        var PickUpTime = ""
        var PickupDate = ""
        var PickupLocationName = ""
        var SpecialRequest = ""
        var totalBag = 0
        var transferBookingId = 0
        var TravelServeTotalPrice:Double = 0.0
        var VehicleBookingId = 0
        var VehicleBookingId1 = 0
        var VehicleId = 0
        var VehicleName = ""
        var Via = 0
        var ContactNo = ""
        var pickupType = ""
    

        var dataCountDetails : Array<AnyObject> = []

        convenience init(response : AnyObject) {
            self.init()
            
            //debugPrint( response)
            self.Table = response["Table"] as! Array<Dictionary<String, AnyObject>>
            
            for item in self.Table {
                let modal = PaymentHistoryModal.init(dict: item as AnyObject)
                    dataCountWeek.append(modal)
            }
            
            
            self.Table1 = response["Table1"] as! Array<Dictionary<String, AnyObject>>
               for item in self.Table1 {
                   let modal = PaymentHistoryModal.init(dictTV1: item as AnyObject)
                       dataCountDetails.append(modal)
               }
        }
    
    convenience init(dict:AnyObject) {
        self.init()
        
        self.WeekNo = dict["WeekNo"]  as? Int ?? 0
        self.WeekStartDate        = dict["WeekStartDate"]  as? String ?? ""
        self.WeekEndDate        = dict["WeekEndDate"]  as? String ?? ""
        self.TotalBookings = dict["TotalBookings"]  as? Int ?? 0
        self.TotalAmount = dict["TotalAmount"]  as? Int ?? 0

    }
    
    
    convenience init(dictTV1:AnyObject) {
        
        self.init()
        self.message = dictTV1["Message"]  as? String ?? ""
        self.AckDate = dictTV1["AckDate"]  as? String ?? ""
        self.BoardDate = dictTV1["BoardDate"]  as? String ?? ""
        self.BookingDate = dictTV1["BookingDate"]  as? String ?? ""
        self.DriverAssignedDate = dictTV1["DriverAssignedDate"]  as? String ?? ""
        self.DriverId = dictTV1["DriverId"]  as? Int ?? 0
        self.DriverReceived = dictTV1["DriverReceived"]  as? Int ?? 0
        self.DriverTotalPrice = dictTV1["DriverTotalPrice"]  as? Double ?? 0.0
        self.DropLocationName = dictTV1["DropLocationName"]  as? String ?? ""
        self.FileBookingId = dictTV1["FileBookingId"]  as? String ?? ""
        self.FlightDetail = dictTV1["FlightDetail"]  as? String ?? ""
        self.imagepath = dictTV1["imagepath"]  as? String ?? ""
        self.IsAcknowledged = dictTV1["IsAcknowledged"]  as? Int ?? 0
        self.IsBoard = dictTV1["IsBoard"]  as? Int ?? 0
        self.IsJobDone = dictTV1["IsJobDone"]  as? Int ?? 0
        self.JobDoneDate = dictTV1["JobDoneDate"]  as? String ?? ""
        self.LeadPaxName = dictTV1["LeadPaxName"]  as? String ?? ""
        self.MaxPax = dictTV1["MaxPax"]  as? Int ?? 0
        self.PaymentType = dictTV1["PaymentType"]  as? Int ?? 0
        self.PaymentTypeName = dictTV1["PaymentTypeName"]  as? String ?? ""
        self.PickUpTime = dictTV1["PickUpTime"]  as? String ?? ""
        self.PickupDate = dictTV1["PickupDate"]  as? String ?? ""
        self.PickupLocationName = dictTV1["PickupLocationName"]  as? String ?? ""
        self.SpecialRequest = dictTV1["SpecialRequest"]  as? String ?? ""
         self.totalBag = dictTV1["totalBag"]  as? Int ?? 0
        self.transferBookingId = dictTV1["transferBookingId"]  as? Int ?? 0
        self.TravelServeTotalPrice = dictTV1["TravelServeTotalPrice"]  as? Double ?? 0.0
         self.VehicleBookingId = dictTV1["VehicleBookingId"]  as? Int ?? 0
        self.VehicleBookingId1 = dictTV1["VehicleBookingId1"]  as? Int ?? 0
        self.VehicleId = dictTV1["VehicleId"]  as? Int ?? 0
        self.VehicleName = dictTV1["VehicleName"]  as? String ?? ""
         self.Via = dictTV1["Via"]  as? Int ?? 0
        self.ContactNo = dictTV1["ContactNo"]  as? String ?? ""
        self.pickupType            = dictTV1["PickupFromTypeName"]  as? String ?? ""
        debugPrint(self.MaxPax)

    }

}

