//
//  driverStatmentViewController.swift
//  travelServe
//
//  Created by Developer on 27/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class driverStatmentViewController: UIViewController {

    @IBOutlet weak var commToTSL: UILabel!
    @IBOutlet weak var totalSales: UILabel!
    @IBOutlet weak var paymentFromTSL: UILabel!
    @IBOutlet weak var driverEarings: UILabel!
    @IBOutlet weak var cashCashLib: UILabel!
    @IBOutlet weak var cashCommissionLib: UILabel!
    @IBOutlet weak var amountCashLib: UILabel!
    @IBOutlet weak var amountCommissionLib: UILabel!
    @IBOutlet weak var cardCashLib: UILabel!
    @IBOutlet weak var cardCommissionLib: UILabel!
    @IBOutlet weak var queryTxtView: UITextView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var fileBookingIdLib: UILabel!
    var CellButtonTitalChange = UIButton()
    var vhicalFilebookingId = String()
    var tapGest:UITapGestureRecognizer!
    var dataCounttAmount : Array<AnyObject> = []
    var dataCountList : Array<AnyObject> = []
     var notRequsteData : Array<AnyObject> = []
    
    @IBOutlet weak var SendRequestViewWhite: UIView!
    @IBOutlet weak var ApproveViewWhite: UIView!
    
    
    
    @IBOutlet weak var approveTableView: UITableView!
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
      self.apiCalingHere()
    self.popUpView.isHidden = true

        self.mainTableView.separatorStyle = .none
        
        self.tapGest = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        popUpView.addGestureRecognizer(self.tapGest)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.popUpView.isHidden = true
    }
    
    
    func apiCalingHere(){
        
        if Connectivity.isConnectedToInternet
        {
            self.driver_Statement_API()
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }

    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
    
    @IBAction func approvedBtnAction(_ sender: UIBarButtonItem) {
        
         self.popUpView.isHidden = false
         ApproveViewWhite.isHidden = false
         SendRequestViewWhite.isHidden = true
         approveTableView.reloadData()
        
    }
    
    @IBAction func approveAllBtnAction(_ sender: Any) {
        
        ApproveViewWhite.isHidden = true
        self.popUpView.isHidden = true
         SendRequestViewWhite.isHidden = true
        
        var str = String()
        for iteam in notRequsteData {
            
            str.append(iteam as! String)
            
//            let sentence = notRequsteData(separator: ",")
//        let stringRepresentation = notRequsteData.joined(separator:"-")
//
//        let stringRepresentation = ",".join(notRequsteData)
            
        }
        
       debugPrint(str)

        if Connectivity.isConnectedToInternet
        {
            //self.approveList_API("", vhicalBookingId:str)
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
        
        
    }
    
    
    @IBAction func submitQueryBtnAction(_ sender: UIButton) {
        
       apisubmitQueryHere()
    }
    
    func apisubmitQueryHere(){
        
        if Connectivity.isConnectedToInternet
        {
            SubmitQuery_API(self.queryTxtView.text, vhicalBookingId: self.vhicalFilebookingId )
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }

}


extension driverStatmentViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if dataCountList.count == 0 {
//            
//            PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You Don't have Data", yes: "Ok", onVC: self){
//                
//                let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
//                self.navigationController?.pushViewController(nextViewController, animated: true)
//                
//            }
//            
//        }
//        
        
        if tableView == mainTableView {
            return dataCountList.count
        }else{
            return notRequsteData.count
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   
        
        if tableView == mainTableView {

        let cell = tableView.dequeueReusableCell(withIdentifier: "driverStatment") as! driverStatmentTableViewCell
        
        let dict = self.dataCountList[indexPath.row] as! driverStatementModal
        cell.fileBookingId.text = "\(dict.FileBookingId)"

        
        let firstfont:UIFont = UIFont(name: "Helvetica", size: 15)!
        let boldFont:UIFont = UIFont(name: "Helvetica-Bold", size: 15)!
        
        
        let firstDict:NSDictionary = NSDictionary(object: firstfont, forKey:
            NSAttributedString.Key.font as NSCopying)
        let boldDict:NSDictionary = NSDictionary(object: boldFont, forKey:
            NSAttributedString.Key.font as NSCopying)
        
        
        let firstText = dict.PaymentTypeName
        let boldString = NSMutableAttributedString(string:firstText,
                                                   attributes:firstDict as? [NSAttributedString.Key : Any])
        
        let boldText  =  " : £ \(dict.TravelServeTotalPrice)"
        let boldString2 = NSMutableAttributedString(string:boldText,
                                                    attributes:boldDict as? [NSAttributedString.Key : Any])
        
        boldString.append(boldString2)
        cell.paymentTypeLib.attributedText = boldString
        
        let create_date  = dict.PickupDate.getFormateDate(fromFormate: "dd/MM/yyyy", toFormate: "dd MMM, yyyy")
        cell.confirmedDatelib.text = create_date
        cell.pickUpFromLib.text = dict.PickupLocationName
        cell.dropoffLib.text = dict.DropLocationName
        cell.pickUpTime.text = dict.PickUpTime
        
        cell.MaxPax.text = "\(dict.TotalPax)"
        cell.paxNameLib.text = dict.LeadPaxName
        cell.numbarBags.text = "\(dict.TotalBag)"
        cell.vehicalNameLib.text = dict.VehicleName
        cell.fileVehicalBookingId = "\(dict.VehicleBookingId)"
        cell.paxContectNumberLib.text = dict.ContactNo
        cell.pickupTypeLib.text = dict.pickupType
        cell.selectionStyle = .none
        cell.requestBookingBtn.tag = indexPath.row + 66
        cell.requestBookingBtn.addTarget(self, action: #selector(self.requestBookingBtnAction(_:)), for: .touchUpInside)
            
         if dict.StatementStatus == "Disapproved" {

            cell.requestBookingBtn.setTitle("Request Submitted",for: .normal)
            cell.requestBookingBtn.isEnabled = false
                
        }else{
              cell.requestBookingBtn.setTitle("Raise Request",for: .normal)
        }
  
        return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "approveCell") as! approvelTableViewCell
            let dict = self.notRequsteData[indexPath.row] as! driverStatementModal
           
            cell.FileBookingIdLib.text = "\(dict.FileBookingId)"
            
                   return cell
        }
    
    
        
}
  
    @objc func requestBookingBtnAction (_ sender : UIButton){

        let index = sender.tag - 66
        let indexPath = IndexPath.init(item: index, section: 0)
        if let cell = mainTableView.cellForRow(at: indexPath) as? driverStatmentTableViewCell {
            self.queryTxtView.text = ""
            self.fileBookingIdLib.text =  cell.fileBookingId.text
            self.CellButtonTitalChange =  cell.requestBookingBtn
            self.vhicalFilebookingId  =   cell.fileVehicalBookingId
        }
         self.popUpView.isHidden = false
        ApproveViewWhite.isHidden = true
        SendRequestViewWhite.isHidden = false
    
    }

}

class driverStatmentTableViewCell: UITableViewCell {

    @IBOutlet weak var fileBookingId: UILabel!
    @IBOutlet weak var confirmedDatelib: UILabel!
    @IBOutlet weak var paymentTypeLib: UILabel!
    @IBOutlet weak var pickUpFromLib: UILabel!
    @IBOutlet weak var dropoffLib: UILabel!
    @IBOutlet weak var pickUpTime: UILabel!
    @IBOutlet weak var MaxPax: UILabel!
    @IBOutlet weak var paxNameLib: UILabel!
    @IBOutlet weak var numbarBags: UILabel!
    @IBOutlet weak var vehicalNameLib: UILabel!
    @IBOutlet weak var requestBookingBtn: UIButton!
    @IBOutlet weak var pickupTypeLib: UILabel!
    @IBOutlet weak var paxContectNumberLib: UILabel!
    var fileVehicalBookingId = String()
    
}

class approvelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FileBookingIdLib: UILabel!
    
}
