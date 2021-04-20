//
//  poolViewController.swift
//  travelServe
//
//  Created by Developer on 25/09/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class poolViewController: UIViewController {

    @IBOutlet weak var requtestedJobBtn: UIButton!
    @IBOutlet weak var poolJobBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    var ListAllData : Array<AnyObject> = []
    var poolsJobListAllData : Array<AnyObject> = []
    var poolJobs: Bool = false
    var dataCountForJobPool : Array<Dictionary<String, AnyObject>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.poolJobs = true
      mainTableView.separatorStyle = .none
     
      
        poolJobBtn.backgroundColor = UIColor.darkGray
        requtestedJobBtn.backgroundColor = UIColor.lightGray
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           apiCalingHere()
    }
    
    
    
    
    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }

    @IBAction func poolJobsBtnAction(_ sender: UIButton) {
        self.poolJobs = true
        poolJobBtn.backgroundColor = UIColor.darkGray
        requtestedJobBtn.backgroundColor = UIColor.lightGray
        apiCalingHere()
        
    }
    
    @IBAction func requestedJobBtnAction(_ sender: UIButton) {
        self.poolJobs = false
        poolJobBtn.backgroundColor = UIColor.lightGray
        requtestedJobBtn.backgroundColor = UIColor.darkGray
        apiCalingHere()
    }
    
    
    
    
    func apiCalingHere(){
        
        if Connectivity.isConnectedToInternet
        {
            self.jobPool_informnation(DriverId: UserDetail.shared.getUserDriverId())
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }

}


extension poolViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if poolJobs == true {
            return  self.ListAllData.count
        }else{
            return  self.poolsJobListAllData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobPoolTV") as! jobPoolTVCell
        
         cell.selectionStyle = .none
        
        if poolJobs == true {

            
                let dict =  self.ListAllData[indexPath.row] as! poolJobsModalData
                cell.fileBookingId.text = dict.FileBookingId
            
            if dict.messagee == "No Data Found" {
                
                let image: UIImage = UIImage(named: "ic_notfound")!
                let imageView = UIImageView(image: image)
                self.view.addSubview(imageView)
                imageView.frame = CGRect(x: 0,y: 0,width: 200,height: 150)
                imageView.center = self.view.center
                cell.isHidden = true
                
            }
                
            
            cell.paymentTypeLib.text = dict.PaymentTypeName
            
            
            if dict.PaymentTypeName == "Cash" || dict.PaymentTypeName == "Credit Card" {
                
                cell.travelServePriceLib.text = "£ \(dict.TravelServeTotalPrice)"
                cell.driverPriceLib.text = "£ \(dict.DriverTotalPriceNew)"

                
            }else
            {

                cell.travelServePriceLib.isHidden = true
                cell.travelServeNameLib.isHidden = true
                cell.driverPriceLib.text = "£ \(dict.DriverTotalPriceNew)"
            }
            
            if dict.RequestCount == 0 {
                cell.requestedLib.isHidden = true
            }else{
                cell.requestedLib.isHidden = false
            }

                let create_date  = dict.BookingDate.getFormateDate(fromFormate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormate: "dd MMM, yyyy")
                cell.confirmedDatelib.text = create_date
                cell.pickUpFromLib.text = dict.PickupLocationName
                cell.dropoffLib.text = dict.DropLocationName
                cell.pickUpTime.text = dict.PickUpTime
                cell.paxContectNumberLib.text = dict.ContactNo
                cell.paxNameLib.text = dict.LeadPaxName
                cell.paxInfomationLib.text = "\(dict.max)"
                cell.numbarBags.text = "\(dict.TotalBag)"
                cell.remarkLib.text = dict.SpecialRequest
                cell.pickupTypeLib.text = dict.pickupType
            
        }else{
            
            //if self.poolsJobListAllData.count <= 0{
            
             let dict =  self.poolsJobListAllData[indexPath.row] as! poolJobsModalData
            cell.fileBookingId.text = dict.FileBookingId
            
            if dict.messagee == "No Data Found"{
                
                let image: UIImage = UIImage(named: "ic_notfound")!
                let imageView = UIImageView(image: image)
                self.view.addSubview(imageView)
                imageView.frame = CGRect(x: 0,y: 0,width: 200,height: 150)
                imageView.center = self.view.center
                cell.isHidden = true
                
            }
           
            if dict.RequestCount == 0 {
                cell.requestedLib.isHidden = true
            }else{
                cell.requestedLib.isHidden = false
            }
            
            cell.paymentTypeLib.text = dict.PaymentTypeName
                   
                   
                   if dict.PaymentTypeName == "Cash" || dict.PaymentTypeName == "Credit Card" {
                       
                       cell.travelServePriceLib.text = "£ \(dict.TravelServeTotalPrice)"
                       cell.driverPriceLib.text = "£ \(dict.DriverTotalPriceNew)"

                       
                   }else
                   {

                       cell.travelServePriceLib.isHidden = true
                       cell.travelServeNameLib.isHidden = true
                       cell.driverPriceLib.text = "£ \(dict.DriverTotalPriceNew)"
                   }

            let create_date  = dict.BookingDate.getFormateDate(fromFormate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormate: "dd MMM, yyyy")
            cell.confirmedDatelib.text = create_date
            cell.pickUpFromLib.text = dict.PickupLocationName
            cell.dropoffLib.text = dict.DropLocationName
            cell.pickUpTime.text = dict.PickUpTime
            cell.paxContectNumberLib.text = dict.ContactNo
            cell.paxNameLib.text = dict.LeadPaxName
            cell.paxInfomationLib.text = "\(dict.max)"
            cell.numbarBags.text = "\(dict.TotalBag)"
            cell.remarkLib.text = dict.SpecialRequest
            cell.pickupTypeLib.text = dict.pickupType
     
    }
        cell.requestForJobBtnAction.tag = indexPath.row + 67
        cell.requestForJobBtnAction.addTarget(self, action: #selector(self.requestBookingBtnAction(_:)), for: .touchUpInside)
        cell.requestForJobBtnAction.ButtonWithShadow()
        
        
        return cell

}
    
    
    @objc func requestBookingBtnAction (_ sender : UIButton){
        
        let index = sender.tag - 67
        let indexPath = IndexPath.init(item: index, section: 0)
        if let cell = mainTableView.cellForRow(at: indexPath) as? jobPoolTVCell {
            if Connectivity.isConnectedToInternet
            {
                self.jobPool_Requsted(DriverId: UserDetail.shared.getUserDriverId(), fileBooking_id: cell.fileBookingId.text!)
                
            }else{
                PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
            }
            
            // ListAllData.remove(at: index)
            self.ListAllData.remove(at: index)  // don't forget to replace your array of data source
            
            self.mainTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            
        }
    }

    
}

class jobPoolTVCell: UITableViewCell {
    
    @IBOutlet weak var fileBookingId:          UILabel!
    @IBOutlet weak var confirmedDatelib:       UILabel!
    @IBOutlet weak var paymentTypeLib:         UILabel!
    @IBOutlet weak var pickUpFromLib:          UILabel!
    @IBOutlet weak var dropoffLib:             UILabel!
    @IBOutlet weak var pickUpTime:             UILabel!
    @IBOutlet weak var paxInfomationLib:       UILabel!
    @IBOutlet weak var paxNameLib:             UILabel!
    @IBOutlet weak var paxContectNumberLib:    UILabel!
    @IBOutlet weak var numbarBags:             UILabel!
    @IBOutlet weak var pickupTypeLib: UILabel!
    @IBOutlet weak var remarkLib:              UILabel!
    @IBOutlet weak var requestForJobBtnAction: UIButton!
    @IBOutlet weak var driverPriceLib:         UILabel!
    @IBOutlet weak var travelServePriceLib:    UILabel!
    @IBOutlet weak var travelServeNameLib:     UILabel!
    @IBOutlet weak var requestedLib:           UILabel!
    
}


