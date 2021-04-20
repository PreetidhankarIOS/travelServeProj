//
//  AppDelegate.swift
//  travelServe
//
//  Created by Developer on 25/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import CoreData
import SlideMenuControllerSwift
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import Firebase
import CoreLocation
import FirebaseMessaging


///9017615909
//tableView.animateViews(animations: [AnimationType.from(direction: .bottom, offset: 30.0)])

let kGCMMessageIDKey = "gcm.message_id"
let GoogleApiKey = "AIzaSyCjHR5_kH5bb56oR03ZZ74vawu8bhr_yNM" //ofc
//let GoogleApiKey = "AIzaSyCV614nsASuF55bciGgV1Dke6cYxTeqfIQ" //my
//var locManager = CLLocationManager()
var currentLocation: CLLocation?

//AIzaSyCjHR5_kH5bb56oR03ZZ74vawu8bhr_yNM
// old

//com.travelServes
var lati = String()
var longi = String()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
    var backgroundTask = UIBackgroundTaskIdentifier.invalid
    var window: UIWindow?
    var locationManager = CLLocationManager()
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    var bgtimer = Timer()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var current_time = NSDate().timeIntervalSince1970
   // var timer = Timer()
    var timer: Timer?
    var f = 0
    var significatLocationManager : CLLocationManager?
    
    
class func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
}
    var  homeViewController : homeViewController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        Thread.sleep(forTimeInterval: 5.0)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        
          IQKeyboardManager.shared.enable = true
          GMSServices.provideAPIKey(GoogleApiKey)
          GMSPlacesClient.provideAPIKey(GoogleApiKey)
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 203.0/255.0, green: 114.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor(red: 203.0/255.0, green: 114.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        
        locationManager.delegate = self
       // significatLocationManager!.delegate = self

        
        
        Messaging.messaging().delegate = self
        
        requestNotificationAuthorization(application: application)
        application.registerForRemoteNotifications()
        
        
        if lati == "" || longi == "" {
            curentLocationGet()
        }
        
        UserDefaults.standard.set(false, forKey: upadteForErrorJson)

        if (UserDefaults.standard.bool(forKey: KeyMain)) {
            self.loadMenu()//User already login
        }else{
            self.createMenuView()//User not login*
        }

        return true
    }
    

    func createMenuView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "TutorialViewController")
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = nvc
    }
    
    func loadLoginView() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
        let navigationController = UINavigationController(rootViewController: rootViewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

    }
  
    
    public func loadMenu() {
         UserDefaults.standard.set(true, forKey: ckdataAfterLogout)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "homeViewController")
            as! homeViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.HomeVc = nvc

        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.rootViewController = slideMenuController
        
        
    }

    func curentLocationGet(){
     
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
            if let lat = currentLocation?.coordinate.latitude{
                lati = "\(lat)"
                debugPrint(lati)
                UserDetail.shared.setUserLat(lati)
            }
            if let lng = currentLocation?.coordinate.longitude{
                longi = "\(lng)"
                debugPrint(longi)
                UserDetail.shared.setUserLat(longi)
            }
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
         var locationManager = CLLocationManager()
        
        locationManager.allowsBackgroundLocationUpdates = true
       
        let app = UIApplication.shared
        
        backgroundTask = app.beginBackgroundTask(expirationHandler: {
            app.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        })

    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {

       //homeViewController!.update()
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {

        self.saveContext()
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "travelServe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
 
    
   
}


