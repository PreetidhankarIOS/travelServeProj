//
//  forGotPasswordViewController.swift
//  travelServe
//
//  Created by Developer on 17/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class forGotPasswordViewController: UIViewController {
    @IBOutlet weak var userNameTxt: CustomTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.ViewDidSetUp()
      
    }

    func ViewDidSetUp(){

        self.userNameTxt.setLeftPaddingPoints (10)
        self.userNameTxt.attributedPlaceholder = NSAttributedString(string: "Enter Username",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

        self.userNameTxt.addBottomBorderWithColor(color: .gray, width: 0.5)
        self.sendBtn.ButtonWithShadow()
        
    }
    @IBAction func backBtnAction(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func sendRequestBtnAction(_ sender: UIButton) {
        
        
        if (userNameTxt.text == nil ||  userNameTxt.text == ""){
            PDAlert.shared.showAlertWith("Alert!", message: "Please enter a valid Username", onVC: self)
            return
        }

        if Connectivity.isConnectedToInternet
        {
            self.forGotPassword(userNameTxt.text!)
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }

        
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBord.instantiateViewController(withIdentifier: "registrationViewContoller") as! registrationViewContoller
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
func forGotPassword(_ username:String) -> Void {
        
        var json: [String: Any] = [:]
        json["UserName"] = username
        
        DataManager().dataManager(view: self.view, urlStr: UserModule.FORGOT_PASSWORD, parameter: json as [String : AnyObject], methodType: "POST", serviceHitId: serviceHitId.signin) { (response, isSuccess) in
            if isSuccess{
                let respons = response as! Array<SignInModalData>
                for dict in respons {
                    if dict.message == "Success"{
                        
                        PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Send Request Successfully!", yes: "Ok", onVC: self){
                            
                            self.navigationController?.popViewController(animated: true)
                            
                        }
             
                    }else if dict.message == "Invalid User Name"{
                        
                        PDAlert.shared.showAlertWith("Alert!", message: dict.message, onVC: self)
                    }
                }
            }else{
                PDAlert.shared.showAlertWith("Alert!", message: "Server Error", onVC: self)
            }
        }
        
    }

    
    
    
    
}
