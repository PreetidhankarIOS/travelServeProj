//
//  DataManager.swift
//  EDXPERT
//
//  Created by Vibhash Kumar on 05/03/19.
//  Copyright © 2019 Vibhash Kumar. All rights reserved.
//

import UIKit
import Alamofire

enum serviceHitId {
    case signin,registration_Image,upcomeingRequest,DriverAcknowledge,StartDriverShift,completRideAll,DriverDetails,startDriverJob,DriverOnSide,deniedDuty,logOutDriver,vhicalListing,updateVhicalDetales,paymentHistory,chatHistory,poolJob,driver_statement,sendQuery,getWaitingInfoDetails
}

class DataManager: NSObject {

    func dataManager(view:UIView?,urlStr:String,parameter:[String : AnyObject],methodType : String,serviceHitId:serviceHitId,handler:@escaping((Any,Bool)->Void)) -> Void {
        if !urlStr .isEmpty && !parameter .isEmpty {
            
            ServiceHitClass().serviceHit(view: view,urlString: urlStr, parameter: parameter, methodType: methodType) { (response, isSuccess) in
                if isSuccess{
                    let resultModal = self.responseManager(serverHitId: serviceHitId, response: response as AnyObject)
                    handler(resultModal,true)
                }else{
                    handler("",false)
                }
            }
        }else {
            if !urlStr .isEmpty {
                ServiceHitClass().serviceHit(view: view,urlString: urlStr, parameter: parameter, methodType: methodType) { (response, isSuccess) in
                    if isSuccess{
                        let resultModal = self.responseManager(serverHitId: serviceHitId, response: response as AnyObject)
                        handler(resultModal,true)
                    }else{
                        handler("",false)
                    }
                }
            }
        }
    }
    func responseManager(serverHitId : serviceHitId ,response: AnyObject)-> AnyObject  {
        
        var result:AnyObject?
        switch(serverHitId){
        case .signin:
            
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = SignInModalData.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break

        case .registration_Image:
             result = driverImageUplordModel.init(response: response as AnyObject)
            break
            
        case .upcomeingRequest:

                result = upcomingModaldata.init(response:response as AnyObject)

            break
        case .StartDriverShift:
            
            result = StartDriverShiftModal.init(response:response as AnyObject)
            
            break
            
        case .DriverAcknowledge:
            result = DriverAcknowledgeModal.init(response:response as AnyObject)
            break
        case .completRideAll:
            
            result = rideCompleteModalData.init(response:response as AnyObject)
                break
        case .DriverDetails:
            
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = driverDetailsModalClass.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
        case .startDriverJob:
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = startJobModal.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break
        case .DriverOnSide:
            
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = startJobModal.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break
        case .deniedDuty:
            result = rideCompleteModalData.init(response:response as AnyObject)
            break

        case .logOutDriver:
            
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = startJobModal.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break
        case .vhicalListing:

            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = vhicalListingModalClass.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break
        case .updateVhicalDetales:
            
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = updateVehicleInfomationModalClass.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break
        case .paymentHistory:
            
            result = PaymentHistoryModal.init(response:response as AnyObject)
            
            break
        case .chatHistory:
            
            result = chatHistoryModal.init(response:response as AnyObject)
            break
            
        case .poolJob:
             result = poolJobsModalData.init(response:response as AnyObject)
            break
        case .driver_statement:
            
            result = driverStatementModal.init(response:response as AnyObject)
            break
            
        case .sendQuery:
            var jobArray : Array<Any> = []
            for  dataDict in response as! [AnyObject] {
                let modal = startJobModal.init(response:dataDict as AnyObject)
                jobArray.append(modal)
            }
            result = jobArray as AnyObject
            break
        case .getWaitingInfoDetails:
            
            result = waitingChargeShowModal.init(response:response as AnyObject)
            
//            var jobArray : Array<Any> = []
//               for  dataDict in response as! [AnyObject] {
//                   let modal = startJobModal.init(response:dataDict as AnyObject)
//                   jobArray.append(modal)
//               }
//               result = jobArray as AnyObject
               break
        }
        
        return result!
    }

    func getDetails(response: Dictionary<String,Any>) ->Array<Dictionary<String,AnyObject>> {
       
        if response["status"] as? Int ?? 0 == 200 {
             let dataDict = response["data"] as? Array<Dictionary<String,AnyObject>> ?? []
            return dataDict
        }else{
            return []
        }
       
    }
    
}


typealias CompletionHander = (_ response: DataServiceResponse, _ result: AnyObject?) -> Void

class Connection {
    
    
    class func callServiceWithURL(_ url: URL, completionHandler: @escaping CompletionHander) {
        
        
        Alamofire.request(url).responseJSON { response in
            //DLog(response.debugDescription as AnyObject)
            
            switch response.result {
            case .success:
                if isGuardObject(response.result.value as AnyObject?) {
                    completionHandler(.success, response.result.value! as AnyObject?)
                    
                } else {
                    completionHandler(.error, nil)
                    
                }
                //DLog("success" as AnyObject)
            case .failure(let error):
               // DLog(error.localizedDescription)
                completionHandler(.error, nil)
                
            }
        }
    }
    
   
    
}


typealias APIServiceCompletionHandler = (_ response: DataServiceResponse, _ result: AnyObject?) -> Void

class APIDataSource  {

    class  func fetchAddressComponentFromGoogleMapAPI(latitude : Double, lontitude : Double,handler: @escaping googlePlacesDetailCloser) {
        let urlString = UserModule.KPlaceDetailURL + latitude.stringValue() + "," + lontitude.stringValue()
        

        let url = NSURL(string: urlString + "&sensor=false&key=" + Configuration.googlePlaceAPIKey())
        
        Connection.callServiceWithURL(url! as URL) { (response, result) in
            if response.successful() {
                
                if let results = result?["results"] as? [[String : AnyObject]] {
                    var citiName = ""
                    var stateName = ""
                    var countryName = ""
                    var address = ""
                    
                    if results.count > 0{
                        
                        let result = results[0] as [String : AnyObject]
                        
                        
                        //  for result in results {
                        if let addressComponents = result["address_components"] as? [[String : AnyObject]] {
                            
                            let citiItems = addressComponents.filter{ if let types = $0["types"] as? [String] {
                                return types.contains("locality") } else { return false } }
                            if !citiItems.isEmpty {
                                //DLog("citiName, \(citiItems[0]["long_name"] as! String)")
                                citiName = citiItems[0]["long_name"] as! String
                            }
                            
                            let stateItems = addressComponents.filter{ if let types = $0["types"] as? [String] {
                                return types.contains("administrative_area_level_1") } else { return false } }
                            if !stateItems.isEmpty {
                                // DLog("stateName, \(stateItems[0]["long_name"] as! String)")
                                stateName = stateItems[0]["long_name"] as! String
                            }
                            
                            let countryItems = addressComponents.filter{ if let types = $0["types"] as? [String] {
                                return types.contains("country") } else { return false } }
                            if !countryItems.isEmpty {
                                //DLog("country Name, \(countryItems[0]["long_name"] as! String)")
                                countryName = countryItems[0]["long_name"] as! String
                            }
                        }
                        //  }
                        
                        
                        if let formattedAddress = result["formatted_address"] {
                            address = formattedAddress as! String
                        }
                    }
                    
                    handler(citiName, stateName, countryName, address)

                }
                
            }
        }
        
    }
    
    
    
    

}
