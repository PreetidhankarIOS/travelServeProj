//
//  StartTripViewController.swift
//  DrivaPartner
//
//  Created by Manoj Singh on 19/11/18.
//  Copyright © 2018 Manoj Singh. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import MapKit


class StartTripViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var userPaxName = String()


    @IBOutlet weak var durationLib: UILabel!
    @IBOutlet weak var distanceLib: UILabel!
    @IBOutlet weak var secondViewBottum: UIView!
    @IBOutlet weak var bottumView: UIView!
    var locationManager = CLLocationManager()
    var riderInfoObj = upcomingModaldata()
    var toAddress = String()
    var lati = String()
    var longi = String()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var OnSiteBool : Bool = false
    
    var fromLat = Double()
    var fromLong = Double()
    var adressTo =  String()


    @IBOutlet weak var onsiteBtn: UIButton!
    var Alocation = String()
    var vhicalBookinId = String()

    var PriceModelId = Int()
    var PFCIId = Int()
    var LocationId = Int()
    var jobPrice = String()
    var userPicUpLat = Double()
    var userPicUpLong = Double()
                        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
          self.initialMethod()
          self.secondViewBottum.viewWithShadow()
          self.bottumView.viewWithShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        mapView.clear()
        self.forckStartTrip()
        self.GeoCoddingMeth()
        
    }
    
    @IBAction func leftBarButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    @IBAction func commonButtonAction(_ sender: UIButton) {
        self.OnSiteBool = true
        switch sender.tag {
        case 101:

            dialNumber(number: "\(+4402071481900)")
            
            break
            
        case 102:

            debugPrint("\(UserDetail.shared.getUserLat()),\(UserDetail.shared.getUserLong()),\(self.userPicUpLat),\(self.userPicUpLong)")
            let coordinate₀ = CLLocation(latitude: Double(UserDetail.shared.getUserLat())!, longitude: Double(UserDetail.shared.getUserLong())!)
            let coordinate₁ = CLLocation(latitude: Double(self.userPicUpLat), longitude: Double(self.userPicUpLong))
            let distanceInMeters = coordinate₀.distance(from: coordinate₁)
             debugPrint(distanceInMeters)
            
            if distanceInMeters > 500 {
               
                PDAlert.shared.showAlertWith("Alert!", message: "You Cannot Click on this button untill or unless you reach within 500 Meters of Pickup Location", onVC: self)
                
            }else{
               
                if Connectivity.isConnectedToInternet {
                    
                    if vhicalBookinId == "" {
                       vhicalBookinId =  UserDefaults.standard.string(forKey: "VehicleBooking_Id")!
                    }

                    self.start_On_Site_Driver(VehicleBooking_Id: vhicalBookinId, DriverId: UserDetail.shared.getUserDriverId(), OnSideLatitude: UserDetail.shared.getUserLat(), OnSideLongitude: UserDetail.shared.getUserLong(), OnSideLocation: self.Alocation)
                }else{
                    PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
                }
            }
            

            
           break

        default:
            break
        }
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

    func GeoCoddingMeth(){
        
        let location = CLLocationCoordinate2D.init(latitude: Double(UserDetail.shared.getUserLat())!, longitude:Double(UserDetail.shared.getUserLong())!)
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { response, error in
              guard let address = response?.firstResult(), let lines = address.lines else {
                  return
              }
            self.Alocation = lines.joined(separator: "\n")
            UserDetail.shared.setUserCurrentLocationAdress(self.Alocation)
              debugPrint(address)
            self.fetchMapData(UserDetail.shared.getUserLat(), toLog: UserDetail.shared.getUserLong())
        }
    }
}

extension StartTripViewController {
    
    // MARK:- Helper Method
    func initialMethod() {

        self.topView.viewWithShadow()
        self.headingLabel.text! = self.userPaxName
        self.addressLabel.text = self.adressTo
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.fromLat = locValue.latitude
        self.fromLong = locValue.longitude
        UserDetail.shared.setUserLat("\(locValue.latitude)")
        UserDetail.shared.setUserLong("\(locValue.longitude)")

         
    }
    
    
    func forckStartTrip(){
        
        if (UserDefaults.standard.bool(forKey: ckStartTrip)) == true {
            
          let psengerName =  UserDefaults.standard.string(forKey: "psengerName")
            self.headingLabel.text! = psengerName!
            
         let pickUpAdress =  UserDefaults.standard.string(forKey: "pickUpAdress")
         self.addressLabel.text! = pickUpAdress!
   
        }
        
    }

}

