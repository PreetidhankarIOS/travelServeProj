//
//  chat+servicesView.swift
//  travelServe
//
//  Created by Developer on 23/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation



extension chatViewController {
    
    
    func chat_informnation(DriverId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["ChatType"] = "General"
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.CHATHISTORY, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.chatHistory) { (response, isSuccess) in
            
            if isSuccess{
              UserDefaults.standard.set(false, forKey: ckeckChatWithNotification)
                let responseModal = response as! chatHistoryModal
                var chats: [Chat] = []

                for obj in responseModal.dataCountChatHistoryMain {
                    
//                    let IsSuccess = obj["IsSuccess"] as? Bool ?? false
//
//                    if IsSuccess ==  true {
                                   let Message = obj["Message"] as! String
                                   let sender = obj["Sender"] as! String
                                   let cahtTime = obj["AddTime"] as! String
                                   let chat1 = Chat(arg_user: sender, arg_pic: "", arg_message: Message, chatTime: cahtTime)
                                   chats.append(chat1)
//                    }else{
//                        
//                        //PDAlert.shared.showAlertWith("Alert!", message: "No Message", onVC: self)
//                    }

                }
                self.chatviewmodel?.chats = chats
                self.chatTable.reloadData()
                self.chatTable.scrollToLastCell_P(animated: false)
            }
          //self.maintableView.reloadData()
        }
    }
    func chat_informnationUpdate(DriverId:String,msg:String,bookingId:String) -> Void {
        
        var json: [String: Any] = [:]
        json["DriverId"] = DriverId
        json["ChatType"] = "General"
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
                self.chat_informnation(DriverId: UserDetail.shared.getUserDriverId())
            }
        }
    }
}
