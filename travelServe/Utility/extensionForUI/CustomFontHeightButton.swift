//
//  CustomFontHeightButton.swift
//  MattarBinLahej
//
//  Created by Haider Abbas on 09/11/18.
//  Copyright © 2018 Haider Abbas. All rights reserved.
//

import UIKit

class CustomFontHeightButton: UIButton {

    private func configureFont() {
        self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size: (self.titleLabel?.font.pointSize)! * MBLDevice.universalPointHeightSizeMultiplier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureFont()
    }

}
