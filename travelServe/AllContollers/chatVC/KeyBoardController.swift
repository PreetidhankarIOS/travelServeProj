//
//  KeyBoardController.swift
//  ItreatCards
//
//  Created by Rahul kr on 26/11/17.
//  Copyright © 2017 Freelancer. All rights reserved.
//

import Foundation
import UIKit

protocol KeyBoardNotificationDelegate : class
{
    func didKeyBoardAppeared(keyboardHeight : CGFloat)
}

class KeyboardNotificationController: NSObject {
    
    //MARK: - Variables & Constants
    weak var keyboarddelegate : KeyBoardNotificationDelegate?
    
    
    //MARK: - SharedInstance
    static let sharedKC = KeyboardNotificationController()
    
    //MARK: - Public Methods
    
    func registerforKeyBoardNotification(delegate: UIViewController)
    {
        keyboarddelegate = delegate as? KeyBoardNotificationDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: - Keyboard Delegates
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        UIView.animate(withDuration: 0.5) {
            self.keyboarddelegate?.didKeyBoardAppeared(keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.keyboarddelegate?.didKeyBoardAppeared(keyboardHeight: 0)
        }
    }
}
