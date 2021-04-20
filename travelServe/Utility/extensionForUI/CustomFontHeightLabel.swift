//
//  CustomFontHeightLabel.swift
//  MattarBinLahej
//
//  Created by Haider Abbas on 10/11/18.
//  Copyright © 2018 Haider Abbas. All rights reserved.
//

import UIKit

class CustomFontHeightLabel: UILabel {

    override func awakeFromNib() {
        self.font = UIFont(name: self.font.fontName, size: self.font.pointSize * MBLDevice.universalPointHeightSizeMultiplier)
    }

}
