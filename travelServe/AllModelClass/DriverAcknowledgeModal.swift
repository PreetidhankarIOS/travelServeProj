//
//  DriverAcknowledgeModal.swift
//  travelServe
//
//  Created by Developer on 02/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation



class DriverAcknowledgeModal {

     var message = ""
     var success:Array<Dictionary<String,AnyObject>> = []
     var isSucess = Bool()

    convenience init(response : AnyObject) {
        self.init()
        debugPrint(response)
        self.success = response as! Array<Dictionary<String, AnyObject>>
        for dict in success {
            self.message =  dict["Message"]  as? String ?? ""
            self.isSucess =  dict["IsSuccess"]  as? Bool ?? false
            debugPrint(self.isSucess)
        }
   }
}


