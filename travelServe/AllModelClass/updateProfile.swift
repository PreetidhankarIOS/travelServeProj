//
//  updateProfile.swift
//  travelServe
//
//  Created by Developer on 23/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation

class updateProfile:NSObject {
    

    
    var message = ""
    


    
    convenience init(response : AnyObject) {
        self.init()
        
       // debugPrint(response)
        self.message = response["Message"] as? String ?? ""
        debugPrint(self.message)
    }
    
    
    
    
    
    
    
    
}
