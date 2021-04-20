//
//  registrationViewContoller.swift
//  travelServe
//
//  Created by Developer on 25/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import DropDown

class registrationViewContoller: UIViewController,WWCalendarTimeSelectorProtocol {
    
    @IBOutlet weak var driverNoTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var dateOfBirthBtn: UIButton!
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var address1Txt: UITextField!
    @IBOutlet weak var address2Txt: UITextField!
    @IBOutlet weak var postCodeTxt: UITextField!
    @IBOutlet weak var MobileNumberTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var vehicaleBtn: UIButton!
    @IBOutlet weak var carColorTxt: UITextField!
    @IBOutlet weak var makeOfVehicleTxt: UITextField!
    @IBOutlet weak var modelOfVehicleTxt: UITextField!
    @IBOutlet weak var registrationTxt: UITextField!
    @IBOutlet weak var pcoDriverLicenceNoTxt: UITextField!
    @IBOutlet weak var pcoVehicleLicenceNoTxt: UITextField!
    @IBOutlet weak var pcoLicenceNoTxt: UITextField!
    @IBOutlet weak var insuranceExpiaryTxt: UITextField!
    @IBOutlet weak var motExpiryTxt: UITextField!
    @IBOutlet weak var niNumberTxt: UITextField!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var profileImageDriverBtn: UIButton!
    var saveChosenImage = UIImage()
    var arrCountry = ["Andra Pradesh","Arunachal Pradesh","Chhattisgarh","Goa","Gujarat","Arunachal Pradesh","Assam","Bihar"]
    var arrCity = ["Andra Pradesh","Arunachal Pradesh","Chhattisgarh","Goa","Gujarat","Arunachal Pradesh","Assam","Bihar"]
    var arrVehical = ["Andra Pradesh","Arunachal Pradesh","Chhattisgarh","Goa","Gujarat","Arunachal Pradesh","Assam","Bihar"]
    
    let categoryDrop = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.categoryDrop
        ]
    }()
    
    
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        self.ViewDidSetUp()
      
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func dateOfbirthBtnAction(_ sender: UIButton) {
        
       // self.veryFiyTimeOrDate = true
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        present(selector, animated: true, completion: nil)
        
  
        
    }
    
    @IBAction func selectCountryBtnAction(_ sender: UIButton) {
        
        self.categoryDrop.anchorView = sender
        self.categoryDrop.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        self.categoryDrop.dataSource.removeAll()
        self.categoryDrop.dataSource.append(contentsOf: self.arrCountry)
        self.categoryDrop.selectionAction = { [unowned self] (index, item) in
            sender.setTitle(item, for: .normal)
            // self.uplordDcument = item
            //debugPrint(self.uplordDcument)
            
        }
        self.categoryDrop.show()
        
    }
    
    @IBAction func slectCityBtnAction(_ sender: UIButton) {
        
        self.categoryDrop.anchorView = sender
        self.categoryDrop.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        self.categoryDrop.dataSource.removeAll()
        self.categoryDrop.dataSource.append(contentsOf: self.arrCity)
        self.categoryDrop.selectionAction = { [unowned self] (index, item) in
            sender.setTitle(item, for: .normal)
            // self.uplordDcument = item
            //debugPrint(self.uplordDcument)
            
        }
        self.categoryDrop.show()
        
    }
    
    @IBAction func selectVechicalBtnAction(_ sender: UIButton) {
        
        self.categoryDrop.anchorView = sender
        self.categoryDrop.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        self.categoryDrop.dataSource.removeAll()
        self.categoryDrop.dataSource.append(contentsOf: self.arrVehical)
        self.categoryDrop.selectionAction = { [unowned self] (index, item) in
            sender.setTitle(item, for: .normal)
            // self.uplordDcument = item
            //debugPrint(self.uplordDcument)
            
        }
        self.categoryDrop.show()
        
    }
    
    @IBAction func addDriverProfileImage(_ sender: UIButton) {
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
      
        
        
        if let presenter = actionSheetController.popoverPresentationController {
            presenter.sourceView = sender as UIView
            presenter.sourceRect = (sender as AnyObject).bounds
        }
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {

            let dateString = date.stringFromFormat("dd MMMM'yy")
           //debugPrint(dateString)
           self.dateOfBirthBtn.setTitle("\(dateString)", for: .normal)
      
        
    }
    
    
}
