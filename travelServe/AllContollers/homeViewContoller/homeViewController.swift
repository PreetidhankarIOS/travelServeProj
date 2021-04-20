//
//  homeViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces




class homeViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    
    @IBOutlet weak var addressViewBg: UIView!
    @IBOutlet weak var addressLib: UILabel!
    
    var dataCounttForCount : Array<AnyObject> = []
    var dataCounttForJobQue : Array<AnyObject> = []
    var dataCountForJobPool : Array<Dictionary<String, AnyObject>> = []
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    lazy var geocoder = CLGeocoder()
     var addressString = String()
     var addressStringNew = String()

    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
  
    //var timer: Timer?
  
    var initialcameraposition:GMSCameraPosition!
    
  
    var isDestinationLocation = Bool()
    var SlectedIndex = 0
    var isFirstTime = Bool()
    var startCordinates = CLLocationCoordinate2D()
    var destinationCordinates = CLLocationCoordinate2D()
    var errorMsg = ""
    var TexiListArr: Array<AnyObject>! = Array<AnyObject>()
    var Dict: NSDictionary! = [:]

 
    var isSearchLocation = Bool()
    var startLocationStr = ""
    var destinationLocationStr = ""
    var isUpdateLocation = Bool()
    
    let manager = CLLocationManager()
   
  var compactAddress =  String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewDidLordMethord()
         UserDefaults.standard.set(true, forKey: IsLodingViewInScondeAPI)
        UserDefaults.standard.set(true, forKey: ckdataAfterLogout)
     
        self.addressViewBg.viewWithShadow()

        

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Welcome to \(UserDetail.shared.getUserFirstName())"
        
        UIApplication.shared.isIdleTimerDisabled = true
        
       
        
        
}

    override func viewWillAppear(_ animated: Bool) {
        

        
        if (UserDefaults.standard.bool(forKey: startJobOrNot)) == true{
            
           let psengerName =  UserDefaults.standard.string(forKey: "psengerName")
            print(psengerName!)
        }
        
        if   AppDelegate.sharedInstance().timer == nil {
        AppDelegate.sharedInstance().timer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
        
        if Connectivity.isConnectedToInternet
        {
            self.signInWithUserIdAndPassword(UserDetail.shared.getUserName(), UserDetail.shared.getUserPassword())
        }else{
            
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
          
        }
        
        
        self.forAllCheckWhereWasDeriver()
        //NotificationCenter.default.addObserver(self, selector: #selector(self.update), name: UIApplication.didBecomeActiveNotification, object: nil)
             

    }
 
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIApplication.shared.isIdleTimerDisabled = false
        self.jobPool_informnation(DriverId: UserDetail.shared.getUserDriverId())
    }



    @IBAction func startNewJobBtnAction(_ sender: UIButton) {
        
        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBord.instantiateViewController(withIdentifier: "acknowledgeRequestViewController") as! acknowledgeRequestViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    @IBAction func menuBtnAction(_ sender: Any) {
      
        DispatchQueue.main.async {
            
        if Connectivity.isConnectedToInternet
        {
            self.upcoming_Rquest_listPage_Menu(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
            }
        }
}

    
    func viewDidLordMethord() {
        
        self.navigationController?.isNavigationBarHidden = false
        initializeTheLocationManager()
        self.mapView.isMyLocationEnabled = true
        mapView.isBuildingsEnabled = false
        mapView.isTrafficEnabled = false
        mapView.delegate = self

    }
    
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
       // self.locationManager.distanceFilter = 1
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {


            isUpdateLocation = true
            let location = locationManager.location?.coordinate
            cameraMoveToLocation(toLocation: location)
            mapView.settings.myLocationButton = true
        

    }
    

    @objc func update() {
        if Connectivity.isConnectedToInternet {
            debugPrint("preeti")
            
        self.UPDATE_LOCATION_IN_SECOND_API(SLatitude: UserDetail.shared.getUserLat(), DriverId: UserDetail.shared.getUserDriverId(), SLocation: self.addressStringNew, SLongitude: UserDetail.shared.getUserLong())
             print("Data print With Timer")
        }else{
          PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }

    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
            self.mapView.clear()
            let marker = GMSMarker()
            let markerImage = UIImage(named: "car")
            let markerView = UIImageView(image: markerImage)
            marker.position = CLLocationCoordinate2D(latitude: toLocation!.latitude, longitude: toLocation!.longitude)
            
            UserDetail.shared.setUserLat("\(toLocation!.latitude)")
            UserDetail.shared.setUserLong("\(toLocation!.longitude)")
             marker.iconView = markerView
            marker.map = mapView

            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate(toLocation!) { response, error in
                guard let address = response?.firstResult(), let lines = address.lines else {
                    return
                }
                //debugPrint(address)
                self.addressLib.text = lines.joined(separator: "\n")
                self.addressStringNew = self.addressLib.text!
                UserDetail.shared.setUserCurrentLocationAdress(self.addressStringNew)

            }
             
            if Connectivity.isConnectedToInternet
            {
    
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                
                self.forLocationAddress(UserDetail.shared.getUserLat(), longi: UserDetail.shared.getUserLong(), addressLocation: self.addressStringNew)
                
             }

            }else{
                
                PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)

            }
            
            
                 
            }
        }
    
}
