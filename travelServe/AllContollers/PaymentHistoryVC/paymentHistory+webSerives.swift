//
//  paymentHistory+webSerives.swift
//  travelServe
//
//  Created by Developer on 12/08/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


extension PaymentHistoryViewController {
    
    func driver_PaymentHistory(DriverId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.PAYMENT_HISTORY, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.paymentHistory) { (response, isSuccess) in
            if isSuccess{
                
                   let data  = response as! PaymentHistoryModal
                self.dataCountTable  = data.dataCountWeek as! Array<PaymentHistoryModal>
                self.dataCountTable1  = data.dataCountDetails as! Array<PaymentHistoryModal>
                self.mainTableView.reloadData()
            }
        }
    }
}
