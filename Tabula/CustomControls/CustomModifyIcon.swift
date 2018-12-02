//
//  CustomModifyIcon.swift
//  Tabula
//
//  Created by Adi Veliman on 07/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit


class CustomModifyIcon : UIButtonX {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        UIView.animate(withDuration: 0.3) {
            
            if self.transform == .identity{
                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }else{
                self.transform = .identity
            }
        }
        return super.beginTracking(touch, with: event)
}
}
