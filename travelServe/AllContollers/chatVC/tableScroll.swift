//
//  tableScroll.swift
//  travelServe
//
//  Created by YATIN  KALRA on 15/10/19.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scrollToBottom_P(animation:Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection: self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: animation)
        }
    }
    func scrollToTop_P(animation:Bool) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animation)
        }
    }
    func scrollToLastCell_P(animated : Bool) {
         let lastSectionIndex = self.numberOfSections - 1 // last section
        if lastSectionIndex >= 0 {
            let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
            if lastRowIndex > 0 {
                self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
            }
            
        }
    }
}
