//
//  registrationView+webServices.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit

extension registrationViewContoller {
    
  
    func sendDriverImage(driverImage:String) -> Void {
        

        let json : [String : AnyObject] = ["username":driverImage as AnyObject]
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.REGISTRATION_IMAGE, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.registration_Image) { (response, isSuccess) in
            if isSuccess{
                let responseModal = response as! signUpModalData
                debugPrint(responseModal)
//                if responseModal.status == 200{
//
//
//                }else if responseModal.status == 401{
//
//                    print("server Error")
//
//                }
 
            }
        }
        
    }
    
    
    
}
