//
//  UIView+Extensions.swift
//  MattarBinLahej
//
//  Created by Haider Abbas on 12/11/18.
//  Copyright © 2018 Haider Abbas. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var corner: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            
            self.layer.borderWidth = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor.clear
        }
        set {
            
            self.layer.borderColor = newValue?.cgColor
            self.layer.borderWidth = 1.0
        }
    }

    func addWithBorderConstraints(view child: UIView, left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat, at position: Int? = nil) {
        if let position = position {
            insertSubview(child, at: position)
        } else {
            addSubview(child)
        }
        child.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: child,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: top))
        self.addConstraint(NSLayoutConstraint(item: child,
                                              attribute: .left,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .left,
                                              multiplier: 1,
                                              constant: left))
        
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .right,
                                              relatedBy: .equal,
                                              toItem: child,
                                              attribute: .right,
                                              multiplier: 1,
                                              constant: right))
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: child,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: bottom))
    }
    
    func addMaximized(view childView: UIView, at position: Int? = nil) {
        
        if let position = position {
            insertSubview(childView, at: position)
        } else {
            addSubview(childView)
        }
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        
        layoutAttributes.forEach { attribute in
            addConstraint(NSLayoutConstraint(item: childView,
                                             attribute: attribute,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: attribute,
                                             multiplier: 1,
                                             constant: 0.0))
        }
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        backgroundColor = color
    }
    
}
