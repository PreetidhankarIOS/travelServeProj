//
//  profileViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var vehicalNameLib: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLib: UILabel!
    @IBOutlet weak var driverIdLib: UILabel!
    var dataCountf:  Array<driverDetailsModalClass> = []
      var dataCountu:  Array<driverDetailsModalClass> = []
    var dataCount:  Array<signUpModalData> = []
    var updateProfile = updateProfileForCell()
    var saveChosenImage = UIImage()
    var convertedImage64 = String()
    var firstName = String()
    var lastName = String()
    var mobileNo = String()
    var email_id = String()
    var password = String()

    
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTableView.separatorStyle = .none
     

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Connectivity.isConnectedToInternet
        {
            
            self.driver_informnation(DriverId: UserDetail.shared.getUserDriverId())

        }else{
            
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }

    
    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
    
    
    @IBAction func imageBtnEditAction(_ sender: UIButton) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraBtn: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default) { action -> Void in
            self.selectImageFromCamera()
        }
        let photoBtn: UIAlertAction = UIAlertAction(title: "Choose Photo", style: .default) { action -> Void in
            self.selectImageFromGallery()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cameraBtn)
        actionSheetController.addAction(photoBtn)
        actionSheetController.addAction(cancelAction)
        // self.present(actionSheetController, animated: true, completion: nil)

        if let presenter = actionSheetController.popoverPresentationController {
            presenter.sourceView = sender as UIView
            presenter.sourceRect = (sender as AnyObject).bounds
        }
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    @IBAction func updateBtnAction(_ sender: UIButton) {
        

        
        if Connectivity.isConnectedToInternet
        {
            let dict = self.dataCountf[0] as driverDetailsModalClass
            let deviceID = UIDevice.current.identifierForVendor!.uuidString
            var mobilee = String()
            var firstnamee = String()
            var lastNamee = String()
            var emaill = String()
            var passwordd = String()

            if (updateProfile.firstName == nil ||  updateProfile.firstName == ""){
                   firstnamee = self.firstName
            }else{
                firstnamee = updateProfile.firstName!
            }
            
            if (updateProfile.lastName == nil ||  updateProfile.lastName == ""){
                lastNamee = self.lastName
            }else{
                lastNamee = updateProfile.lastName!
            }
            
            if (updateProfile.emailAddress == nil ||  updateProfile.emailAddress == ""){
                emaill = self.email_id
            }else{
                emaill = updateProfile.emailAddress!
            }
            
            if (updateProfile.password == nil ||  updateProfile.password == ""){
                passwordd = self.password
            }else{
                passwordd = updateProfile.password!
            }
            
            if (updateProfile.mobile == nil ||  updateProfile.mobile == ""){
                mobilee = self.mobileNo
            }else{
                mobilee = updateProfile.mobile!
            }

            self.update_Profile_api(Title: dict.tital, DriverId: UserDetail.shared.getUserDriverId(), Password: passwordd, UserName: dict.userName, FirstName: firstnamee, LastName: lastNamee, Mobile1: dict.EmergencyContactNo, DeviceId: deviceID, DOB: dict.dob, Email: emaill, Mobile:  mobilee)
            
        }else{
            
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }
}

extension profileViewController:UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! profileviewTableCell
        cell.selectionStyle = .none


        cell.firstNameTxt.setLeftPaddingPoints (10)
        cell.lastNameTxt.setLeftPaddingPoints  (10)
        cell.mobileNubTxt.setLeftPaddingPoints (10)
        cell.emailIdTxt.setLeftPaddingPoints   (10)
        cell.passwordTxt.setLeftPaddingPoints  (10)
        
        cell.firstNameTxt.text = self.firstName
        cell.lastNameTxt.text = self.lastName
        cell.mobileNubTxt.text = self.mobileNo
        cell.emailIdTxt.text = self.email_id
        cell.passwordTxt.text = self.password

         cell.firstNameTxt.delegate = self
         cell.lastNameTxt.delegate = self
         cell.emailIdTxt.delegate = self
         cell.passwordTxt.delegate = self
         cell.mobileNubTxt.delegate = self


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 484
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 100:
            updateProfile.firstName = textField.text
            break
        case 101:
            updateProfile.lastName = textField.text
            break
        case 102:
            updateProfile.emailAddress = textField.text
            break
        case 103:
            updateProfile.password = textField.text
            
            break
        case 104:
            updateProfile.mobile = textField.text
            break
        default:
            break
            
        }
    }

}


class profileviewTableCell: UITableViewCell {
    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var mobileNubTxt: UITextField!
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!

}

extension profileViewController : UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    func selectImageFromGallery() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerController.SourceType.photoLibrary;
            // imag.mediaTypes = [kUTTypeImage as String];
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
//        debugPrint(saveChosenImage)
        self.dismiss(animated: true) {
            self.profileImage.image = self.saveChosenImage
            self.convertedImage64 =  (self.saveChosenImage.jpegData(compressionQuality: 0.1)?.base64EncodedString())!
            
            self.API_Calling_For_SaveUserProfileData()
        }
    }
}



