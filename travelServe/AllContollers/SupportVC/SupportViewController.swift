//
//  SupportViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
        
    }
    
    @IBAction func callToSupportBtnAction(_ sender: UIButton) {
        
        dialNumber(number: "\(+4402071481900)")
    }
    
    @IBAction func sendMailBtnAction(_ sender: UIButton) {
        
        let email = "bookings@travelserve.net"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
}
