//
//  upcomingRequestViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class upcomingRequestViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    @IBOutlet weak var mainTableView: UITableView!
       var dataCount : Array<upcomingModaldata> = []
       var dataCountt : Array<AnyObject> = []
       lazy var geocoder = CLGeocoder()
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
    
    var booking_id = Int()
    var FileBookingId = Int()
    var addressString = String()
    
    var fileBooking_id_for_Cancel = String()
    @IBOutlet weak var riderNotShowButton: UIButton!
    @IBOutlet weak var riderRequestedCancelButton: UIButton!
    @IBOutlet weak var wrongAddressShowButton: UIButton!
    @IBOutlet weak var tooManyRidersButton: UIButton!
    @IBOutlet weak var tooMuchLuggageButton: UIButton!
    //@IBOutlet weak var froudRiderButton: UIButton!
    var bookingID = ""
    var reasonStr = ""
    @IBOutlet weak var cancelRideView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTableView.separatorStyle = .none
        
        
        if Connectivity.isConnectedToInternet
        {
            upcoming_Rquest_listPage(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
        
        self.cancelRideView.isHidden = true

    }
    
   
    
    @IBAction func menuBtnAction(_ sender: Any) {
        
         DispatchQueue.main.async {
        if Connectivity.isConnectedToInternet
        {
            self.upcoming_Rquest_listPage(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }

    }
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.curentLocation()
          
        }
    }
    
    func curentLocation(){
        
        locManager.requestWhenInUseAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            if let lat = currentLocation?.coordinate.latitude{
                lati = "\(lat)"
            }
            if let lng = currentLocation?.coordinate.longitude{
                longi = "\(lng)"
            }
            
             self.forLocationAddress()
        }
    }
    
    
    @IBAction func commonButtonAction(_ sender: UIButton) {
        
        self.riderNotShowButton.isSelected = false
        self.riderRequestedCancelButton.isSelected = false
        self.wrongAddressShowButton.isSelected = false
        self.tooManyRidersButton.isSelected = false
        self.tooMuchLuggageButton.isSelected = false
        
        
        switch sender.tag {
            
        case 100:
            self.riderNotShowButton.isSelected = true
            self.reasonStr = "Rider no show"
            
            break
        case 101:
            self.riderRequestedCancelButton.isSelected = true
            self.reasonStr = "Rider requested cancel"
            
            break
        case 102:
            self.wrongAddressShowButton.isSelected = true
            self.reasonStr = "Wrong address show"
            
            break
        case 103:
            self.tooManyRidersButton.isSelected = true
            self.reasonStr = "Too much riders"
            
            break
        case 104:
            self.tooMuchLuggageButton.isSelected = true
            self.reasonStr = "Too much luggage"
            
            break
        default:
            break
        }
    }

    
    
    @IBAction func dontCanceBtnAction(_ sender: UIButton) {
        
         self.cancelRideView.isHidden = true
        
    }
    
    @IBAction func cancelBtnPopUpAction(_ sender: UIButton) {
        
        if Connectivity.isConnectedToInternet
        {
            self.Cancel_Bookimg_on_popup_API(Reason: reasonStr, fileBooking_id: "\(self.fileBooking_id_for_Cancel)")
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
        
    }
    
    
}

extension upcomingRequestViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
 
        if self.dataCountt.count > 0 {
            return self.dataCountt.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "upcomingRequestCell", for: indexPath) as! upcomingRequestTableViewCell

            let dict = self.dataCountt[indexPath.row] as! upcomingModaldata

        cell.fileBookingId.text = dict.FileBookingId
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
            cell.acknowldgeBtn.ButtonWithShadow()
            cell.cancelBookingBtn.ButtonWithShadow()
            cell.remarkLib.text = dict.SpecialRequest
            cell.selectionStyle = .none
            cell.acknowldgeBtn.tag = indexPath.row + 66
            cell.acknowldgeBtn.addTarget(self, action: #selector(self.acknowldgeBtnAction(_:)), for: .touchUpInside)
            cell.cancelBookingBtn.tag = indexPath.row + 67
            cell.cancelBookingBtn.addTarget(self, action: #selector(self.cancelBookingBtnAction(_:)), for: .touchUpInside)
            self.booking_id = dict.VehicleBookingId
           cell.pickupTypeLib.text = dict.pickupType
            return cell
    }

    @objc func acknowldgeBtnAction (_ sender : UIButton){
        
        let index = sender.tag - 66
        let indexPath = IndexPath.init(item: index, section: 0)
        if let cell = mainTableView.cellForRow(at: indexPath) as? upcomingRequestTableViewCell {

            if Connectivity.isConnectedToInternet
            {
                Acknowldge_Bookimg_API(ALatitude: UserDetail.shared.getUserLat(), ALocation: cell.pickUpFromLib.text!, ALongitude: UserDetail.shared.getUserLong(), VehicleBookingId: "\(self.booking_id)")
                
            }else{
                PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
            }
        }
    }
    @objc func cancelBookingBtnAction (_ sender : UIButton){
        
        let index = sender.tag - 67
        let indexPath = IndexPath.init(item: index, section: 0)
        if let cell = mainTableView.cellForRow(at: indexPath) as? upcomingRequestTableViewCell {
         self.fileBooking_id_for_Cancel =  cell.fileBookingId.text!
            self.cancelRideView.isHidden = false
            self.cancelRideView.dropShadow()
              self.reasonStr = "Rider no show"
        }
   }

func forLocationAdress(completion: (() -> ())){
    
       self.forLocationAddress()
}
    func forLocationAddress(){

        guard let lat = Double("\(lati)") else { return }
        guard let lng = Double("\(longi)") else { return }
        let location = CLLocation(latitude: lat, longitude: lng)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }

    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
           // locationLabel.text = "Unable to Find Address for Location"
            
        } else {
            if let placemarks = placemarks, let placemarkk = placemarks.first {
                
                self.addressString = placemarkk.compactAddress!
                print("\(placemarkk.compactAddress!)")
               
            } else {
                print("Unable to Find Address for Location")
            }
        }
    }
}

class upcomingRequestTableViewCell: UITableViewCell {

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
    @IBOutlet weak var acknowldgeBtn: UIButton!
    @IBOutlet weak var cancelBookingBtn: UIButton!
    @IBOutlet weak var driverPriceLib: UILabel!
    @IBOutlet weak var travelServePriceLib: UILabel!
    @IBOutlet weak var travelServeNameLib: UILabel!
    @IBOutlet weak var pickupTypeLib: UILabel!
    
}


extension CLPlacemark {
    
    var compactAddress: String? {
        if let name = name {
            var result = name

            if let postalCode = postalCode{
                result += ", \(postalCode)"
            }
            
            if let subLocality = subLocality{
                result += ", \(subLocality)"
            }
            
            if let street = thoroughfare {
                result += ", \(street)"
            }
            
            if let city = locality {
                result += ", \(city)"
            }
            
            if let country = country {
                result += ", \(country)"
            }
            
           
            return result
        }
        
        return nil
    }
    
}
