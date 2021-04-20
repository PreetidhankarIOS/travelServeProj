//
//  jobQueue+webSerives.swift
//  travelServe
//
//  Created by Developer on 31/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

import CoreLocation
import UIKit
import Alamofire
import SwiftyJSON

extension JobQueueViewController {
    
    
    //MARK: listing work Here/////////////////////////////////////////////////////
    
    func upcoming_Rquest_listPage(AccessCode:String,DriverId:String,Password:String,UserName:String) -> Void {
        
        var json: [String: Any] = [:]
        json["AccessCode"] = AccessCode
        json["DriverId"] = DriverId
        json["Password"] = Password
        json["UserName"] = UserName
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.UPCOMEING_Requstes, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.upcomeingRequest) { (response, isSuccess) in
            if isSuccess{
                
                let responseModal = response as! upcomingModaldata
                self.dataCounttINJobQueue = responseModal.dataCountAcknowlege
                
                    //for dict in self.dataCounttINJobQueue {
                
                     //  let dict = self.dataCounttINJobQueue[0] as! upcomingModaldata
//                        if dict.message == "Success"{
//
//                            let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                            let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
//                            self.navigationController?.pushViewController(nextViewController, animated: true)
//
//                        }
               // }
                
//                for dict in  self.dataCounttINJobQueue {
//                    
//                    let modal = upcomingModaldata.init(dict: dict as AnyObject)
//                    
//                   
//                    
//                 }
                
                
//                if responseModal.dataCountAcknowlege.count>0 {
//
//                    self.dataCounttINJobQueue = responseModal.dataCountAcknowlege
//                }else{
//
//                    PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You Don't have any Acknowleged booking right now.", yes: "Ok", onVC: self){
//
//                        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
//                    }
//
//                }
                self.mainTableView.reloadData()
            }
        }
    }
    
    //MARK: listing work Here/////////////////////////////////////////////////////
    
    func startJob_byDriver(VehicleBooking_Id:String,DriverId:String,ALocation:String,ALongitude:String,ALatitude:String,TransferBookingId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["VehicleBookingId"] = VehicleBooking_Id
        json["DriverId"] = DriverId
        json["ALatitude"] = ALatitude
        json["ALongitude"] = ALongitude
        json["ALocation"] = ALocation
        json["TransferBookingId"] = TransferBookingId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_STRART_JOB, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.startDriverJob) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success"{
                        
                        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBord.instantiateViewController(withIdentifier: "StartTripViewController") as! StartTripViewController
                        nextViewController.self.userPaxName = self.psengerName
                        nextViewController.vhicalBookinId = VehicleBooking_Id
                        //                         nextViewController.fromLong = self.FromLong
                        nextViewController.self.toAddress = self.dropAdress
                        nextViewController.self.adressTo = self.pickUpAdress
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
                self.mainTableView.reloadData()
            }
            
        }

    }
    
    func curentLocation(){
        
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            if let lat = currentLocation?.coordinate.latitude{
                lati = "\(lat)"
            }
            if let lng = currentLocation?.coordinate.longitude{
                longi = "\(lng)"
            }
        }
    }
    
    //MARK: - Current LocationDouble(lati) ??  0.0
    
//    func currentLocationn () {
//
//        APIDataSource.fetchAddressComponentFromGoogleMapAPI(latitude: Double(lati) ?? 0.0, lontitude:Double(longi) ?? 0.0, handler: { (citiName, stateName, countryName, localaddress) in
//
//            self.Alocation = localaddress
//            debugPrint("\(localaddress) ")
//            DispatchQueue.main.async {
//
//            }
//
//        })
//
//    }
//
    func getAddress(address:String){
        
        let key : String = Configuration.googlePlaceAPIKey()
        let postParameters:[String: Any] = [ "address": address,"key":key]
        let url : String = "https://maps.googleapis.com/maps/api/geocode/json"
        
        Alamofire.request(url, method: .get, parameters: postParameters, encoding: URLEncoding.default, headers: nil).responseJSON {  response in
            
            if let receivedResults = response.result.value
            {
                let resultParams = JSON(receivedResults)
                self.FromLat = (resultParams["results"][0]["geometry"]["location"]["lat"].doubleValue)
                self.FromLong = (resultParams["results"][0]["geometry"]["location"]["lng"].doubleValue)
                
            }
        }
    }
    
}


