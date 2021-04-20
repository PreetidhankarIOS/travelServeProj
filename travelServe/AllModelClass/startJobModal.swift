//
//  startJobModal.swift
//  travelServe
//
//  Created by Developer on 10/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation



class startJobModal:NSObject {
    
    
    var message = ""
     var IsSuccess = Bool()
    
    
    convenience init(response : AnyObject) {
        self.init()
       
        debugPrint(response)
            self.message = response["Message"] as? String ?? ""
            self.IsSuccess = response["IsSuccess"] as? Bool ?? false
        
           // debugPrint(self.message)
    }
}
