//
//  CustomView.swift
//  Tabula
//
//  Created by Adi Veliman on 12/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width/40
        self.clipsToBounds = true
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        StyleKitVOucherT.drawVoucherType1(frame: rect,resizing: .stretch)
        
    }
 
    

}
