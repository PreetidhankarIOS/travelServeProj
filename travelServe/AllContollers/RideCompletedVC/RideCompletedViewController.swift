//
//  RideCompletedViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit
import Foundation


class RideCompletedViewController: UIViewController,WWCalendarTimeSelectorProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var rideCompletData:  Array<rideCompleteModalData> = []
    
    @IBOutlet weak var isFavourite: UIBarButtonItem!
    var dataCountt : Array<rideCompleteModalData> = []
    var filteredData : Array<rideCompleteModalData> = []
    var isFiletering = false
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    var saveChosenImage = UIImage()
    var convertedImage64 = String()
    var VehicleBookingId = String()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()


        
        self.mainTableView.separatorStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(self.pastBookingNotificationMethod(notification:)), name: Notification.Name("pastBookingNotification"), object: nil)
        
        if #available(iOS 13.0, *) {
            self.GetPastMobDriver_TransferBooking_api(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())
        } else {
            // Fallback on earlier versions
        }
        self.filteredData = dataCountt
        
    }


    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }

    @objc func pastBookingNotificationMethod(notification: Notification) {
        
    }
    
    @IBAction func dateBTnActionFilter(_ sender: UIBarButtonItem) {
 //yourButton.currentImage == UIImage(named: "Image_Assigned")

        if sender.backgroundImage(for: .normal, barMetrics: .default) == UIImage(named: "filterl") {

              forSlectDate()
            
          }else{
              
              isFavourite.setBackgroundImage(UIImage(named: "filterl"), for: .normal, barMetrics: .default)
               isFiletering = false
               self.mainTableView.reloadData()
          }

    }
    
    
    func forSlectDate(){
        
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        present(selector, animated: true, completion: nil)
        
    }
    

    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        isFiletering = true
        let dateString = date.stringFromFormat("dd-MM-yyyy")
        let selectedDate = convertStringToDate(dateToConvert: dateString)
        print(selectedDate.day)
        print(selectedDate.month)
        print(selectedDate.year)
        filteredData.removeAll()
        for obj in dataCountt {
            let dateTobeCompared = convertStringToDate(dateToConvert: obj.JobDoneDate)
            print(dateTobeCompared.day)
            print(dateTobeCompared.month)
            print(dateTobeCompared.year)
            if dateTobeCompared == selectedDate {
                filteredData.append(obj)
            }
        }
        
        isFavourite.setBackgroundImage(UIImage(named: "close"), for: .normal, barMetrics: .default)
        
//        let buttonIcon = UIImage(named: "close")
//        isFavourite.setImage(UIImage.init(named: "name_of_image"), for: .selected)
        
        
//        let backImg: UIImage = UIImage(named: "close")!
//        isFavourite.setBackgroundImage(backImg, for: .normal, barMetrics: .default)
        
  
        
//        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(RideCompletedViewController.myLeftSideBarButtonItemTapped(_:)))
//        leftBarButton.image = buttonIcon

        
//        self.navigationItem.rightBarButtonItem = leftBarButton
//        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white

        mainTableView.reloadData()
        debugPrint(dateString)
        
    }
    
    @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        
               let buttonIcon = UIImage(named: "filterl")
               let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: nil)
               leftBarButton.image = buttonIcon
               self.navigationItem.rightBarButtonItem = leftBarButton
               self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
                isFiletering = false
               self.mainTableView.reloadData()
        
    }
    
//    @objc func myLeftSideBarButtonItemTappedd(_ sender:UIBarButtonItem!)
//    {
//
////        if #available(iOS 13.0, *) {
////            self.GetPastMobDriver_TransferBooking_api(AccessCode: UserDetail.shared.getAccessCodeId(), DriverId: UserDetail.shared.getUserDriverId(), Password: UserDetail.shared.getUserPassword(), UserName: UserDetail.shared.getUserName())
////        } else {
////            //       mFallback on earlier versions
////        }
////
//
//    }
    
    
    func convertStringToDate(dateToConvert:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: dateToConvert)
        print(date!)
        return date!
    }
}


extension RideCompletedViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiletering ? self.filteredData.count : self.dataCountt.count
        
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "RideCompleted", for: indexPath) as! RideCompletedTableViewCell
       
        let dict = self.dataCountt[indexPath.row]
        cell.fileBookingId.text = dict.FileBookingId
        
        if dict.message == "No Data Found"{
            
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
        cell.vhicalBookingIdCell = dict.VehicleBookingId
        cell.selectionStyle = .none
        cell.attachVoucherBtn.tag = indexPath.row + 660
        cell.attachVoucherBtn.addTarget(self, action: #selector(self.attachVoucherBtnAction(_:)), for: .touchUpInside)
        return cell
        
    }
    
    
    @objc func attachVoucherBtnAction (_ sender : UIButton){
        
         let index = sender.tag - 660
               let indexPath = IndexPath.init(item: index, section: 0)
               if let cell = mainTableView.cellForRow(at: indexPath) as? RideCompletedTableViewCell {
                self.VehicleBookingId = "\(cell.vhicalBookingIdCell)"
                
                
                  let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                  let cameraBtn: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default) { action -> Void in
                      self.selectImageFromCamera()
                  }
                  let photoBtn: UIAlertAction = UIAlertAction(title: "Choose Photo", style: .default) { action -> Void in
                      self.selectImageFromGallery()
                  }
                  let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                      //Just dismiss the action sheet
                  }
                  actionSheetController.addAction(cameraBtn)
                  actionSheetController.addAction(photoBtn)
                  actionSheetController.addAction(cancelAction)
                
                  
                  
                  if let presenter = actionSheetController.popoverPresentationController {
                      presenter.sourceView = sender as UIView
                      presenter.sourceRect = (sender as AnyObject).bounds
                  }
                  self.present(actionSheetController, animated: true, completion: nil)
                   
            }
    
      }
    
    func selectImageFromGallery() {
      
              if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
              let imag = UIImagePickerController()
              imag.delegate = self
              imag.sourceType = UIImagePickerController.SourceType.photoLibrary;
              imag.allowsEditing = false
              self.present(imag, animated: true, completion: nil)
         }
      }
      
      func selectImageFromCamera() {
      
              if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
              let imag = UIImagePickerController()
              imag.delegate = self
              imag.sourceType = UIImagePickerController.SourceType.camera
              
              imag.allowsEditing = false
              self.present(imag, animated: true, completion: nil)
          }
      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      self.saveChosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
      debugPrint(saveChosenImage)
      
      self.dismiss(animated: true) {
          self.convertedImage64 =  (self.saveChosenImage.jpegData(compressionQuality: 0.1)?.base64EncodedString())!
        
        if #available(iOS 13.0, *) {
            self.API_Calling_For_UploadAirlineBookingVaucher()
        } else {
            // Fallback on earlier versions
        }
        
      }
    }
 
}

class RideCompletedTableViewCell: UITableViewCell {
    
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
    @IBOutlet weak var driverPriceLib: UILabel!
    @IBOutlet weak var travelServePriceLib: UILabel!
    @IBOutlet weak var travelServeNameLib: UILabel!
    @IBOutlet weak var pickupTypeLib: UILabel!
    @IBOutlet weak var attachVoucherBtn: UIButton!
    var vhicalBookingIdCell = Int()
    
}

