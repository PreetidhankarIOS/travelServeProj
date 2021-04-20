//
//  bookingChatViewController.swift
//  travelServe
//
//  Created by Developer on 17/10/2019.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class bookingChatViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var bookingBtn: UIButton!
    @IBOutlet weak var gernalBtn: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    var dataCountt : Array<rideCompleteModalData> = []
    var filteredData : Array<rideCompleteModalData> = []
    
      var isfiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Connectivity.isConnectedToInternet {
            
            self.chat_Booking_List(driiverId: UserDetail.shared.getUserDriverId())
       }else{
           PDAlert.shared.showAlertWith("Alert!", message: K_NoInternet, onVC: self)
       }
        searchTxt.delegate = self
       filteredData = dataCountt
    }
    
    @IBAction func gernalBookingBtnAction(_ sender: UIButton) {
        
        if sender.tag == 7 {
         self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    @IBAction func MenuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
}

extension bookingChatViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return isfiltered ? self.filteredData.count : self.dataCountt.count
        return self.filteredData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "bookingcell", for: indexPath) as! bookingTableViewCell
        
        cell.bgview.dropShadow()
        var dict: rideCompleteModalData?
         if filteredData.count == 0 {
            dict = self.dataCountt[indexPath.row]
            debugPrint(dict!)
         } else {
           dict = self.filteredData[indexPath.row]
             debugPrint(dict!)
         }

          if let dict = dict {
              cell.bookingIdLib.text = dict.FileBookingId
                 
                 if dict.message == "No Data Found"{
                     
                     let image: UIImage = UIImage(named: "ic_notfound")!
                     let imageView = UIImageView(image: image)
                     self.view.addSubview(imageView)
                     imageView.frame = CGRect(x: 0,y: 0,width: 200,height: 150)
                     imageView.center = self.view.center
                     cell.isHidden = true
                     
                 }

                 let create_date  = dict.BookingDate.getFormateDate(fromFormate: "dd-MM-yyyy", toFormate: "dd MMM, yyyy")
                 cell.dateLib.text = create_date
                 cell.pickUpLib.text = dict.PickupLocationName
                 cell.dropLib.text = dict.DropLocationName
                 cell.selectionStyle = .none

          }
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
        let dict = self.dataCountt[indexPath.row]
        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBord.instantiateViewController(withIdentifier: "chatViewOfBookingIdViewController") as! chatViewOfBookingIdViewController
        nextViewController.fileBookingId =  dict.FileBookingId
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
////////////////////////Searching Work Here////////////////////////////////////

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text,
                let textRange = Range(range, in: text)  {
                let searchText = text.replacingCharacters(in: textRange,
                                                           with: string)
                
            self.filteredData = searchText.isEmpty ? dataCountt : filteredData.filter { $0.FileBookingId.lowercased().starts(with: searchText.lowercased()) }
            self.mainTableView.reloadData()
           }
            return true
            
        }

    }



class bookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var bookingIdLib: UILabel!
    @IBOutlet weak var dateLib: UILabel!
    @IBOutlet weak var dropLib: UILabel!
    @IBOutlet weak var pickUpLib: UILabel!
    
}
