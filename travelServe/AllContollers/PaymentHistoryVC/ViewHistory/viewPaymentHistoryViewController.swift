//
//  viewPaymentHistoryViewController.swift
//  travelServe
//
//  Created by Developer on 06/11/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class viewPaymentHistoryViewController: UIViewController {

     @IBOutlet weak var mainTableView: UITableView!
     var newArryDataList = Array<PaymentHistoryModal>()
    override func viewDidLoad() {
        super.viewDidLoad()

       debugPrint(newArryDataList)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}


extension viewPaymentHistoryViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
            self.newArryDataList.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "ViewHistory", for: indexPath) as! ViewHistoryTableViewCell
       
        let dict = self.newArryDataList[indexPath.row]
        
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
            cell.driverPriceLib.text = "£ \(dict.DriverTotalPrice)"


        }else
        {

            cell.travelServePriceLib.isHidden = true
            cell.travelServeNameLib.isHidden = true
            cell.driverPriceLib.text = "£ \(dict.DriverTotalPrice)"
        }

        let create_date  = dict.BookingDate.getFormateDate(fromFormate: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormate: "dd MMM, yyyy")
        cell.confirmedDatelib.text = create_date
        cell.pickUpFromLib.text = dict.PickupLocationName
        cell.dropoffLib.text = dict.DropLocationName
        cell.pickUpTime.text = dict.PickUpTime
        cell.paxContectNumberLib.text = dict.ContactNo
        cell.paxNameLib.text = dict.LeadPaxName
        cell.paxInfomationLib.text = "\(dict.MaxPax)"
        cell.numbarBags.text = "\(dict.totalBag)"

        cell.remarkLib.text = dict.SpecialRequest
        cell.selectionStyle = .none
        cell.pickupTypeLib.text = dict.pickupType
        return cell
    }
    
    
    @objc func acknowldgeBtnAction (_ sender : UIButton){}
    @objc func cancelBookingBtnAction (_ sender : UIButton){}
    
}


class ViewHistoryTableViewCell: UITableViewCell {
    
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
    
}

