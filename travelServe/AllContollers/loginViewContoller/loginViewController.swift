//
//  loginViewController.swift
//  travelServe
//
//  Created by Developer on 25/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseMessaging


class loginViewController: UIViewController,CLLocationManagerDelegate {

    
    var loginlist_Listed : Array<signUpModalData> = []
    @IBOutlet weak var emailIdTxt: CustomTextField!
    @IBOutlet weak var passwordTxt: CustomTextField!
    var locationManager = CLLocationManager()
    @IBOutlet weak var rememberMebtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
    var addressAPI = String()

    var addressString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ViewDidSetUp()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
     
        self.showRememberMe()
    }
    func showRememberMe() {

        //if UserDefaults.standard.bool(forKey: RemmemberPwd){
        if UserDetail.shared.getRemmber(){
            
            self.rememberMebtn.isSelected = true
            self.passwordTxt.text! =  UserDetail.shared.getUserPassword()
            self.emailIdTxt.text! =  UserDetail.shared.getUserName()
        } else {
            self.passwordTxt.text =   ""
            self.emailIdTxt.text  =   ""
            self.rememberMebtn.isSelected = false
        }
        //refreshData()
    }
    
    func ViewDidSetUp(){

        self.emailIdTxt.setLeftPaddingPoints (10)
        self.passwordTxt.setLeftPaddingPoints(10)
        self.emailIdTxt.attributedPlaceholder = NSAttributedString(string: "Enter Mobile number or Email Id",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
    self.emailIdTxt.addBottomBorderWithColor(color: .gray, width: 0.5)
    self.passwordTxt.addBottomBorderWithColor(color: .gray, width: 0.5)
    self.signInBtn.ButtonWithShadow()
        
      DispatchQueue.main.async(execute: {
           self.curentLocationGet()
      })
    }

    @IBAction func signInBtnAction(_ sender: UIButton) {
        
        if (emailIdTxt.text == nil ||  emailIdTxt.text == ""){
            
            PDAlert.shared.showAlertWith("Alert!", message: "Please enter a valid Phone Number or Email Id", onVC: self)
            return
        }

        if (passwordTxt.text == nil ||  passwordTxt.text == ""){
            PDAlert.shared.showAlertWith("Alert!", message: "Please enter Password", onVC: self)
            return
        }

        if UserDetail.shared.getToken_Id() == ""{
            
            PDAlert.shared.showAlertWith("Alert!", message: "Your Device network Issue for Device Tokan Please reopen your application", onVC: self)
            
            return
        }

        if Connectivity.isConnectedToInternet
        {
        self.signInWithUserIdAndPassword(self.emailIdTxt.text!, self.passwordTxt.text!)
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }
    

    @IBAction func remmemberMeBtnAction(_ sender: UIButton) {

        if sender.isSelected == true {
            sender.isSelected = false
        }else{
            sender.isSelected = true
             self.doRememberMe()
        }

    }
    
    func  doRememberMe() {
        
        DispatchQueue.main.async(execute: {
            if self.rememberMebtn.isSelected {
                UserDetail.shared.setUserName(self.emailIdTxt.text!)
              UserDetail.shared.setUserPassword(self.passwordTxt.text!)
            UserDetail.shared.setRemmber(self.rememberMebtn.isSelected)
            } else {
                  UserDetail.shared.removeUserName()
                  UserDetail.shared.removeUserPassword()
            }

        })
    }
    
    @IBAction func forGotBtnAction(_ sender: UIButton) {

        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBord.instantiateViewController(withIdentifier: "forGotPasswordViewController") as! forGotPasswordViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    @IBAction func signUpBtnAction(_ sender: UIButton) {
    
        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBord.instantiateViewController(withIdentifier: "registrationViewContoller") as! registrationViewContoller
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
   func goToNextViewContoller() {
    
    debugPrint(UserDetail.shared.getUserLat())
    debugPrint(UserDetail.shared.getUserLong())

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.loadMenu()

    }
    
    
}
