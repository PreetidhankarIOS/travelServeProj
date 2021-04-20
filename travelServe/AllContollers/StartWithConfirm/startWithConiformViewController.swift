//
//  startWithConiformViewController.swift
//  travelServe
//
//  Created by Developer on 13/07/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class startWithConiformViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {

    @IBOutlet weak var popUpView2: UIView!
    @IBOutlet weak var popUpViewBg: UIView!
    @IBOutlet weak var amountTxt: UITextField!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
     var jobPrice = String()
    @IBOutlet weak var riderNameLib: UILabel!
    var riderName = String()
    var VehicleBookingId = String()
    
    @IBOutlet weak var dropLocationLib: UILabel!
    @IBOutlet weak var timeDistanceLib: UILabel!
    @IBOutlet weak var distanceLib: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mapview: GMSMapView!
    var dropLocation = String()
    var pickUpaddress = String()
    var dropLati = Double()
    var dropLong = Double()
    //var POBCheck =  Bool()
    var dropLatiMAP = Double()
    var dropLongMAP = Double()

    @IBOutlet weak var PNSbtn: UIButton!
    @IBOutlet weak var POBbtn: UIButton!
    @IBOutlet weak var tripCompletBtn: UIButton!
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
    var curentLocationNext = String()
    var payemtType = ""
    var addressString = String()
    var timer = Timer()
    var intCounter = Int()
    var currontLocationBool = Bool()
    var no_show_Driver = Bool()
    var navigationShow: Bool = false
    @IBOutlet weak var navigationBtn: UIButton!
    var mapBtn = false
    var PriceModelId = Int()
    var PFCIId = Int()
    var LocationId = Int()
    var getDriverTime = String()
    var countdownTimer: Timer!
    var waitingTime = Int()
    var waitingTimeEnable:Bool = false
    var totalwaitingTime = Int()
    var startTimerAgain = Bool()
    var timerCount = 0
    var TSParkingCharges = Int()
    var DriverParkingCharges = Int()
    var destinationLat = Double()
    var destinationLong = Double()
    var amountAfterCalculate = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "FinalAmountPopUp") {
            self.showPopCheckIsGoingOn()
        }
        
        self.GeoCoddingMeth()
        self.startTimerAgain = false
        self.navigationBtn.isHidden = true
        self.tripCompletBtn.isHidden = true
        currontLocationBool = true
        self.navigationController?.isNavigationBarHidden = false
        self.popUpViewBg.isHidden = true
        self.riderNameLib.text! = self.riderName
        self.payemtType = "2"

          self.dropLocationLib.text! = dropLocation
        //self.getAddress(address: self.dropLocation)
         self.topView.viewWithShadow()
        self.curentLocation()
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
          
            self.currontLocationBool = true
            self.mapview.clear()
            self.curentLocation()
            
        }

        if "\(self.PriceModelId)" == "" {
            self.PriceModelId = Int(UserDefaults.standard.string(forKey: "PriceModelId")!)!
        }
        
        if "\(self.PFCIId)" == "" {
            self.PFCIId = Int(UserDefaults.standard.string(forKey: "PFCIId")!)!
        }
        if "\(self.LocationId)" == "" {
            self.LocationId = Int(UserDefaults.standard.string(forKey: "LocationId")!)!
        }
         self.getWaitingInfoDetail(PriceModelId: "\(self.PriceModelId)", PFCIId: "\(self.PFCIId)", LocationId: "\(self.LocationId)")

    }
    
     func showPopCheckIsGoingOn() {

         self.popUpViewBg.isHidden = false
         self.cashBtn.isSelected = true
         self.popUpView2.dropShadow()
         self.submitBtn.ButtonWithShadow()
         self.amountTxt.setLeftPaddingPoints(10)
         self.amountTxt.text = UserDefaults.standard.string(forKey: "amountAfterCalculate")!
         self.amountTxt.isUserInteractionEnabled = false
             
    }
    
    
    func startTimer(_ newWaitingTime : Int) {
        self.waitingTime = newWaitingTime
        // self.waitingTime = 60
        self.totalwaitingTime = newWaitingTime
        //self.totalwaitingTime = 60
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }

    @objc func updateTime() {
              navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(timeFormatted(waitingTime))", style: .plain, target: self, action: nil)
                                  navigationItem.rightBarButtonItem?.tintColor = .white

        if waitingTime != 0 {
            waitingTime -= 1
            let minutesForNotification: Int = (waitingTime / 60) % 60
            if minutesForNotification < 10  {
                
                if waitingTimeEnable != true {
                    
                    let totalwaiting = totalwaitingTime - waitingTime
                    let totalwaitingNotification: Int = (totalwaiting / 60) % 60
                    var newdatamint = Int()
                    var duration = String()
                    if totalwaitingNotification == 0 {
                        duration = "secs"
                        newdatamint = totalwaiting
                    }else{
                        duration = "mins"
                        newdatamint = totalwaitingNotification
                    }
                    self.ByDriverNotification_API(FileBookingId: UserDetail.shared.getfileBookingId(), message: "\(UserDetail.shared.getUserFirstName()) is waiting for pessenger at \(self.pickUpaddress) from last \(newdatamint) \(duration)", driverId: UserDetail.shared.getUserDriverId())
                }
            }
          
        } else {
            
            endTimer()
        }
    }
    
    func endTimer() {
      
        if startTimerAgain == true {
            self.navigationItem .setRightBarButton(nil, animated: true)
            self.waitingTimeEnable = true
            
            if (UserDefaults.standard.bool(forKey: ckOnBoard)) == false {
                countdownTimer.invalidate()
            }
              
        }else{
            countdownTimer.invalidate()
            self.timerCount += 1
            self.startTimer(Int(self.getDriverTime)! * 60)
            self.waitingTimeEnable = false
        }
        
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           let minutes: Int = (totalSeconds / 60) % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }

    @IBAction func passengerOnBoradBtnaction(_ sender: UIButton) {


       UserDefaults.standard.set(true, forKey: ckOnBoard)
        self.navigationBtn.isHidden = false
        DispatchQueue.main.async(execute: {
            self.curentLocation()
        })
        
        if Connectivity.isConnectedToInternet {
             
            if self.VehicleBookingId == "" {
               self.VehicleBookingId =  UserDefaults.standard.string(forKey: "VehicleBooking_Id")!
            }

           self.DRIVER_CONFIRM_PICK_UP(VehicleBooking_Id: self.VehicleBookingId, DriverId: UserDetail.shared.getUserDriverId(), BoardLatitude: self.lati, BoardLongitude: self.longi, BoardLocation: self.addressString)
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
     
    }
    
    @IBAction func passengerNoTshow(_ sender: UIButton) {
        
        self.no_show_Driver = true
        DispatchQueue.main.async(execute: {
            self.curentLocation()
        })

        forLocationAddress ()
    }
    
    func initialMethod() {
        
         self.topView.viewWithShadow()
         self.currontLocationBool = false
        let lat =  self.dropLati
        let long = self.dropLong
        let location = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        self.cameraMoveToLocation(toLocation: location)
        self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
        self.fetchMapData(lati, toLog: longi, fromLat: dropLati, fromLong: dropLong)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.dropLati = locValue.latitude
        self.dropLong = locValue.longitude
         debugPrint("\(self.dropLati),\(self.dropLong)")
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            var marker = GMSMarker()
            mapview.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 18.0)
            if currontLocationBool == false {
            marker = GMSMarker(position: toLocation!)
            marker.icon = UIImage.init(named: "placeholder-2")
            marker.map = mapview
            }
        }
    }

    @IBAction func navigationOnMapBtnAction(_ sender: UIButton) {
        self.navigationShow = true
        self.openGoogleDirectionMap("\(self.destinationLat)", "\(self.destinationLong)")
    }

    @IBAction func tripCompletBtnAction(_ sender: UIButton) {
        
           self.amountTxt.isUserInteractionEnabled = false
            UserDefaults.standard.removeObject(forKey: ckStartTrip)
            UserDefaults.standard.removeObject(forKey: ckOnSiteTrip)
            UserDefaults.standard.removeObject(forKey: ckOnBoard)
            forLocationAddress ()

    }

    func openGoogleDirectionMap(_ destinationLat: String, _ destinationLng: String) {

        let LocationManager = CLLocationManager()
        if let myLat = LocationManager.location?.coordinate.latitude, let myLng = LocationManager.location?.coordinate.longitude {
            if let tempURL = URL(string: "comgooglemaps://?saddr=&daddr=\(destinationLat),\(destinationLng)&directionsmode=driving") {
                UIApplication.shared.open(tempURL, options: [:], completionHandler: { (isSuccess) in
                    if !isSuccess {
                        if UIApplication.shared.canOpenURL(URL(string: "https://www.google.co.th/maps/dir///")!) {
                            UIApplication.shared.open(URL(string: "https://www.google.co.th/maps/dir/\(myLat),\(myLng)/\(destinationLat),\(destinationLng)/")!, options: [:], completionHandler: nil)
                        } else {
                             print("Can't open URL.")
                        }
                    }
                })
            } else {
                print("Can't open GoogleMap Application.")
            }
        } else {
            print("Prease allow permission.")
        }
    }

    @IBAction func cashBtnAction(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        }
        else
        {
            sender.isSelected = true
            self.cardBtn.isSelected = false
            self.payemtType = "2"
        }
    }
    
    @IBAction func withCardBtnAction(_ sender: UIButton) {

        if sender.isSelected == true {
            sender.isSelected = false
            
        }else{
            sender.isSelected = true
            self.cashBtn.isSelected = false
             self.payemtType = "3"
        }
    }
    @IBAction func sunmitCashOrCardBtnAction(_ sender: UIButton) {
        
        if Connectivity.isConnectedToInternet {
            self.submitCashOrCard_Driver(VehicleBooking_Id: self.VehicleBookingId, ReceivedAmount: self.amountTxt.text!, PaymentTypeId: payemtType, FileBookingId: UserDetail.shared.getfileBookingId())
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }

    }
}
