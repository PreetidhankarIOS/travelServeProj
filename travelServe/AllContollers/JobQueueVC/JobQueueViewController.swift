//
//  JobQueueViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import CoreLocation

class JobQueueViewController: UIViewController {

    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
    var Alocation = String()
    var dataCount: Array<AnyObject> = []
    var StartJobdataCount: Array<startJobModal> = []
    var dataCounttINJobQueue : Array<AnyObject> = []
    var VehicleBooking_Id = Int()
    var TransferBookingId = Int()
    var psengerName = String()
    var dropAdress = String()
    var pickUpAdress = String()
    
    var FromLat = Double()
    var FromLong = Double()
    
    
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        if Connectivity.isConnectedToInternet
        {
              self.upcoming_Rquest_listPage(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())
            
        }else{
            
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }

        self.curentLocation()
        //currentLocationn ()
        
    }
    
    
    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }

    }
 
}

extension JobQueueViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataCounttINJobQueue.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "jobQueue", for: indexPath) as! jobQueueViewTableViewCell
        let dict = self.dataCounttINJobQueue[indexPath.row] as! upcomingModaldata

        if dict.message ==  "No Data Found" {
                               
           PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "You Don't have any Acknowleged booking right now.", yes: "Ok", onVC: self){
                  
                  let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let nextViewController = storyBord.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
                  self.navigationController?.pushViewController(nextViewController, animated: true)
                                
               }
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

        cell.fileBookingId.text = dict.FileBookingId
        let create_date  = dict.BookingDate.getFormateDate(fromFormate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormate: "dd MMM, yyyy")
        cell.confirmedDatelib.text = create_date
        
        cell.pickUpFromLib.text = dict.PickupLocationName
        cell.dropoffLib.text = dict.DropLocationName
        cell.pickUpTime.text = dict.PickUpTime
        cell.paxContectNumberLib.text = dict.ContactNo
        cell.paxNameLib.text = dict.LeadPaxName
        
        cell.paxInfomationLib.text = "\(dict.max)"
        cell.numbarBags.text = "\(dict.TotalBag)"
        cell.startJobBtn.ButtonWithShadow()
        cell.remarkLib.text = dict.SpecialRequest
        
        self.VehicleBooking_Id = dict.VehicleBookingId
        self.TransferBookingId = dict.TransferBookingId
         cell.pickupTypeLib.text = dict.pickupType
        
        cell.selectionStyle = .none
        cell.startJobBtn.tag = indexPath.row + 44
        cell.startJobBtn.addTarget(self, action: #selector(self.startJobBtnAction(_:)), for: .touchUpInside)
       return cell
    }
    
    @objc func startJobBtnAction (_ sender : UIButton){
        
        let index = sender.tag - 44
        let indexPath = IndexPath.init(item: index, section: 0)
        if let cell = mainTableView.cellForRow(at: indexPath) as? jobQueueViewTableViewCell {
            self.psengerName = cell.paxNameLib.text!
            self.dropAdress = cell.dropoffLib.text!
            self.pickUpAdress = cell.pickUpFromLib.text!
            UserDetail.shared.setfileBookingId(cell.fileBookingId.text!)
            self.startJob_byDriver(VehicleBooking_Id: "\(self.VehicleBooking_Id)", DriverId: UserDetail.shared.getUserDriverId(), ALocation: UserDetail.shared.getUserCurrentLocationAdress(), ALongitude: self.longi, ALatitude: self.lati, TransferBookingId:"\(self.TransferBookingId)")
        }
    }
}


class jobQueueViewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fileBookingId: UILabel!
    @IBOutlet weak var confirmedDatelib: UILabel!
    @IBOutlet weak var paymentTypeLib: UILabel!
    @IBOutlet weak var pickUpFromLib: UILabel!
    @IBOutlet weak var dropoffLib: UILabel!
    @IBOutlet weak var pickUpTime: UILabel!
    @IBOutlet weak var paxInfomationLib: UILabel!
    @IBOutlet weak var paxNameLib: UILabel!
    @IBOutlet weak var paxContectNumberLib: UILabel!
    @IBOutlet weak var numbarBags: UILabel!
    @IBOutlet weak var remarkLib: UILabel!
    @IBOutlet weak var startJobBtn: UIButton!
    @IBOutlet weak var pickupTypeLib: UILabel!
    
    
    @IBOutlet weak var driverPriceLib: UILabel!
    @IBOutlet weak var travelServePriceLib: UILabel!
    @IBOutlet weak var travelServeNameLib: UILabel!
    
    
    
}
