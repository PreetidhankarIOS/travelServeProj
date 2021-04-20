//
//  chatViewOfBookingId+webServices.swift
//  travelServe
//
//  Created by Developer on 21/10/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

extension chatViewOfBookingIdViewController {
    
    
    func chat_informnation(DriverId:String,FileBooingId: String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["ChatType"] = "Booking"
        json["FileBookingId"] = FileBooingId
        
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.CHATHISTORY, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.chatHistory) { (response, isSuccess) in
            
            if isSuccess{
              UserDefaults.standard.set(false, forKey: ckeckChatWithNotification)
                let responseModal = response as! chatHistoryModal
                var chats: [Chate] = []
                for obj in responseModal.dataCountChatHistoryMain {
                    let status = obj["Status"] as? String
                    if status == "No Data Found" {
                       
                        PDAlert.shared.showAlertWith("Alert!", message: "No Data Found", onVC: self)
                        
                    }else{
                    
                    let Message = obj["Message"] as? String
                    let sender = obj["Sender"] as? String
                    let cahtTime = obj["AddTime"] as? String
                    let chat1 = Chate(arg_user: sender!, arg_pic: "", arg_message: Message!, chatTime: cahtTime!)
                    chats.append(chat1)
                  }
                    
                }
                self.ChatViewModalId?.chatss = chats
                self.mainTableView.reloadData()
                self.mainTableView.scrollToLastCell_P(animated: false)
            }
          //self.maintableView.reloadData()
        }
    }
    func chat_informnationUpdate(DriverId:String,msg:String,bookingId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        //json["ChatType"] = "General"
        json["Message"] = msg
        json["Sender"] = "Driver"
        json["UserId"] = "1"
        json["UserName"] = "Mr. Shaz Joyram"
        if bookingId == "NoBookingId" {
            json["ChatType"] = "General"
        }else{
            json["ChatType"] = "Booking"
            json["FileBookingId"] = bookingId
        }
        print(json)
        DataManager().dataManager(view: self.view, urlStr: UserModule.ADDCHATHISTORY, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.chatHistory) { (response, isSuccess) in
            if isSuccess{
                self.chat_informnation(DriverId: UserDetail.shared.getUserDriverId(), FileBooingId: self.fileBookingId)
            }
        }
    }
}
