//
//  driverStatement+webServices.swift
//  travelServe
//
//  Created by Developer on 28/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit


extension driverStatmentViewController{
    
    
    func driver_Statement_API() -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = UserDetail.shared.getUserDriverId()
        
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.DRIVER_STATEMENT, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.driver_statement) { (response, isSuccess) in
            if isSuccess{
                
                let responseModal = response as! driverStatementModal
                self.dataCounttAmount = responseModal.dataCountDriverData

//                if self.dataCounttAmount.count == 0 {
//
//                    PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You Don't have Data", yes: "Ok", onVC: self){
//
//                        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
//
//                    }
//
//                }else{
                    
                    let dict = self.dataCounttAmount[0] as! driverStatementModal
                    self.commToTSL.text            = "\(dict.CommissionToTSL)"
                    self.totalSales.text           = "\(dict.TotalSales)"
                    self.paymentFromTSL.text       = "\(dict.PaymentFromTSL)"
                    self.driverEarings.text        = "\(dict.DriverEarnings)"
                    self.cashCashLib.text          = "\(dict.TotalCash)"
                    self.cashCommissionLib.text    = "\(dict.CommissionOnCash)"
                    self.amountCashLib.text        = "\(dict.TotalAccount)"
                    self.amountCommissionLib.text  = "\(dict.CommissionOnAccount)"
                    self.cardCashLib.text          = "\(dict.TotalCard)"
                    self.cardCommissionLib.text    = "\(dict.CommissionOnCard)"
                    self.notRequsteData            = responseModal.notRequtestdataCountListData as Array<AnyObject>
                    self.dataCountList             = responseModal.dataCountListData
                    
                //}
                
            

                //Disapproved
                //"No Request"
                //Approved
                
              // self.CellButtonTitalChange.setTitle("Request Submitted",for: .normal)
                
//                let respons = response as! Array<updateVehicleInfomationModalClass>
//                for dict in respons {
//                    if dict.Message == "Success" {
//                        
//                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your Vehicle Information Update successfully", yes: "Ok", onVC: self){
//
//                        }
//                        
//                    }else{
//                        
//                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
//                    }
//                }
                
                self.mainTableView.reloadData()
            }
            
        }
        
    }
    
    
    
    func SubmitQuery_API(_ StatmentQuery: String, vhicalBookingId: String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = UserDetail.shared.getUserDriverId()
        json["StatementQuery"] = StatmentQuery
        json["VehicleBookingId"] = vhicalBookingId

        DataManager().dataManager(view: self.view, urlStr: UserModule.DISAPPROVE_INV_STATEMENT, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.sendQuery) { (response, isSuccess) in
            if isSuccess{

                let respons = response as! Array<startJobModal>
                for dict in respons {
                    if dict.message == "Success" {

                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your Query Send successfully", yes: "Ok", onVC: self){
                            
                            self.CellButtonTitalChange.setTitle("Request Submitted",for: .normal)
                            self.CellButtonTitalChange.isEnabled = false
                            self.popUpView.isHidden = true
                        }

                    }else{

                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
                self.mainTableView.reloadData()
            }
            
        }
        
    }
    
    func approveList_API(_ StatmentQuery: String, vhicalBookingId: String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = UserDetail.shared.getUserDriverId()
        json["StatementQuery"] = StatmentQuery
        json["VehicleBookingId"] = vhicalBookingId
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.APPROVE_INV_STATEMENT, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.sendQuery) { (response, isSuccess) in
            if isSuccess{
                
                let respons = response as! Array<startJobModal>
                for dict in respons {
                    
                    if dict.message == "Success" {
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Your Query Send successfully", yes: "Ok", onVC: self){
                            
                            self.CellButtonTitalChange.setTitle("Request Submitted",for: .normal)
                            self.CellButtonTitalChange.isEnabled = false
                            self.popUpView.isHidden = true
                        }
                        
                    }else{
                        PDAlert.shared.showAlertWith("Alert!", message: "Error", onVC: self)
                    }
                }
                
                self.mainTableView.reloadData()
            }
            
        }
        
    }
    

    
}
