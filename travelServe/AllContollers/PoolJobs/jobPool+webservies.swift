//
//  jobPool+webservies.swift
//  travelServe
//
//  Created by Developer on 25/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit



extension poolViewController {
    
    
    func jobPool_informnation(DriverId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.JOBPOOL, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.poolJob) { (response, isSuccess) in
            if isSuccess{
                
                let responseModal = response as! poolJobsModalData
                
            self.dataCountForJobPool = responseModal.Table
              for item in self.dataCountForJobPool {
                     
                     let modal = poolJobsModalData.init(dict: item as AnyObject)
                     
             if modal.messagee == "No Data Found" {

                 UserDetail.shared.setpoolJobCount("\(0)")
                 debugPrint("\(responseModal.PoolJobsdataCount.count)")

             }else{

                 UserDetail.shared.setpoolJobCount("\(responseModal.PoolJobsdataCount.count)")
                 debugPrint("\(responseModal.PoolJobsdataCount.count)")
             }

          }
                                   
                     if self.poolJobs == true{

                      self.ListAllData = responseModal.PoolJobsdataCount
                   }else{
                       self.poolsJobListAllData = responseModal.PoolJobsdataCountMy
                   }

            }
            self.mainTableView.reloadData()
        }
    }
    
    func jobPool_Requsted(DriverId:String,fileBooking_id: String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["FileBookingId"] = fileBooking_id
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.TRANSFERPOOLREQUEST, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.DriverOnSide) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                let dict = respons[0] as startJobModal
                if dict.message == "Success"{
                  PDAlert.shared.showAlertWith("Alert!", message: "Requested successfully", onVC: self)

                }else{
                     PDAlert.shared.showAlertWith("Alert!", message: dict.message, onVC: self)
                    
                }
               
            }
                
        self.mainTableView.reloadData()
    }
  
    }
}
    
