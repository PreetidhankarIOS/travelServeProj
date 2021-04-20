//
//  menuViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SDWebImage
import CoreLocation


enum menu: Int{
    
    case homePage = 0
    case UpcomingRequest
    case JobQueue
    case RideCompleted
    case DeniedDuty
    case VehicleInfromation
    case chat
    case PaymentHistory
    case jobPool
    case driverStatment
    case Profile
    case Support
}


protocol MenuProtocol: class {
    
    func changeOndidSelectRowAt(_ menu: menu)
}

//#595858
class menuViewController: UIViewController,MenuProtocol,SlideMenuControllerDelegate,CLLocationManagerDelegate  {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var priviuscell: Int = 0
    var strImageUrl = String()
    @IBOutlet weak var userProfileImage: UIButton!
    var dataArray: [String] = []
    var itamImageArray: [String] = ["home","hourglass","analytics","checkmark","forbidden","front-bus","chat","credit-card","interview","statment","user-2","support","logout"]
    var dataCounttForCount : Array<AnyObject> = []
     var dataCounttForJobQue : Array<AnyObject> = []
     var dataCountForJobPool : Array<Dictionary<String, AnyObject>> = []
    var locationManager = CLLocationManager()
    var backgroundTask = UIBackgroundTaskIdentifier.invalid
    @IBOutlet weak var mainTableView: UITableView!
    
    var HomeVc: UIViewController!
    var UpcomingRequestVC: UIViewController!
    var JobQueueVC: UIViewController!
    var RideCompletedVC: UIViewController!
    var DeniedDutyVC: UIViewController!
    var VehicleInfromationVC: UIViewController!
    var PaymentHistoryVC: UIViewController!
    var ProfileVC: UIViewController!
    var SupportVC: UIViewController!
    var chatVc: UIViewController!
    var jobPoolVC: UIViewController!
    var driverStatmentVC: UIViewController!
    var tapGest:UITapGestureRecognizer!
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation?
    var lati = String()
    var longi = String()
    var addressString = String()

    //var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    @IBOutlet weak var deriverNameLib: UILabel!
    var tapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

         NotificationCenter.default.addObserver(self, selector: #selector(self.newBookingNotificationMethod(notification:)), name: Notification.Name("logoutNotification"), object: nil)
        self.curentLocation()
       

        
    }
    


    override func viewDidLayoutSubviews() {
        // Enable scrolling based on content height
        mainTableView.isScrollEnabled = mainTableView.contentSize.height > mainTableView.frame.size.height
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.height/2
        self.userProfileImage.layer.masksToBounds = true
        let image = UserDetail.shared.getUserImage()
        self.userProfileImage.sd_setImage(with: URL(string:image), for: .normal)
        self.deriverNameLib.text = UserDetail.shared.getUserFirstName()

        if Connectivity.isConnectedToInternet
        {
            self.upcoming_Rquest_listPage_Menu(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())

        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }

        if Connectivity.isConnectedToInternet
        {
            self.jobPool_informnation(DriverId: UserDetail.shared.getUserDriverId())
            
        }else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
        
      self.dataArray = ["Home","Upcoming Request (\(UserDetail.shared.getUpcomingCount()))","Job Queue (\(UserDetail.shared.getJobQueCount()))","Jobs Completed","Denied Duty","Vehicle Infromation","Chat","Payment History","Job Pool (\(UserDetail.shared.getPoolJobCount()))","Driver Statement","Profile","Support","Logout"]

        super.viewWillAppear(animated)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyboard.instantiateViewController(withIdentifier: "homeViewController") as! homeViewController
        self.HomeVc = UINavigationController(rootViewController: home)
        let UpcomingRequest = storyboard.instantiateViewController(withIdentifier: "upcomingRequestViewController") as! upcomingRequestViewController
        self.UpcomingRequestVC = UINavigationController(rootViewController: UpcomingRequest)
        let JobQueueVC = storyboard.instantiateViewController(withIdentifier: "JobQueueViewController") as! JobQueueViewController
        self.JobQueueVC = UINavigationController(rootViewController: JobQueueVC)
        let RideCompletedVC = storyboard.instantiateViewController(withIdentifier: "RideCompletedViewController") as! RideCompletedViewController
        self.RideCompletedVC = UINavigationController(rootViewController: RideCompletedVC)
        let DeniedDutyVC = storyboard.instantiateViewController(withIdentifier: "DeniedDutyViewController") as! DeniedDutyViewController
        self.DeniedDutyVC = UINavigationController(rootViewController: DeniedDutyVC)
        let VehicleInfromationVC = storyboard.instantiateViewController(withIdentifier: "VehicleInfromationViewController") as! VehicleInfromationViewController
        self.VehicleInfromationVC = UINavigationController(rootViewController: VehicleInfromationVC)
        let PaymentHistory = storyboard.instantiateViewController(withIdentifier: "PaymentHistoryViewController") as! PaymentHistoryViewController
        self.PaymentHistoryVC = UINavigationController(rootViewController: PaymentHistory)
        let Profile = storyboard.instantiateViewController(withIdentifier: "profileViewController") as! profileViewController
        self.ProfileVC = UINavigationController(rootViewController: Profile)
        let SupportVC = storyboard.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
        self.SupportVC = UINavigationController(rootViewController: SupportVC)
        let chat = storyboard.instantiateViewController(withIdentifier: "chatViewController") as! chatViewController
        self.chatVc = UINavigationController(rootViewController: chat)
        
        let Jobpool = storyboard.instantiateViewController(withIdentifier: "poolViewController") as! poolViewController
        self.jobPoolVC = UINavigationController(rootViewController: Jobpool)
        
        let driverStatment = storyboard.instantiateViewController(withIdentifier: "driverStatmentViewController") as! driverStatmentViewController
        self.driverStatmentVC = UINavigationController(rootViewController: driverStatment)
        
        mainTableView.separatorStyle = .none
         DispatchQueue.main.async { self.mainTableView.reloadData() }
    }
    
    
    func changeOndidSelectRowAt(_ menu: menu) {
        
        switch menu {
            
        case .homePage:
            self.slideMenuController()?.changeMainViewController(self.HomeVc, close: true)
        case .UpcomingRequest:
            self.slideMenuController()?.changeMainViewController(self.UpcomingRequestVC, close: true)
        case .JobQueue:
            self.slideMenuController()?.changeMainViewController(self.JobQueueVC, close: true)
        case .RideCompleted:
            self.slideMenuController()?.changeMainViewController(self.RideCompletedVC, close: true)
        case .DeniedDuty:
            self.slideMenuController()?.changeMainViewController(self.DeniedDutyVC, close: true)
        case .VehicleInfromation:
            self.slideMenuController()?.changeMainViewController(self.VehicleInfromationVC, close: true)
        case .chat:
            self.slideMenuController()?.changeMainViewController(self.chatVc, close: true)
        case .PaymentHistory:
            self.slideMenuController()?.changeMainViewController(self.PaymentHistoryVC, close: true)
        case .jobPool:
            self.slideMenuController()?.changeMainViewController(self.jobPoolVC, close: true)
        case .driverStatment:
            self.slideMenuController()?.changeMainViewController(self.driverStatmentVC, close: true)
        case .Profile:
            self.slideMenuController()?.changeMainViewController(self.ProfileVC, close: true)
        case .Support:
            self.slideMenuController()?.changeMainViewController(self.SupportVC, close: true)
        }

    }

    @IBAction func activeDriverBtnAction(_ sender: UISwitch) {

        if sender.isOn {
            
            self.ACTIVE_DRIVER_API(DriverId: UserDetail.shared.getUserDriverId(), ALocation: self.addressString, ALongitude: longi, ALatitude: lati)
        } else {
           self.IN_ACTIVE_DRIVER_API(DriverId: UserDetail.shared.getUserDriverId(), ALocation: self.addressString, ALongitude: longi, ALatitude: lati)
        }
    }
}

extension menuViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = mainTableView.dequeueReusableCell(withIdentifier: "morecell", for: indexPath) as! moreTableViewCell
        cell1.titleNameLib.text = dataArray[indexPath.row]
        cell1.imageCell.image = UIImage(named: itamImageArray[indexPath.row])
        return cell1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        priviuscell = indexPath.row
        if let menu = menu(rawValue: indexPath.row) {
            self.changeOndidSelectRowAt(menu)
        }

        if indexPath.row == 12{
        
            locationManager.pausesLocationUpdatesAutomatically = true
            UserDefaults.standard.set(false, forKey: logoutBackgroundNotification)
            DispatchQueue.main.async { self.curentLocation() }
                forLogOut()
            
        }

    }
   
   
    @objc func newBookingNotificationMethod(notification: Notification) {
        

        if self.lati == "" || self.longi == "" {
            
            if Connectivity.isConnectedToInternet
            {
                self.LogOut_API(ELatitude: UserDetail.shared.getUserLat(), DriverId: UserDetail.shared.getUserDriverId(), ELocation: self.addressString, ELongitude: UserDetail.shared.getUserLong())
            }
            else{
                PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
            }
            
          }else{
        
        if Connectivity.isConnectedToInternet
        {
            self.LogOut_API(ELatitude: self.lati, DriverId: UserDetail.shared.getUserDriverId(), ELocation: self.addressString, ELongitude: self.longi)
        }
        else{
            PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
        }
    }
}

    func forLogOut(){

        PDAlert.shared.showAlerForActionWithNo(title: "Logout!", msg: "Are You Sure to Logout!", yes: "YES", no: "NO", onVC: self){

            if Connectivity.isConnectedToInternet
            {
                self.LogOut_API(ELatitude: self.lati, DriverId: UserDetail.shared.getUserDriverId(), ELocation: self.addressString, ELongitude: self.longi)
                
            }else{
                PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
            }
        }
    }
    
    
    
//    func registerBackgroundTask() {
//      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
//        self?.endBackgroundTask()
//      }
//      assert(backgroundTask != .invalid)
//    }
      
    func endBackgroundTask() {
      print("Background task ended.")
      UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
    
    
    
}

class moreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleNameLib: UILabel!
    
}
