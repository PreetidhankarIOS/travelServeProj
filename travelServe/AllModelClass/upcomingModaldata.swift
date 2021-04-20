//
//  upcomingModaldata.swift
//  travelServe
//
//  Created by Developer on 29/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation



class upcomingModaldata:NSObject {

      var isStartJob = Bool()
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
      var PriceModelId = 0
      var PFCIId = 0
      var LocationId = 0
     var pickupType = ""
      var dataCount : Array<AnyObject> = []
      var dataCountHome : Array<AnyObject> = []
      var dataCountAcknowlege : Array<AnyObject> = []
      var PoolJobsdataCount : Array<AnyObject> = []
      var PoolJobsdataCountMy : Array<AnyObject> = []

    convenience init(response : AnyObject) {
        self.init()
        self.Table = response["Table"] as! Array<Dictionary<String, AnyObject>>
    debugPrint(response)
        
        for item in self.Table {
            
            
            let modal = upcomingModaldata.init(dict: item as AnyObject)

            if modal.IsAcknowledged == true {
               dataCountAcknowlege.append(modal)
            }else{
                 dataCount.append(modal)

                if modal.message == "Success" {
                    dataCountHome.append(modal)
                }else{
                    dataCountHome.count == 0
                }
            }

            if modal.statusJobPool == 0 {
                PoolJobsdataCount.append(modal)
            } else {
                PoolJobsdataCountMy.append(modal)
            }
        }
    }

    convenience init(dict:AnyObject) {
        
        self.init()
        
                    self.message               = dict["Message"]             as? String ?? ""
                    self.BookingDate           = dict["BookingDate"]         as? String ?? ""
                    self.ContactNo             = dict["ContactNo"]           as? String ?? ""
                    self.DriverAssignedDate    = dict["DriverAssignedDate"]  as? String ?? ""
                    self.DriverId              = dict["DriverId"]            as? Int ?? 0
                    self.DropLocationName      = dict["DropLocationName"]    as? String ?? ""
                    self.FileBookingId         = dict["FileBookingId"]       as? String ?? ""
                    self.FlightDetail          = dict["FlightDetail"]        as? String ?? ""
                    self.Imagepath             = dict["Imagepath"]           as? String ?? ""
                    self.IsAcknowledged        = dict["IsAcknowledged"]      as? Bool ?? false
                    self.IsBoard               = dict["IsBoard"]             as? String ?? ""
                    self.IsJobDone             = dict["IsJobDone"]           as? String ?? ""
                    self.LeadPaxName           = dict["LeadPaxName"]         as? String ?? ""
                    self.PaymentType           = dict["PaymentType"]         as? Int ?? 0
                    self.PaymentTypeName       = dict["PaymentTypeName"]     as? String ?? ""
                    self.PickUpTime            = dict["PickUpTime"]          as? String ?? ""
                    self.PickupDate            = dict["PickupDate"]          as? String ?? ""
                    self.PickupLocationName    = dict["PickupLocationName"]  as? String ?? ""
                    self.TotalBag              = dict["TotalBag"]            as? Int ?? 0
                    self.TransferBookingId     = dict["TransferBookingId"]   as? Int ?? 0
                    self.TravelServeTotalPrice = dict["TravelServeTotalPrice"]  as? Double ?? 0.0
                    self.DriverTotalPriceNew   = dict["DriverTotalPrice"]       as? Double ?? 0.0
                    self.VehicleBookingId      = dict["VehicleBookingId"]       as? Int ?? 0
                    self.VehicleBookingId1     = dict["VehicleBookingId1"]      as? Int ?? 0
                    self.VehicleId             = dict["VehicleId"]              as? String ?? ""
                    self.VehicleName           = dict["VehicleName"]            as? String ?? ""
                    self.max                   = dict["MaxPax"]                 as? Int ?? 0
                    self.SpecialRequest        = dict["SpecialRequest"]         as? String ?? ""
                    self.isStartJob            = dict["IsStrtJob"]              as? Bool ?? false
                    self.statusJobPool         = dict["status"]                 as? Int ?? 0
                    self.PFCIId                = dict["PFCIId"]                 as? Int ?? 0
                    self.LocationId            = dict["LocationId"]             as? Int ?? 0
                    self.PriceModelId          = dict["PriceModelId"]           as? Int ?? 0
                    self.pickupType            = dict["PickupFromTypeName"]     as? String ?? ""
                   //debugPrint(self.pickupType)

    }

}


//    Table =     (
//        {
//            BookingDate = "2019-07-01T07:41:37.837Z";
//            ContactNo = 4544684;
//            DriverAssignedDate = "2019-07-01T07:41:37.847Z";
//            DriverId = 42;
//            DropLocationName = "Sector 18, Noida, Uttar Pradesh, India";
//            FileBookingId = TSL17166;
//            FlightDetail = undefined;
//            Imagepath = "Content/img/Vehicle/11122018120846.jpg";
//            IsAcknowledged = 0;
//            IsBoard = 0;
//            IsJobDone = 0;
//            LeadPaxName = raaaj;
//            MaxPax = 1;
//            PaymentType = 1;
//            PaymentTypeName = Account;
//            PickUpTime = "07:45";
//            PickupDate = "2019-07-01T00:00:00Z";
//            PickupLocationName = "Sector 63, Noida, Uttar Pradesh, India";
//            TotalBag = 2;
//            TransferBookingId = 150;
//            TravelServeTotalPrice = "33.6";
//            VehicleBookingId = 214;
//            VehicleBookingId1 = 214;
//            VehicleId = 1;
//            VehicleName = Saloon;
//            Via = 0;
//        }
//    );

