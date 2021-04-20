//
//  UserDetail.swift
//  holidayshare
//
//  Created by Preeti Dhankar on 01/04/18.
//  Copyright © 2018 Preeti Dhankar. All rights reserved.
//

import UIKit

class UserDetail: NSObject {
static let shared = UserDetail()
    private override init() { }
    
    func setAccessCodeId(_ sUserId:String) -> Void {
        
        UserDefaults.standard.set(sUserId, forKey: UserKeys.user_AccessCode_id.rawValue)
    }
    func getAccessCodeId() -> String {
        if let userId = UserDefaults.standard.value(forKey: UserKeys.user_AccessCode_id.rawValue) as? String
        {
            return userId
        }
        return ""
    }

    func setUserName(_ sUserId:String) -> Void {
        
        UserDefaults.standard.set(sUserId, forKey: UserKeys.userName.rawValue)
    }
    func getUserName() -> String {
        if let userId = UserDefaults.standard.value(forKey: UserKeys.userName.rawValue) as? String
        {
            return userId
        }
        return ""
    }
    func removeUserName() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.userName.rawValue)
        
    }
    
    
    
    func setfileBookingId(_ sUserId:String) -> Void {
        
        UserDefaults.standard.set(sUserId, forKey: UserKeys.fileBooking_Id.rawValue)
    }
    func getfileBookingId() -> String {
        if let userId = UserDefaults.standard.value(forKey: UserKeys.fileBooking_Id.rawValue) as? String
        {
            return userId
        }
        return ""
    }
    func removefileBookingId() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.fileBooking_Id.rawValue)
    }
    

    
    func setUserFirstName(_ sUserId:String) -> Void {
        
        UserDefaults.standard.set(sUserId, forKey: UserKeys.user_fullname.rawValue)
    }
    func getUserFirstName() -> String {
        if let userId = UserDefaults.standard.value(forKey: UserKeys.user_fullname.rawValue) as? String
        {
            return userId
        }
        return ""
    }
    func removeUserFirstName() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.user_fullname.rawValue)
        
    }
    

    
    func setUserPassword(_ sUserId:String) -> Void {
        
        UserDefaults.standard.set(sUserId, forKey: UserKeys.userPassword.rawValue)
    }
    func getUserPassword() -> String {
        if let userId = UserDefaults.standard.value(forKey: UserKeys.userPassword.rawValue) as? String
        {
            return userId
        }
        return ""
    }
    func removeUserPassword() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.userPassword.rawValue)
        
    }

    func removeAccessCode() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.user_AccessCode_id.rawValue)
        
    }
    
   
    func setUserDriverId(_ sUserTypeId:String) -> Void {
        UserDefaults.standard.set(sUserTypeId, forKey: UserKeys.user_Driver_id.rawValue)
    }
    func getUserDriverId() -> String {
        if let userTypeId = UserDefaults.standard.value(forKey: UserKeys.user_Driver_id.rawValue) as? String {
            return userTypeId
        }
        return ""
    }
    
    func removeUserDriverId() -> Void {
        
        UserDefaults.standard.removeObject(forKey: UserKeys.user_Driver_id.rawValue)
        
    }
    


    func setUserImage(_ userInfo:String) -> Void {
        UserDefaults.standard.set(userInfo, forKey: UserKeys.user_img.rawValue)
    }
    
    func getUserImage() -> String {
        let user_image = UserDefaults.standard.value(forKey: UserKeys.user_img.rawValue) as! String
        return user_image
    }
    
    func removeUserImage() -> Void {
        
        UserDefaults.standard.removeObject(forKey: UserKeys.user_img.rawValue)
        
    }

    func setRemmber(_ isRember:Bool) -> Void {
        UserDefaults.standard.set(isRember, forKey: UserKeys.isRemmber.rawValue)
    }
    
    func getRemmber() -> Bool {
        let isRember = UserDefaults.standard.bool(forKey: UserKeys.isRemmber.rawValue)
        return isRember
    }

    func setUserToken_id(_ sUserId:String) -> Void {
        UserDefaults.standard.set(sUserId, forKey: UserKeys.isToken.rawValue)
    }
    func getToken_Id() -> String {
        if let tokenId = UserDefaults.standard.value(forKey: UserKeys.isToken.rawValue) as? String {
            return tokenId
        }
        return ""
    }
   
    func removeGetToken_Id() -> Void {
        
        UserDefaults.standard.removeObject(forKey: UserKeys.isToken.rawValue)
        
    }
    
    
    func setUpcomingCount(_ Count:String) -> Void {
        UserDefaults.standard.set(Count, forKey: UserKeys.upComingCount.rawValue)
    }
    func getUpcomingCount() -> String {
        if let Count = UserDefaults.standard.value(forKey: UserKeys.upComingCount.rawValue) as? String {
            return Count
        }
        return ""
    }
    
    
    func setJobQueCount(_ JQCount:String) -> Void {
        UserDefaults.standard.set(JQCount, forKey: UserKeys.jobQueCount.rawValue)
    }
    func getJobQueCount() -> String {
        if let Count = UserDefaults.standard.value(forKey: UserKeys.jobQueCount.rawValue) as? String {
            return Count
        }
        return ""
    }
    
    func setpoolJobCount(_ poolJbCount:String) -> Void {
        UserDefaults.standard.set(poolJbCount, forKey: UserKeys.poolJobCount.rawValue)
    }
    func getPoolJobCount() -> String {
        if let Count = UserDefaults.standard.value(forKey: UserKeys.poolJobCount.rawValue) as? String {
            return Count
        }
        return ""
    }
    
    func removePoolJobCount() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.poolJobCount.rawValue)
        
    }
    
    
    
    func setUserInfo(_ sUserInfo:String) -> Void {
        
        UserDefaults.standard.set(sUserInfo, forKey: UserKeys.userInfo.rawValue)
    }
    func getUserInfo() -> String {
        if let userInfo = UserDefaults.standard.value(forKey: UserKeys.userInfo.rawValue) as? String
        {
            return userInfo
        }
        return ""
    }
    func removeUserInfo() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.userInfo.rawValue)
        
    }
    
    
    
func setUserLat(_ sUserlat:String) -> Void {
        
        UserDefaults.standard.set(sUserlat, forKey: UserKeys.userLat.rawValue)
    }
func getUserLat() -> String {
        if let userlat = UserDefaults.standard.value(forKey: UserKeys.userLat.rawValue) as? String
        {
            return userlat
        }
        return ""
    }
    
func removeUserLat() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.userLat.rawValue)
        
}
   
func setUserLong(_ sUserlong:String) -> Void {
        
        UserDefaults.standard.set(sUserlong, forKey: UserKeys.userLong.rawValue)
    }
    func getUserLong() -> String {
        if let userLong = UserDefaults.standard.value(forKey: UserKeys.userLong.rawValue) as? String
        {
            return userLong
        }
        return ""
    }
    
    func removeUserLong() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.userLong.rawValue)
        
    }
    
    
    
 func setUserCurrentLocationAdress(_ sUserCurrentLocation:String) -> Void {
        
        UserDefaults.standard.set(sUserCurrentLocation, forKey: UserKeys.UserCurentAdress.rawValue)
    }
    func getUserCurrentLocationAdress() -> String {
        if let UserCurrentLocation = UserDefaults.standard.value(forKey: UserKeys.UserCurentAdress.rawValue) as? String
        {
            return UserCurrentLocation
        }
        return ""
    }
    
    func removeUserCurrentLocationAdress() -> Void {
        UserDefaults.standard.removeObject(forKey: UserKeys.UserCurentAdress.rawValue)
        
    }
    
   
    
    
 /////////////////////////////Allll Check Dict Here .////////////////////////////////////////////////////////////////
    
//    let ckStartTrip = "ckStartTrip"
//    let ckOnSiteTrip = "ckOnSiteTrip"
//    let ckOnBoard = "ckOnBoard"
//    let ckJobDone = "ckJobDone"
//
    
//func setCkStartTrip(_ sUserCurrentLocation:String) -> Void {
//
//       UserDefaults.standard.set(sUserCurrentLocation, forKey: UserKeys.ckStartTrip.rawValue)
//   }
//   func getCkStartTrip() -> String {
//       if let ckStartTrip = UserDefaults.standard.value(forKey: UserKeys.ckStartTrip.rawValue) as? String
//       {
//           return ckStartTrip
//       }
//       return ""
//   }
//
//   func removeCkStartTrip() -> Void {
//       UserDefaults.standard.removeObject(forKey: UserKeys.ckStartTrip.rawValue)
//
//   }
//
//
//    func setckOnSiteTrip(_ sUserCurrentLocation:String) -> Void {
//
//        UserDefaults.standard.set(sUserCurrentLocation, forKey: UserKeys.ckOnSiteTrip.rawValue)
//    }
//    func getckOnSiteTrip() -> String {
//        if let ckOnSiteTrip = UserDefaults.standard.value(forKey: UserKeys.ckOnSiteTrip.rawValue) as? String
//        {
//            return ckOnSiteTrip
//        }
//        return ""
//    }
//
//    func removeckOnSiteTrip() -> Void {
//        UserDefaults.standard.removeObject(forKey: UserKeys.ckOnSiteTrip.rawValue)
//
//    }
//
//
//    func setckOnBoard(_ sUserCurrentLocation:String) -> Void {
//
//        UserDefaults.standard.set(sUserCurrentLocation, forKey: UserKeys.ckOnBoard.rawValue)
//    }
//    func getckOnBoard() -> String {
//        if let ckOnBoard = UserDefaults.standard.value(forKey: UserKeys.ckOnBoard.rawValue) as? String
//        {
//            return ckOnBoard
//        }
//        return ""
//    }
//
//    func removeckOnBoard() -> Void {
//        UserDefaults.standard.removeObject(forKey: UserKeys.ckOnBoard.rawValue)
//
//    }
//
//
//    func setckJobDone(_ sUserCurrentLocation:String) -> Void {
//
//        UserDefaults.standard.set(sUserCurrentLocation, forKey: UserKeys.ckJobDone.rawValue)
//    }
//    func getckJobDone() -> String {
//        if let ckJobDone = UserDefaults.standard.value(forKey: UserKeys.ckJobDone.rawValue) as? String
//        {
//            return ckJobDone
//        }
//        return ""
//    }
//
//    func removeckJobDone() -> Void {
//        UserDefaults.standard.removeObject(forKey: UserKeys.ckJobDone.rawValue)
//
//    }


}

enum UserKeys:String {
    
    case userName = "userName"
    case userPassword = "userPassword"
    case user_email = "user_email"
    case user_fullname = "user_fullname"
    case user_AccessCode_id = "AccessCode"
    case user_img = "user_img"
    case user_mob = "user_mob"
    case user_type = "user_type"
    case isRemmber = "isLogin"
    case isToken = "TokenId"
    case user_Driver_id = "user_Type_id"
    case fileBooking_Id = "fileBookingId"
    case jobQueCount = "jobQueCount"
    case upComingCount = "upComingCount"
    case userInfo = "userInfo"
    case  poolJobCount = "poolJobCount"
    case userLat = "UserLATI"
    case userLong = "UserLONGI"
    case UserCurentAdress = "CurentAdress"
    
    
    ///////Alll Check Here/////
    
//    case  ckStartTrip = "ckStartTrip"
//    case ckOnSiteTrip = "ckOnSiteTrip"
//    case ckOnBoard = "ckOnBoard"
//    case ckJobDone = "ckJobDone"
  
}

