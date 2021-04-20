//
//  VehicleInfromationViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import DropDown

class VehicleInfromationViewController: UIViewController,WWCalendarTimeSelectorProtocol {

    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    
    var vehicalTypee = UIButton()
    var carColorTxte = UITextField()
    var makeVehicleTxte = UITextField()
    var modelOfVehicale = UITextField()
    var registrationTxte = UITextField()
    var pCODriverLicenceNoTxte = UITextField()
    var pCOVehicleLicenceNoTxte = UITextField()
    var pCOLicenceNoTxte = UITextField()
    var insuranceExpiryBtn  = UIButton()
    var mOTExpiryBtn = UIButton()
    var niNumberTxte = UITextField()
     var dataCount:  Array<driverDetailsModalClass> = []
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var vhicalListData : Array<String> = []
    var vhicalTypeId = Int()
    
    @IBOutlet weak var PopUpView: UIView!
    let categoryDrop = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.categoryDrop
        ]
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.PopUpView.isHidden = false
        
        if Connectivity.isConnectedToInternet
        {
           
            self.vehicle_informnation(DriverId: UserDetail.shared.getUserDriverId())
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }

    }
    
    
    func ForUserIntractionEnable(){
        
        self.vehicalTypee.isUserInteractionEnabled = true
        self.carColorTxte.isUserInteractionEnabled = true
        self.makeVehicleTxte.isUserInteractionEnabled = true
        self.modelOfVehicale.isUserInteractionEnabled = true
        self.registrationTxte.isUserInteractionEnabled = true
        self.pCODriverLicenceNoTxte.isUserInteractionEnabled = true
        self.pCOVehicleLicenceNoTxte.isUserInteractionEnabled = true
        self.pCOLicenceNoTxte.isUserInteractionEnabled = true
        self.insuranceExpiryBtn.isUserInteractionEnabled = true
        self.mOTExpiryBtn.isUserInteractionEnabled = true
        self.niNumberTxte.isUserInteractionEnabled = true
    }
    
    
    func ForUserIntractionEnableFalse(){
        
        self.vehicalTypee.isUserInteractionEnabled = false
        self.carColorTxte.isUserInteractionEnabled = false
        self.makeVehicleTxte.isUserInteractionEnabled = false
        self.modelOfVehicale.isUserInteractionEnabled = false
        self.registrationTxte.isUserInteractionEnabled = false
        self.pCODriverLicenceNoTxte.isUserInteractionEnabled = false
        self.pCOVehicleLicenceNoTxte.isUserInteractionEnabled = false
        self.pCOLicenceNoTxte.isUserInteractionEnabled = false
        self.insuranceExpiryBtn.isUserInteractionEnabled = false
        self.mOTExpiryBtn.isUserInteractionEnabled = false
        self.niNumberTxte.isUserInteractionEnabled = false
    }

    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
    
    @IBAction func editBtnAction(_ sender: UIButton) {
        
        if sender.currentTitle == "Edit" {
            sender.setTitle("Save", for: .normal)
            
            self.ForUserIntractionEnable()
            
        }else{
      
            self.ForUserIntractionEnableFalse()
            sender.setTitle("Edit", for: .normal)
        }
    }
    
    
    @IBAction func okBtnAction(_ sender: UIButton) {
        
        self.PopUpView.isHidden = true
    }
    
    @IBAction func contactBtnAction(_ sender: UIButton) {
        
       dialNumber(number: "\(+4402071481900)")
        
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


extension VehicleInfromationViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "vechicalCell", for: indexPath) as! vechicalIformationCell
        cell.selectionStyle = .none
        cell.vehicalType.isUserInteractionEnabled = false
       cell.carColorTxt.isUserInteractionEnabled = false
       cell.makeVehicleTxt.isUserInteractionEnabled = false
       cell.modelOfVehical.isUserInteractionEnabled = false
       cell.registrationTxt.isUserInteractionEnabled = false
       cell.pCODriverLicenceNoTxt.isUserInteractionEnabled = false
       cell.pCOVehicleLicenceNoTxt.isUserInteractionEnabled = false
       cell.pCOLicenceNoTxt.isUserInteractionEnabled = false
       cell.insuranceExpiryBtn.isUserInteractionEnabled = false
       cell.mOTExpiryBtn.isUserInteractionEnabled = false
       cell.niNumberTxt.isUserInteractionEnabled = false
        

        cell.carColorTxt.setLeftPaddingPoints(10)
        cell.makeVehicleTxt.setLeftPaddingPoints(10)
        cell.modelOfVehical.setLeftPaddingPoints(10)
        cell.registrationTxt.setLeftPaddingPoints(10)
        cell.pCODriverLicenceNoTxt.setLeftPaddingPoints(10)
        cell.pCOVehicleLicenceNoTxt.setLeftPaddingPoints(10)
        cell.niNumberTxt.setLeftPaddingPoints(10)
        cell.pCOLicenceNoTxt.setLeftPaddingPoints(10)
        
        self.vehicalTypee = cell.vehicalType
        self.carColorTxte = cell.carColorTxt
        self.makeVehicleTxte = cell.makeVehicleTxt
        self.modelOfVehicale =  cell.modelOfVehical
        self.registrationTxte = cell.registrationTxt
        self.pCODriverLicenceNoTxte = cell.pCODriverLicenceNoTxt
        self.pCOVehicleLicenceNoTxte = cell.pCOVehicleLicenceNoTxt
        self.pCOLicenceNoTxte = cell.pCOLicenceNoTxt
        self.insuranceExpiryBtn = cell.insuranceExpiryBtn
        self.mOTExpiryBtn = cell.mOTExpiryBtn
        self.niNumberTxte = cell.niNumberTxt
        
        
        
        cell.selectionStyle = .none
        cell.insuranceExpiryBtn.tag = indexPath.row + 76
        cell.insuranceExpiryBtn.addTarget(self, action: #selector(self.insuranceExpiryBtnAction(_:)), for: .touchUpInside)
        
      
        cell.mOTExpiryBtn.tag = indexPath.row + 78
        cell.mOTExpiryBtn.addTarget(self, action: #selector(self.mOTExpiryBtnAction(_:)), for: .touchUpInside)
            
        cell.vehicalType.tag = indexPath.row + 800
        cell.vehicalType.addTarget(self, action: #selector(self.vehicalTypeBtnAction(_:)), for: .touchUpInside)
        
        
        
        
        if self.dataCount.count > 0 {
            let dict = self.dataCount[indexPath.row] as driverDetailsModalClass
            cell.vehicalType.setTitle(dict.vehicalName, for: .normal)
            cell.carColorTxt.text = dict.carColor
            cell.makeVehicleTxt.text = dict.makeOfVehical
            cell.modelOfVehical.text = dict.ModalOfVehical
            cell.registrationTxt.text = dict.registration
            cell.pCODriverLicenceNoTxt.text = dict.pCODriverLicenceNo
            cell.pCOVehicleLicenceNoTxt.text = dict.pCOVehicleLicenceNo
            cell.pCOLicenceNoTxt.text = dict.pcoLicenceNo
            cell.niNumberTxt.text = "\(dict.NInumber)"
            cell.insuranceExpiryBtn.setTitle(dict.InsuranceExpiry, for: .normal)
            cell.mOTExpiryBtn.setTitle(dict.MotExpiry, for: .normal)
            
        }
        

        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 850
    }

    
    @objc func mOTExpiryBtnAction (_ sender : UIButton){
        forSlectDate()
    }
    
    @objc func insuranceExpiryBtnAction (_ sender : UIButton){
        forSlectDate()
        
    }
    
    @objc func vehicalTypeBtnAction (_ sender : UIButton){

        self.categoryDrop.anchorView = sender
        self.categoryDrop.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        self.categoryDrop.dataSource.removeAll()
        self.categoryDrop.dataSource.append(contentsOf: self.vhicalListData)
        self.categoryDrop.selectionAction = { [unowned self] (index, item) in
            sender.setTitle(item, for: .normal)
            self.vhicalTypeId = index + 1
                 print(self.vhicalTypeId,item)

     
        }
        self.categoryDrop.show()

}
    
    
    func forSlectDate(){
        
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
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        let dateString = date.stringFromFormat("dd/MMM/yyyy")
        debugPrint(dateString)
        //dataCount
       
        
        
    }
    
    
    
    
}

class vechicalIformationCell: UITableViewCell {
   
    @IBOutlet weak var vehicalType: UIButton!
    @IBOutlet weak var carColorTxt: UITextField!
    @IBOutlet weak var makeVehicleTxt: UITextField!
    @IBOutlet weak var modelOfVehical: UITextField!
    @IBOutlet weak var registrationTxt: UITextField!
    @IBOutlet weak var pCODriverLicenceNoTxt: UITextField!
    @IBOutlet weak var pCOVehicleLicenceNoTxt: UITextField!
    @IBOutlet weak var pCOLicenceNoTxt: UITextField!
    @IBOutlet weak var insuranceExpiryBtn: UIButton!
    @IBOutlet weak var mOTExpiryBtn: UIButton!
    @IBOutlet weak var niNumberTxt: UITextField!
    

}

