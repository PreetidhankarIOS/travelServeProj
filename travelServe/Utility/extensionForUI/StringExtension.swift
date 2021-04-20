//
//  StringExtension.swift
//  Car Inspection
//
//  Created by Preeti dhankar on 21/12/16.
//  Copyright © 2016 Preeti dhankar. All rights reserved.
//

import UIKit
import CoreLocation

extension String
{
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var boolValue: Bool {
        return Bool((self as NSString).boolValue)
    }
}


///TextFile Border  Super
extension UITextField {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}

//Button Border  Super
extension UIButton {
    func addButtonBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}



///Pedding Of Text file
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



extension String {
    
    func getFormateDate(fromFormate:String, toFormate:String) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = fromFormate
        if let date = dateFormatter.date(from: self) {
            let toFormatter = DateFormatter.init()
            toFormatter.dateFormat = toFormate
            if let sDate = toFormatter.string(from: date) as? String {
                return sDate
            }
        }
        return ""
    }
    func getDateFromString(formateString:String) -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = formateString
        let locale = NSTimeZone.init(abbreviation: "BST")
        NSTimeZone.default = locale! as TimeZone
        dateFormatter.timeZone = locale! as TimeZone
        if let dateS = dateFormatter.date(from: self) {
            return dateS
        }
        return Date()

    }
          func toDate(withFormat format: String = "dd/MM/yyyy") -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            guard let date = dateFormatter.date(from: self) else {
              preconditionFailure("Take a look to your format")
            }
            return date
          }
    
    
    func getDate(formateStringNew:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
    
    func stringToDate(_ str: String)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat="dd/MM/yyyy"
        return formatter.date(from: str)!
    }
    
   //yyyy-MM-dd hh:mm:ss Z
    }
    
    
//    func getDate(formateStr:String) -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = formateStr
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.locale = Locale.current
//        return dateFormatter.date(from: "2015-04-01T11:42:00") // replace Date String
//    }
    
    
    

//"14/10/2019"



        
    






extension UITextField {
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "K2D-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "K2D-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "K2D-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "K2D-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }
}


extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


extension UIView {
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
 }
}


extension UIButton {
    
    func ButtonWithShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
}

extension UIView {
    
    func viewWithShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
    
}



extension Double {
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let roundValue = (self * divisor).rounded()
        return roundValue / divisor
    }
    
    func stringValue() -> String {
        let string:String = String(format:"%.3f", self)
        return string
    }
    
    func twoDigitStringValue() -> String {
        let string:String = String(format:"%.2f", self)
        return string
    }
    
    func oneDigitStringValue() -> String {
        let string:String = String(format:"%.1f", self)
        return string
   }

}
