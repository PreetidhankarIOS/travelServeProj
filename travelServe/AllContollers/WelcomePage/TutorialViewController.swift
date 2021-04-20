//
//  TutorialViewController.swift
//  AapkaChemist
//
//  Created by Mac on 05/02/19.
//  Copyright © 2019 Idigitie. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!

    @IBOutlet weak var headerTitleLib: UILabel!
    var timer = Timer()
    var pageIndex : Int = 0
    var arrPageImage = Array<Any>()
    var arrPageText = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        arrPageImage = ["1","2","3","4"]
        pageController.numberOfPages = arrPageImage.count
       // swipe gesture
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        //set timer
        self.startTimer()
    }

    func startTimer() {
        self.timer = Timer .scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(loadNextImage), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if (self.timer.isValid) {
            self.timer.invalidate();
        }
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.stopTimer()
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                
                self.pageIndex = (pageIndex != 0) ? self.pageIndex - 1 : arrPageImage.count - 1
                self.pageController.currentPage = self.pageIndex
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
                self.tutorialImageView.layer.add(transition, forKey:"SwitchToView")
                
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                
                self.pageIndex = (pageIndex != self.arrPageImage.count-1) ? self.pageIndex + 1 : 0
                self.pageController.currentPage = self.pageIndex
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
                self.tutorialImageView.layer.add(transition, forKey:"SwitchToView")
                
//                if UserDetail.shared.getToken_Id() == "" {
//
//                    //PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Unable to process this request, Please Try Again later!", yes: "OK", onVC: self)
//
//                    PDAlert.shared.showAlertWith("Alert!", message: "Unable to process this request, Please Try Again later!", onVC: self)
//                    return
//
//                }else{
                
                    if (pageIndex == self.arrPageImage.count-3) {
                        let View = self.storyboard?.instantiateViewController(withIdentifier:"loginViewController") as! loginViewController
                        self.navigationController?.pushViewController(View, animated: true)
                    }
                //}
                
                
                
            default:
                break
            }
            
            self.tutorialImageView.image = UIImage.init(named:arrPageImage[pageIndex] as! String)
        }
        self.startTimer()
    }
    
    @objc func loadNextImage() {
        if (pageIndex != self.arrPageImage.count-1) {
            self.pageIndex = self.pageIndex + 1
            self.pageController.currentPage = self.pageIndex
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
            self.tutorialImageView.layer.add(transition, forKey:"SwitchToView")
            self.tutorialImageView.image = UIImage.init(named:arrPageImage[pageIndex] as! String)

        }
    }
    
    @IBAction func skipButtonAction(_ sender: UIButton) {
        
//        if UserDetail.shared.getToken_Id() == "" {
//            
//            //PDAlert.shared.showAlerForActionWithYes(title: "Alert!", msg: "Unable to process this request, Please Try Again later!", yes: "OK", onVC: self)
//            
//            PDAlert.shared.showAlertWith("Alert!", message: "Unable to process this request, Please Try Again later!", onVC: self)
//            return
//                
//        }
//        
        let View = self.storyboard?.instantiateViewController(withIdentifier:"loginViewController") as! loginViewController
        self.navigationController?.pushViewController(View, animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if pageIndex == self.arrPageImage.count - 1 {
            let View = self.storyboard?.instantiateViewController(withIdentifier:"loginViewController") as! loginViewController
            self.navigationController?.pushViewController(View, animated: true)
        }
    }

}
