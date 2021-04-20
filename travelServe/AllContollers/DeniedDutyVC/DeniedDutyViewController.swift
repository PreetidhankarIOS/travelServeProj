//
//  DeniedDutyViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit


class DeniedDutyViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    //var rideCompletData:  Array<rideCompleteModalData> = []
    var dataCountt : Array<AnyObject> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          self.mainTableView.separatorStyle = .none
        if Connectivity.isConnectedToInternet
        {
            self.DeniedDuty_api(DriverId: UserDetail.shared.getUserDriverId())
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
     
    }
    
    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
       
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
    
}


extension DeniedDutyViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCountt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "DeniedDutyCell", for: indexPath) as! DeniedDutyTVcell
        
        let dict = self.dataCountt[indexPath.row] as! rideCompleteModalData
        cell.fileBookingId.text = dict.FileBookingId
        //cell.amountLib.text = "\(dict.TravelServeTotalPrice)"
        let create_date  = dict.BookingDate.getFormateDate(fromFormate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormate: "dd MMM, yyyy")
        cell.confirmedDatelib.text = create_date
        cell.pickUpFromLib.text = dict.PickupLocationName
        cell.dropoffLib.text = dict.DropLocationName
        cell.pickUpTime.text = dict.PickUpTime
        cell.paxContectNumberLib.text = dict.ContactNo
        cell.paxNameLib.text = dict.LeadPaxName
        cell.paxInfomationLib.text = "\(dict.max)"
        cell.numbarBags.text = "\(dict.TotalBag)"
        cell.paymentTypeLib.text = dict.PaymentTypeName
        cell.remarkLib.text = dict.SpecialRequest
        cell.selectionStyle = .none
        cell.pickupTypeLib.text = dict.pickupType
        
        return cell
    }
    
    
}


class DeniedDutyTVcell: UITableViewCell {
    
    @IBOutlet weak var fileBookingId: UILabel!
    @IBOutlet weak var confirmedDatelib: UILabel!
    @IBOutlet weak var paymentTypeLib: UILabel!
    @IBOutlet weak var pickUpFromLib: UILabel!
    @IBOutlet weak var dropoffLib: UILabel!
    @IBOutlet weak var pickUpTime: UILabel!
    @IBOutlet weak var remarkLib: UILabel!
    @IBOutlet weak var paxInfomationLib: UILabel!
    @IBOutlet weak var paxNameLib: UILabel!
    @IBOutlet weak var paxContectNumberLib: UILabel!
    @IBOutlet weak var numbarBags: UILabel!
    @IBOutlet weak var amountLib: UILabel!
    @IBOutlet weak var pickupTypeLib: UILabel!
}
