//
//  acknowledgeRequestViewController.swift
//  travelServe
//
//  Created by Developer on 05/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import CoreLocation

class acknowledgeRequestViewController: UIViewController {
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
    var Alocation = String()
    var dataCount: Array<upcomingModaldata> = []
    var StartJobdataCount: Array<startJobModal> = []
    var dataCountt : Array<AnyObject> = []
    var VehicleBooking_Id = Int()
    var TransferBookingId = Int()
    var psengerName = String()
    var dropAdress = String()
     var pickUpAdress = String()
    var startJob: Bool = false
    var FromLat = Double()
    var FromLong = Double()

     var PriceModelId  = Int()
     var PFCIId  = Int()
     var LocationId  = Int()
    
    var driverPrice = String()
    var travelServePrice = String()
    
    

    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.separatorStyle = .none
       
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
          self.navigationController?.isNavigationBarHidden = false
        
        self.upcoming_Rquest_listPage(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())

        self.curentLocation()
        //currentLocationn ()

    }
    
    
    @IBAction func backBtnAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

extension acknowledgeRequestViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.dataCountt.count > 0 {
            return self.dataCountt.count
        }else{
            return 0
        }
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! requestTableViewCell
        let dict = dataCountt[indexPath.row]  as! upcomingModaldata
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
           // cell.amountLib.text = "\(dict.TravelServeTotalPrice)"
            let create_date  = dict.BookingDate.getFormateDate(fromFormate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormate: "dd MMM, yyyy")
            cell.confirmedDatelib.text = create_date
        
            cell.pickUpFromLib.text = dict.PickupLocationName
            cell.dropoffLib.text = dict.DropLocationName
            cell.pickUpTime.text = dict.PickUpTime
            cell.paxContectNumberLib.text = dict.ContactNo
            cell.paxNameLib.text = dict.LeadPaxName
        
            cell.paxInfomationLib.text = "\(dict.max)"
            cell.numbarBags.text = "\(dict.TotalBag)"
            //cell.paymentTypeLib.text = dict.PaymentTypeName
            cell.startBtnJob.ButtonWithShadow()
            cell.remarkLib.text = dict.SpecialRequest
        
            self.VehicleBooking_Id = dict.VehicleBookingId
            self.TransferBookingId = dict.TransferBookingId
        
            cell.selectionStyle = .none
            cell.startJobBtn.tag = indexPath.row + 86
            cell.startJobBtn.addTarget(self, action: #selector(self.startJobBtnAction(_:)), for: .touchUpInside)
             
            cell.PriceModelIdc = dict.PriceModelId
            cell.PFCIIdc = dict.PFCIId
            cell.LocationIdc = dict.LocationId
            cell.pickupTypeLib.text = dict.pickupType
        

        return cell
    }

    @objc func startJobBtnAction (_ sender : UIButton){
        
        let index = sender.tag - 86
        let indexPath = IndexPath.init(item: index, section: 0)

          if let cell = mainTableView.cellForRow(at: indexPath) as? requestTableViewCell {
             self.psengerName = cell.paxNameLib.text!
            self.dropAdress = cell.dropoffLib.text!
            self.pickUpAdress = cell.pickUpFromLib.text!
            UserDetail.shared.setfileBookingId(cell.fileBookingId.text!)
            
            self.PriceModelId   = cell.PriceModelIdc
            self.PFCIId   = cell.PFCIIdc
            self.LocationId  = cell.LocationIdc
            
            if   cell.paymentTypeLib.text == "Cash" ||   cell.paymentTypeLib.text == "Credit Card" {
                              
                self.travelServePrice = cell.travelServePriceLib.text!
          }
            else
          {
            self.travelServePrice = cell.driverPriceLib.text!
          }

            DispatchQueue.main.async {
               self.getAddress(address: cell.pickUpFromLib.text!)
            }

            self.startJob_byDriver(VehicleBooking_Id: "\(self.VehicleBooking_Id)", DriverId: UserDetail.shared.getUserDriverId(), ALocation: UserDetail.shared.getUserCurrentLocationAdress(), ALongitude: self.longi, ALatitude: self.lati, TransferBookingId:"\(self.TransferBookingId)")
        }
    }

}


class requestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startBtnJob: UIButton!
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
    @IBOutlet weak var pickupTypeLib: UILabel!
    
    @IBOutlet weak var startJobBtn: UIButton!
    @IBOutlet weak var remarkLib: UILabel!
    
    
    var PriceModelIdc  = Int()
    var PFCIIdc  = Int()
    var LocationIdc  = Int()
    var JobPrice = Double()

     @IBOutlet weak var driverPriceLib: UILabel!
     @IBOutlet weak var travelServePriceLib: UILabel!
     @IBOutlet weak var travelServeNameLib: UILabel!

}
