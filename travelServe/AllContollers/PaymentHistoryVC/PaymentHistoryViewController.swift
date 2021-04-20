//
//  PaymentHistoryViewController.swift
//  travelServe
//
//  Created by Developer on 26/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

class PaymentHistoryViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
     var dataCountTable : Array<AnyObject> = []
     var dataCountTable1 : Array<PaymentHistoryModal> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainTableView.separatorStyle = .none
        
        self.driver_PaymentHistory(DriverId: UserDetail.shared.getUserDriverId())
    }

    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
    }
}

extension PaymentHistoryViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCountTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentHistoryTVCell
        cell.selectionStyle = .none
        cell.bgView.dropShadow()
        
        let dict = dataCountTable[indexPath.row] as! PaymentHistoryModal
        cell.totalBookingLib.text = "\(dict.TotalBookings)"
        cell.amountLib.text = "£ \(dict.TotalAmount).00"
        let WeekStartDate  = dict.WeekStartDate.getFormateDate(fromFormate: "dd/MM/yyyy", toFormate: "dd MMM yyyy")
        let WeekEndDate  = dict.WeekEndDate.getFormateDate(fromFormate: "dd/MM/yyyy", toFormate: "dd MMM yyyy")
        cell.dateLib.text = "\(WeekStartDate) - \(WeekEndDate)"
        

        //23th May - 29th May
        
        if indexPath.row == 0 {
            cell.weekTypeLib.text = "Last Week"
        }
        else if indexPath.row == 1  {
        cell.weekTypeLib.text = "2 Week ago"
        }
        else if indexPath.row == 2 {
          cell.weekTypeLib.text = "3 Week ago"
        }else if indexPath.row == 3 {
            cell.weekTypeLib.text = "4 Week ago"
        }else{
           cell.weekTypeLib.text = "last month week ago"
            
        }

        return cell
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = self.dataCountTable[indexPath.row] as! PaymentHistoryModal
        
         let formatter = DateFormatter()
         formatter.dateFormat = "dd/MM/yyyy"
         let WeekStartDate = formatter.date(from: dict.WeekStartDate)
         let WeekEndDate = formatter.date(from: dict.WeekEndDate)

    
        var newArryForAppend = Array<AnyObject>()
        for alldate in dataCountTable1 {
                   
                   let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy"
                    let PickupDate = formatter.date(from: alldate.PickupDate)
            
          if WeekStartDate?.compare(PickupDate!) == .orderedSame || ((WeekStartDate?.compare(PickupDate!) == .orderedAscending) &&  WeekEndDate?.compare(PickupDate!) == .orderedDescending )  {
                    newArryForAppend.append(alldate)
            }

        }

        let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let nextViewController = storyBord.instantiateViewController(withIdentifier: "viewPaymentHistoryViewController") as! viewPaymentHistoryViewController
        nextViewController.newArryDataList =  newArryForAppend as! [PaymentHistoryModal]
         self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }

}


class PaymentHistoryTVCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLib: UILabel!
    @IBOutlet weak var totalBookingLib: UILabel!
    @IBOutlet weak var weekTypeLib: UILabel!
    @IBOutlet weak var amountLib: UILabel!
    @IBOutlet weak var viewReportBtn: UIButton!
    
}




