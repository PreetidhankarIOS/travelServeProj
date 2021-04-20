




import Foundation



let K_NoInternet = "Network lost. Please check your internet connection."
let GoogleApiKeyForAllproject = Configuration.googlePlaceAPIKey()

class AppSetting {
     /*PRODUCTION*/
     static let BASE_URL = "http://193.39.255.52:92"
}


let startJobOrNot = "StartJobOrNot"

 let KeyMain = "MainKeyForLogin"
let RemmemberPwd = "RemmemberPassword"
let KuserName = "userName"
let Kpassword = "password"
let ckStartDeriverShip = "ckStartDeriverShip"
let IsLodingViewInScondeAPI = "IsLodingViewInScondeAPI"
let logoutBackgroundNotification = "logoutBackgroundNotification"
let ckeckChatWithNotification = "ckeckChatWithNotification"
let upadteForErrorJson = "upadteForErrorJson"
let ckdataAfterLogout = "ckdataAfterLogout"

///All Ck For goingOn Trips

let ckStartTrip = "ckStartTrip"
let ckOnSiteTrip = "ckOnSiteTrip"
let ckOnBoard = "ckOnBoard"
let ckTripComplet = "ckTripComplet"
let ckJobDone = "ckJobDone"

class ImageUpload{
    
    static let IMAGE_UPLOAD = "https://www.edxpert.in/api/upload-doc"
}

class UserModule {

    static let SIGN_IN                    = "/login/"
    static let FORGOT_PASSWORD            = "/ForgetPassword/"
    static let REGISTRATION_IMAGE         = "/RegistrationImage/"
    static let ACTIVE_DRIVER              = "/ActiveDriver/"
    static let IN_ACTIVE_DRIVER           = "/InActiveDriver/"
    static let UPCOMEING_Requstes         = "/GetUpCommingMobDriverTransferBooking/"
    static let STARTDEIVER_SHIFT          = "/StartDriverShift/"
    static let DRIVER_ACKNOWLEDGE         = "/DriverAcknowledge/"
    static let DRIVER_CANCEL_BOOKING      = "/DriverCancelBooking/"
    static let RIDE_COMPLETED             = "/GetPastMobDriverTransferBooking/"
    static let DRIVER_DETAIL              = "/DriverDetail/"
    static let DRIVER_STRART_JOB          = "/DriverStartJob/"
    static let KPlaceDetailURL            = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
    static let DRIVER_ON_SIDE             = "/DriverOnSide/"
    static let NO_SHOW                    = "/NoShow/"
    static let SUBMIT_CASH_OR_CARD        = "/ByDriverReceivedAmount/"
    static let TRIP_COMPLETE              = "/TripCompleted/"
    static let DRIVER_DENIED_BOOKING      = "/AddDriverDeniedBooking/"
    static let GETCANCEL_BOOKING          = "/GetCancelBooking/"
    static let UPDATE_PROFILE             = "/UpdateDriverProfile/"
    static let UPDATE_PROFILE_IMAGE       = "/DriverImage/"
    static let ADD_MOB_DEVICEID           = "/AddMobDeviceId/"
    static let LOG_OUT                    = "/EndDriverShift/"
    static let DRIVER_CONFIRM_PICK_UP     = "/DriverConfirmPickup/"
    static let UPDATE_VEHICAL_DETAILS     = "/UpdateVehicleDetails/"
    static let VHICAL_LIST                = "/VehicleList/"
    static let PAYMENT_HISTORY            = "/DriverPaymentHistory/"
    static let UPDATE_DRIVER_LOCATION     = "/UpdateDriverLocation/"
    static let CHATHISTORY                = "/ChatHistory/"
    static let JOBPOOL                    = "/TransferBookingListForPool/"
    static let TRANSFERPOOLREQUEST        = "/TransferPoolRequest/"
    static let DRIVER_STATEMENT           = "/TransferBookingInvoiceStatement/"
    static let DISAPPROVE_INV_STATEMENT   = "/DisApproveInvoiceStatement/"
    static let APPROVE_INV_STATEMENT      = "/ApproveInvoiceStatement/"
    static let ADDCHATHISTORY             = "/AddChatHistory/"
    static let GETBOOKINGCHATLIST         = "/GetBookingChatList/"
    static let PickupWaitingChargesInfo   = "/PickupWaitingChargesInfo/"
    static let UpdateWaitingChargesInfo   = "/UpdateWaitingChargesInfo/"
    static let ByDriverNotification   = "/ByDriverNotification/"
    static let UploadAirlineBookingVaucher = "/UploadAirlineBookingVaucher/"
    
}



let KFileNumber = "FileBooking number"
let KuserAdress = "UserDateORAddress"



func isGuardObject(_ value: AnyObject?) -> Bool {
    guard let _ = value else {
        return false
    }
    return true
}

enum DataServiceResponse {
    
    case success
    case error
    case serverFail(String?) // this shouldn't really happen, but...
    case missingOrBadValue(String?)
    case unknown(String?)
    // case statusCode
    
    func successful() -> Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
        
    }
    
}


////AddPendingDriver
//GetAllLocation
//ByDriverNotification



//UpdateDriverLocation in all apication 10 scond
//UpdateVehicleDetails //save data


//VehicleList //drop dwon
//ViaDetails


