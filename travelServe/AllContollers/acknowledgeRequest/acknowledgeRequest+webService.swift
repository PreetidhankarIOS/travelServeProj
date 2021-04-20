//
//  acknowledgeRequest+webService.swift
//  travelServe
//
//  Created by Developer on 05/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Alamofire
import SwiftyJSON

extension acknowledgeRequestViewController {
    

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
                if responseModal.dataCountAcknowlege.count>0 {
                    
                    if responseModal.isStartJob == true{
                        
                        
                    }else{
                        self.dataCountt = responseModal.dataCountAcknowlege
                    }
                    
                    
                }else{
                    let image: UIImage = UIImage(named: "ic_notfound")!
                    let imageView = UIImageView(image: image)
                    self.view.addSubview(imageView)
                    imageView.frame = CGRect(x: 0,y: 0,width: 200,height: 150)
                    imageView.center = self.view.center
                }
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
                        nextViewController.self.toAddress = self.dropAdress
                        nextViewController.self.adressTo = self.pickUpAdress
                        UserDefaults.standard.set(true, forKey: startJobOrNot)
                        UserDefaults.standard.set(self.psengerName, forKey: "psengerName")
                        UserDefaults.standard.set(VehicleBooking_Id, forKey: "VehicleBooking_Id")
                        UserDefaults.standard.set(self.dropAdress, forKey: "dropAdress")
                        UserDefaults.standard.set(self.pickUpAdress, forKey: "pickUpAdress")
                        
       
                        
                        nextViewController.PriceModelId = self.PriceModelId
                        nextViewController.PFCIId =  self.PFCIId
                        nextViewController.LocationId =  self.LocationId
                        let stripped = String(self.travelServePrice.dropFirst(2))
                        nextViewController.jobPrice = stripped
                        
                        UserDefaults.standard.set(self.PriceModelId, forKey: "PriceModelId")
                        UserDefaults.standard.set(self.PFCIId, forKey: "PFCIId")
                        UserDefaults.standard.set(self.LocationId, forKey: "LocationId")
                        UserDefaults.standard.set(stripped, forKey: "jobPrice")
                        


                        
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
    
    func currentLocationn () {
        
        APIDataSource.fetchAddressComponentFromGoogleMapAPI(latitude: Double(lati) ?? 0.0, lontitude:Double(longi) ?? 0.0, handler: { (citiName, stateName, countryName, localaddress) in
 
            self.Alocation = localaddress
            debugPrint("\(localaddress) ")
            DispatchQueue.main.async {

            }
           
        })
        
    }
    
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



extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}


