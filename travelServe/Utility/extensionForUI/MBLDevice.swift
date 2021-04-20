//
//  MBLDevice.swift
//  MattarBinLahej
//
//  Created by Haider Abbas on 01/11/18.
//  Copyright © 2018 Haider Abbas. All rights reserved.
//

import Foundation
import UIKit

struct MBLDevice {
    
    static let SCREENSIZE: CGRect = UIScreen.main.bounds
    static let ISIPAD = (UIDevice.current.userInterfaceIdiom == .pad)
    static let ISIPHONEX = (UIScreen.main.nativeBounds.height == 2436)
    static let IS5S = (UIScreen.main.bounds.width == 320)
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let IPHONE8PLUSWIDTH = CGFloat(414.0)
    static let IPHONE8PLUSHEIGHT = CGFloat(736.0)
    static let IPHONEXHEIGHT = CGFloat(812.0)
    static let IPADWIDTH = CGFloat(768.0)
    static let IPADHEIGHT = CGFloat(1024.0)
    static let SCREEN_MAX_LENGTH = max(MBLDevice.screenWidth, MBLDevice.screenHeight)
    
    static let universalPointWidthSizeMultiplier: CGFloat = ISIPAD ? (screenWidth*1.4/IPADWIDTH) : screenWidth/IPHONE8PLUSWIDTH
    static let universalPointHeightSizeMultiplier: CGFloat = ISIPAD ? (screenHeight*1.4/IPADHEIGHT) : screenHeight/IPHONE8PLUSHEIGHT
    static let universalWidthMultiplier: CGFloat = screenWidth/IPHONE8PLUSWIDTH
    static let universalHeightMultiplier: CGFloat = screenHeight/IPHONE8PLUSHEIGHT
    
    
    static var ISIPHONEXORMORE: Bool {
        var iphoneX = false
        if #available(iOS 11.0, *) {
            if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(0.0)) {
                iphoneX = true
            }
        }
        return iphoneX
    }
    
    static var productCornerRadiusConstant: CGFloat {
        return screenHeight*8/IPHONE8PLUSHEIGHT
    }
    
    static var cellPaddingCategoryConstant: CGFloat {
        return screenHeight*6/IPHONE8PLUSHEIGHT
    }
    
    static var annotationViewHeightConstant: CGFloat {
        return screenHeight*60/IPHONE8PLUSHEIGHT
    }
    
    static var createAccountStackSpacingConstant: CGFloat {
        return screenHeight*12/IPHONE8PLUSHEIGHT
    }
    
    static var stackSpacingConstraintConstant: CGFloat {
        return screenWidth*12/IPHONE8PLUSWIDTH
    }
    
    static var loginUsingBottomConstant: CGFloat {
        return screenHeight*15/IPHONE8PLUSHEIGHT
    }
    
    static var accountbuttonTopConstant: CGFloat {
        return screenHeight*20/IPHONE8PLUSHEIGHT
    }
    
    static var aboutRowHeight: CGFloat {
        return screenHeight*204/IPHONE8PLUSHEIGHT
    }
    
    static var knowMoreImageViewHeight: CGFloat {
        return screenHeight*224/IPHONE8PLUSHEIGHT
    }
    
    static var knowMoreVerticalConstraint: CGFloat {
        return screenHeight*20/IPHONE8PLUSHEIGHT
    }
    
    static var paintingTypeHeightConstraint: CGFloat {
        return screenHeight*220/IPHONE8PLUSHEIGHT
    }
    
    static var moreProductCollectionCellHeight: CGFloat {
        return screenHeight*225/IPHONE8PLUSHEIGHT
    }
    
    static var similarProductCollectionCellWidth: CGFloat {
        return 120*universalPointHeightSizeMultiplier
    }
    
    static var moreProductCollectionHeaderHeight: CGFloat {
        return screenHeight*52/IPHONE8PLUSHEIGHT
    }
    
    static var popularProductCollectionHeaderHeight: CGFloat {
        return screenHeight*221/IPHONE8PLUSHEIGHT
    }
    
    static var categoryProductCollectionCellHeight: CGFloat {
        return screenHeight*225/IPHONE8PLUSHEIGHT
    }
    
    static var productDetailContentViewHeightConstraintConstant: CGFloat {
        if ISIPHONEXORMORE { return screenHeight * 1.4 }
        else if ISIPAD { return screenHeight * 2.2 }
        else { return screenHeight * 1.5 }
    }
    
}
