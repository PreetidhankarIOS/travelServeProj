//
//  driverDetailsModalClass.swift
//  travelServe
//
//  Created by Developer on 05/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

class driverDetailsModalClass {
    
    
    var message = ""
    var vehicalName = ""
    var carColor = ""
    var makeOfVehical = ""
    var ModalOfVehical = ""
    var registration = ""
    var pCODriverLicenceNo = ""
    var pCOVehicleLicenceNo = ""
    var pcoLicenceNo = ""
    var InsuranceExpiry = ""
    var MotExpiry = ""
    var NInumber = 0
    
    
    var driverImage = ""
    var userName = ""
    var MobileNo = ""
    var FirstName = ""
    var lastName = ""
    var EmergencyContactNo = ""
    var emailId = ""
    var  tital = ""
    var password = ""
    var dob = ""
    var dataAllForForile: Array<AnyObject> = []
    
    
    
    convenience init(response : AnyObject) {
        self.init()
        //debugPrint(response)
        

         self.message =  response["Message"]  as? String ?? ""
         self.vehicalName =  response["VehicleName"]  as? String ?? ""
         self.carColor =  response["CarColor"]  as? String ?? ""
         self.pcoLicenceNo =  response["PCOLicenceNo"]  as? String ?? ""
         self.makeOfVehical =  response["MakeOfVehicle"]  as? String ?? ""
         self.ModalOfVehical =  response["ModelOfVehicle"]  as? String ?? ""
         self.registration =  response["Registration"]  as? String ?? ""
         self.pCODriverLicenceNo =  response["PCODriverLicenceNo"]  as? String ?? ""
         self.pCOVehicleLicenceNo =  response["PCOVehicleLicenceNo"]  as? String ?? ""
         self.InsuranceExpiry =  response["InsuranceExpiry"]  as? String ?? ""
         self.MotExpiry =  response["MOTExpiry"]  as? String ?? ""
         self.NInumber =  response["NiNumber"]  as? Int ?? 0
        
         self.driverImage =  response["DriverImage"]  as? String ?? ""
         self.userName =  response["UserName"]  as? String ?? ""
         self.MobileNo =  response["ContactNo"]  as? String ?? ""
         self.FirstName =  response["FirstName"]  as? String ?? ""
         self.lastName =  response["LastName"]  as? String ?? ""
         self.EmergencyContactNo =  response["EmergencyContactNo"]  as? String ?? ""
         self.emailId =  response["OfficialEmail"]  as? String ?? ""
         self.tital =  response["Title"]  as? String ?? ""
         self.password =  response["Password"]  as? String ?? ""
         self.dob =  response["DOB"]  as? String ?? ""
 
        
    }

}


//AccessCode = 0;
//AddressLine1 = ETRETRT;
//AddressLine2 = fghgh;
//AirportCityId = 0;
//CarColor = RED;
//Check = "";
//CheckIP = 0;
//CityId = 1;
//CityName = London;
//
//Commission = 0;
//ContactNo = 54687;
//Cost = 0;
//CountryCode = 1;
//CountryName = "United Kingdom";
//DOB = "1993-02-22";
//DepartmentId = 0;
//DesignationId = 0;
//DriverCallSign = 322;
//DriverId = 42;
//DriverImage = "http://193.39.255.52:93/Content/img/Driver/11062019071831_usa.jpg";
//DriverImageName = "Content/img/Driver/11062019071831_usa.jpg";
//DriverNo = 0;
//DriverTypeId = 0;
//EmergencyContactNo = 4587777;
//FirstName = Rajat;
//InsuranceExpiry = "03/17/2019";
//InsuranceExpiryImageName = "http://193.39.255.52:93/Content/img/Driver/22062019024207_Driver_Document_22_06_2019 08_55_49.jpg";
//IsActive = 1;
//IsApprove = 0;
//IsParent = 0;
//LastName = Gupta;
//MOTExpiry = "03/17/2019";
//MOTExpiryImageName = "http://193.39.255.52:93/Content/img/Driver/22062019024207_Driver_Document_22_06_2019 08_55_48.jpg";
//MakeOfVehicle = axs;
//ModelOfVehicle = 12;
//NiNumber = 123;
//OfficialEmail = "544@GMAIL.COM";
//PCODriverLicenceImageName = "http://193.39.255.52:93/Content/img/Driver/22062019024207_Driver_Document_22_06_2019 08_55_52.jpg";
//PCODriverLicenceNo = 10;
//PCOLicenceNo = zz;
//PCOLicenceNoImageName = "http://193.39.255.52:93/Content/img/Driver/22062019024207_Driver_Document_22_06_2019 08_55_50.jpg";
//PCOVehicleLicenceImageName = "http://193.39.255.52:93/Content/img/Driver/22062019024207_Driver_Document_22_06_2019 08_55_53.jpg";
//PCOVehicleLicenceNo = zz;
//Password = 1;
//PostCode = ERRE;
//Profit = 0;
//Registration = 142;
//RegistrationImage = "http://193.39.255.52:93/Content/img/Driver/22062019024207_Driver_Document_22_06_2019 08_55_54.jpg";
//Remarks = ".";
//Title = "Mr.";
//UserId = 0;
//UserName = R12;
//VehicleId = 3;
//VehicleName = MultiSeater;
