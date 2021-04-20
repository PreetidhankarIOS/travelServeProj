//
//  bookingChatRegardingId+webSerices.swift
//  travelServe
//
//  Created by Developer on 19/10/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


extension chatViewOfBookingIdViewController {


func chat_informnationRegardingBookingId(DriverId:String) -> Void {
    
    var json: [String: Any] = [:]
    json["DriverId"] = DriverId
    json["ChatType"] = "Booking"
    
    
    DataManager().dataManager(view: self.view, urlStr: UserModule.CHATHISTORY, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.chatHistory) { (response, isSuccess) in
        
        if isSuccess{
          UserDefaults.standard.set(false, forKey: ckeckChatWithNotification)
            let responseModal = response as! chatHistoryModal
            var chats: [Chat] = []
            for obj in responseModal.dataCountChatHistoryMain {
                let Message = obj["Message"] as! String
                let sender = obj["Sender"] as! String
                let cahtTime = obj["AddTime"] as! String
                let chat1 = Chat(arg_user: sender, arg_pic: "", arg_message: Message, chatTime: cahtTime)
                chats.append(chat1)
            }
//            self.chatviewmodel?.chats = chats
//            self.chatTable.reloadData()
//            self.chatTable.scrollToLastCell_P(animated: false)
        }
      //self.maintableView.reloadData()
    }
   }
}
