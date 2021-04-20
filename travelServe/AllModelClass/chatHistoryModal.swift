//
//  chatHistoryModal.swift
//  travelServe
//
//  Created by Developer on 23/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation


class chatHistoryModal:NSObject {
    
    var message = ""
    var IsSuccess = false
    var ChatId = 0
    var DriverId = 0
    var UserId = 1
    var UserName = ""
    var AddTime = ""
    var AddDate = ""
    var IsRead = false
    var Sender = ""
    var FileBookingId = ""
    var ChatType = ""
    var dataCountChatHistory : Array<AnyObject> = []
    var dataCountChatHistoryMain:Array<Dictionary<String,AnyObject>> = []
  
    convenience init(response : AnyObject) {
        self.init()
         debugPrint(response)
        
        self.dataCountChatHistoryMain = response as! Array<Dictionary<String, AnyObject>>

                for dictt in dataCountChatHistoryMain {

                    let modal = chatHistoryModal.init(dict: dictt as AnyObject)
                         dataCountChatHistory.append(modal)
            }


          // debugPrint(self.dataCountChatHistory)

    }
    
    convenience init(dict:AnyObject) {
        self.init()

        self.message =    dict["Message"]  as? String ?? ""
        self.IsSuccess =  dict["IsSuccess"]  as? Bool ?? false
        self.ChatId =     dict["ChatId"]  as? Int ?? 0
        self.DriverId =   dict["DriverId"]  as? Int ?? 0
        self.UserId =     dict["UserId"]  as? Int ?? 0
        self.UserName =   dict["UserName"]  as? String ?? ""
        self.AddTime =    dict["AddTime"]  as? String ?? ""
        self.AddDate =    dict["AddDate"]  as? String ?? ""
        self.IsRead =     dict["IsRead"]  as? Bool ?? false
        self.Sender =     dict["Sender"]  as? String ?? ""
        self.FileBookingId =  dict["FileBookingId"]  as? String ?? ""
        self.ChatType =  dict["ChatType"]  as? String ?? ""
        debugPrint(self.Sender)
    }
    

}




