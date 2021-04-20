//
//  ServiceHitClass.swift


import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class ServiceHitClass: NSObject {
    
    
    var hud: MBProgressHUD = MBProgressHUD()
    
    func serviceHit(view:UIView?,urlString : String,parameter:[String:AnyObject],methodType : String,handler:@escaping((Any,Bool)->Void)) -> Void {
        DispatchQueue.main.async {
            // Update UI

            if (UserDefaults.standard.bool(forKey: IsLodingViewInScondeAPI)) == false  {
                
                MBProgressHUD.hide(for: view!, animated: true)
                
            }else{
                
                self.hud = MBProgressHUD.showAdded(to: view!, animated: true)
                self.hud.mode = MBProgressHUDMode.indeterminate
                self.hud.label.text = "Loading"
            }
            
            let baseurl = "\(AppSetting.BASE_URL)\(urlString)"
            
            let json : [String : Any] = parameter
            
            print("\(baseurl)\n\(json)")
            
            if methodType == "POST" {

               
                
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = 200
               
                Alamofire.request(baseurl, method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { (response) in
                    
                       MBProgressHUD.hide(for: view!, animated: true)

                    guard response.result.error == nil else {

                        
                        if (UserDefaults.standard.bool(forKey: upadteForErrorJson)) == true {
                           
                              MBProgressHUD.hide(for: view!, animated: true)
                                handler("",false)
                            
                        }else{
                            Utility().addAlert(title: "Alert", msg: response.result.error?.localizedDescription ?? "")
                            MBProgressHUD.hide(for: view!, animated: true)
                            handler("",false)
                            
                        }
                           
                        return
                    }
                    
                    debugPrint(response.result)
                    guard let json = response.result.value else {
                        if let error = response.result.error {
                            MBProgressHUD.hide(for: view!, animated: true)
                            print(error)
                            handler("",false)
                        }
                        
                        return
                    }

                    MBProgressHUD.hide(for: view!, animated: true)
                    handler(json,true)
                    
                }
            }else{
                self.hud.show(animated:true)
                
                let manager = Alamofire.SessionManager.default
                manager.session.configuration.timeoutIntervalForRequest = 200
                
                Alamofire.request(baseurl, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
                    guard response.result.error == nil else {
                       MBProgressHUD.hide(for: view!, animated: true)
                        handler(response.result.error as Any,false)
                        return
                    }
                    guard let json = response.result.value as? [[String: Any]] else {
                        if let error = response.result.error {
                            MBProgressHUD.hide(for: view!, animated: true)
                            handler(error,false)
                        }
                        return
                    }
                    MBProgressHUD.hide(for: view!, animated: true)
                    handler(json,true)
                }
                MBProgressHUD.hide(for: view!, animated: true)
            }
        }
    }
}


//class ServiceHitClass: NSObject {
//
//    var hud: MBProgressHUD = MBProgressHUD()
//
//    func serviceHit(view:UIView?,urlString : String,parameter:[String:AnyObject],methodType : String,handler:@escaping((Any,Bool)->Void)) -> Void {
//        DispatchQueue.main.async {
//            // Update UI
//
//        self.hud = MBProgressHUD.showAdded(to: view!, animated: true)
//        self.hud.mode = MBProgressHUDMode.indeterminate
//        self.hud.label.text = "Loading"
//        let baseurl = "\(AppSetting.BASE_URL)\(urlString)"
//
//        let json : [String : Any] = parameter
//
//         print("\(baseurl)\n\(json)")
//
//        if methodType == "POST" {
//
//            self.hud.show(animated:true)
//            Alamofire.request(baseurl, method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { (response) in
//                guard response.result.error == nil else {
//
//                    PDAlert.shared.showAlertWith("Alert", message: response.result.error?.localizedDescription ?? "", onVC: nil)
//
//                    MBProgressHUD.hide(for: view!, animated: true)
//                    handler("",false)
//                    return
//                }
//                guard let json = response.result.value as? [String: Any] else {
//                    if let error = response.result.error {
//                        MBProgressHUD.hide(for: view!, animated: true)
//                        print(error)
//                        handler("",false)
//                    }
//                    return
//                }
//
//                MBProgressHUD.hide(for: view!, animated: true)
//                handler(json as Dictionary<String , AnyObject>,true)
//
//            }
//        }else{
//            self.hud.show(animated:true)
//            Alamofire.request(baseurl, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
//                guard response.result.error == nil else {
//                    MBProgressHUD.hide(for: view!, animated: true)
//                    handler(response.result.error as Any,false)
//                    return
//                }
//                guard let json = response.result.value as? [String: Any] else {
//                    if let error = response.result.error {
//                        MBProgressHUD.hide(for: view!, animated: true)
//                        handler(error,false)
//                    }
//                    return
//                }
//                MBProgressHUD.hide(for: view!, animated: true)
//                handler(json as Dictionary<String , AnyObject>,true)
//            }
//        }
//     }
//  }
//}
