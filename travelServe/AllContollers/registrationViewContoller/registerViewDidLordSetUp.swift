//
//  registerViewDidLordSetUp.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import Foundation
import UIKit


extension registrationViewContoller : UINavigationControllerDelegate,UIImagePickerControllerDelegate  {
  
    func ViewDidSetUp(){
        
        self.navigationController?.isNavigationBarHidden = true
        self.profileImageDriverBtn.layer.cornerRadius = self.profileImageDriverBtn.frame.width/2
        self.driverNoTxt.setLeftPaddingPoints (10)
        self.firstNameTxt.setLeftPaddingPoints(10)
        self.lastNameTxt.setLeftPaddingPoints(10)
        self.address1Txt.setLeftPaddingPoints(10)
        self.address2Txt.setLeftPaddingPoints(10)
        self.postCodeTxt.setLeftPaddingPoints(10)
        self.MobileNumberTxt.setLeftPaddingPoints(10)
        self.emailTxt.setLeftPaddingPoints(10)
        self.carColorTxt.setLeftPaddingPoints(10)
        self.makeOfVehicleTxt.setLeftPaddingPoints(10)
        self.modelOfVehicleTxt.setLeftPaddingPoints(10)
        self.registrationTxt.setLeftPaddingPoints(10)
        self.pcoDriverLicenceNoTxt.setLeftPaddingPoints(10)
        self.pcoVehicleLicenceNoTxt.setLeftPaddingPoints(10)
        self.pcoLicenceNoTxt.setLeftPaddingPoints(10)
        self.insuranceExpiaryTxt.setLeftPaddingPoints(10)
        self.motExpiryTxt.setLeftPaddingPoints(10)
        self.niNumberTxt.setLeftPaddingPoints(10)
        self.userNameTxt.setLeftPaddingPoints(10)
        self.passwordTxt.setLeftPaddingPoints(10)
        
        
        self.driverNoTxt.attributedPlaceholder = NSAttributedString(string: "Enter driver no.",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.firstNameTxt.attributedPlaceholder = NSAttributedString(string: "Enter first name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.lastNameTxt.attributedPlaceholder = NSAttributedString(string: "Enter last name",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.address1Txt.attributedPlaceholder = NSAttributedString(string: "Enter Address1",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.address2Txt.attributedPlaceholder = NSAttributedString(string: "Enter Address2",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        self.postCodeTxt.attributedPlaceholder = NSAttributedString(string: "Enter PostCode",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
        self.MobileNumberTxt.attributedPlaceholder = NSAttributedString(string: "Enter Mobile Nimber",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.emailTxt.attributedPlaceholder = NSAttributedString(string: "Enter Email Id",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.carColorTxt.attributedPlaceholder = NSAttributedString(string: "Enter Car Color",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.makeOfVehicleTxt.attributedPlaceholder = NSAttributedString(string: "Make of vehicle",
                                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.modelOfVehicleTxt.attributedPlaceholder = NSAttributedString(string: "Enter Model of vehicle",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
  
        
        self.registrationTxt.attributedPlaceholder = NSAttributedString(string: "Enter Registration",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.pcoDriverLicenceNoTxt.attributedPlaceholder = NSAttributedString(string: "Enter PCO Driver Licence no.",
                                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.pcoVehicleLicenceNoTxt.attributedPlaceholder = NSAttributedString(string: "Enter PCO Vehicle Licence no.",
                                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.pcoLicenceNoTxt.attributedPlaceholder = NSAttributedString(string: "Enter PCO Licence no.",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        self.insuranceExpiaryTxt.attributedPlaceholder = NSAttributedString(string: "Enter Insurance Expiry",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.motExpiryTxt.attributedPlaceholder = NSAttributedString(string: "Enter MOT Expiry",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        

        
        self.niNumberTxt.attributedPlaceholder = NSAttributedString(string: "Enter NI Number",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.userNameTxt.attributedPlaceholder = NSAttributedString(string: "Enter User Name",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.passwordTxt.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        registerBtn.ButtonWithShadow()
        
    }

  
    
    
   
    
    func selectImageFromGallery() {
    
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerController.SourceType.photoLibrary;
            imag.allowsEditing = false
            self.present(imag, animated: true, completion: nil)
       }
    }
    
    func selectImageFromCamera() {
    
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerController.SourceType.camera
            
            imag.allowsEditing = false
            self.present(imag, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    self.saveChosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    debugPrint(saveChosenImage)
    
    
    self.dismiss(animated: true) {
       self.profileImageDriverBtn.setImage(self.saveChosenImage, for: .normal)
        
        self.profileImageDriverBtn.layer.cornerRadius = self.profileImageDriverBtn.frame.width/2
        self.profileImageDriverBtn.layer.masksToBounds = true
        self.profileImageDriverBtn.ButtonWithShadow()
        
        
     }
    }

    
}
