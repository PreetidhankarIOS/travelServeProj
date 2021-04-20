//
//  SignInModalData.swift
//  travelServe
//
//  Created by Developer on 25/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//


import UIKit

class SignInModalData {
    
    var AccessCode = 0
    var message = ""
    var status = 0
    var IsParent = ""
    var DriverId  = 0
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
    var CityCode = ""
    var CurrencyCode = ""
    var userImage = ""
    var DeviceId = ""
    convenience init(response : AnyObject) {
        self.init()
        
       // debugPrint(response)
          self.message = response["Message"] as? String ?? ""
          self.DeviceId = response["DeviceId"] as? String ?? ""
          self.AccessCode = response["AccessCode"] as? Int ?? 0
          self.status = response["Status"] as? Int ?? 0
          self.IsParent = response["IsParent"] as? String ?? ""
          self.DriverId = response["DriverId"] as? Int ?? 0
          self.AirportCityId = response["AirportCityId"] as? String ?? ""
          self.DepartmentId = response["DepartmentId"] as? String ?? ""
          self.DesignationId = response["DesignationId"] as? String ?? ""
          self.UserName = response["UserName"] as? String ?? ""
          self.Password = response["Password"] as? String ?? ""
          self.EmailId = response["EmailId"] as? String ?? ""
          self.Title = response["Title"] as? String ?? ""
          self.FirstName = response["FirstName"] as? String ?? ""
          self.LastName = response["LastName"] as? String ?? ""
          self.CheckIP = response["CheckIP"] as? String ?? ""
          self.IsActive = response["IsActive"] as? String ?? ""
         self.Profit = response["Profit"] as? String ?? ""
         self.Cost = response["Cost"] as? String ?? ""
         self.BranchCode = response["BranchCode"] as? String ?? ""
         self.CountryCode = response["CountryCode"] as? String ?? ""
         self.CityCode = response["CityCode"] as? String ?? ""
         self.CurrencyCode = response["CurrencyCode"] as? String ?? ""
         self.userImage = response["DriverImagePath"] as? String ?? ""
        
    }
    
}
