//
//  ArrowView.swift
//  Tabula
//
//  Created by Adi Veliman on 15/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        
        let layer : CAShapeLayer = CAShapeLayer()
        layer.strokeColor = UIColor.black.cgColor
        
        layer.lineWidth = 2.0
        layer.lineCap = kCALineCapRound
        
        
        layer.fillColor = UIColor.clear.cgColor
        
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 36.78, y: 116.39))
        shape.addCurve(to: CGPoint(x: 9.12, y: 29.94), controlPoint1: CGPoint(x: 19.05, y: 91.24), controlPoint2: CGPoint(x: 9.34, y: 60.7))
        shape.addCurve(to: CGPoint(x: 10.83, y: 3.56), controlPoint1: CGPoint(x: 9.1, y: 21.12), controlPoint2: CGPoint(x: 9.74, y: 12.33))
        shape.addCurve(to: CGPoint(x: 11.11, y: 4.29), controlPoint1: CGPoint(x: 10.9, y: 3.83), controlPoint2: CGPoint(x: 11.03, y: 4.01))
        shape.addCurve(to: CGPoint(x: 12.63, y: 7.53), controlPoint1: CGPoint(x: 11.64, y: 5.38), controlPoint2: CGPoint(x: 12.18, y: 6.48))
        shape.addCurve(to: CGPoint(x: 15.65, y: 14.46), controlPoint1: CGPoint(x: 13.65, y: 9.81), controlPoint2: CGPoint(x: 14.67, y: 12.09))
        shape.addCurve(to: CGPoint(x: 18.07, y: 16.26), controlPoint1: CGPoint(x: 16.05, y: 15.37), controlPoint2: CGPoint(x: 17.24, y: 15.92))
        shape.addCurve(to: CGPoint(x: 20, y: 16.3), controlPoint1: CGPoint(x: 18.25, y: 16.36), controlPoint2: CGPoint(x: 20.33, y: 16.94))
        shape.addCurve(to: CGPoint(x: 14.82, y: 5.43), controlPoint1: CGPoint(x: 18.36, y: 12.65), controlPoint2: CGPoint(x: 16.64, y: 8.95))
        shape.addCurve(to: CGPoint(x: 8.42, y: 0.05), controlPoint1: CGPoint(x: 13.66, y: 3.19), controlPoint2: CGPoint(x: 11.58, y: -0.48))
        shape.addCurve(to: CGPoint(x: 6.41, y: 2.25), controlPoint1: CGPoint(x: 7.3, y: 0.23), controlPoint2: CGPoint(x: 6.8, y: 1.33))
        shape.addCurve(to: CGPoint(x: 4.28, y: 7.93), controlPoint1: CGPoint(x: 5.61, y: 4.1), controlPoint2: CGPoint(x: 4.99, y: 6.04))
        shape.addCurve(to: CGPoint(x: 0.01, y: 19.97), controlPoint1: CGPoint(x: 2.77, y: 11.9), controlPoint2: CGPoint(x: 1.35, y: 15.91))
        shape.addCurve(to: CGPoint(x: 2.34, y: 21.15), controlPoint1: CGPoint(x: -0.19, y: 20.55), controlPoint2: CGPoint(x: 2.13, y: 21.72))
        shape.addCurve(to: CGPoint(x: 6.8, y: 10.82), controlPoint1: CGPoint(x: 3.87, y: 17.76), controlPoint2: CGPoint(x: 5.36, y: 14.25))
        shape.addCurve(to: CGPoint(x: 6.9, y: 10.64), controlPoint1: CGPoint(x: 6.85, y: 10.73), controlPoint2: CGPoint(x: 6.85, y: 10.73))
        shape.addCurve(to: CGPoint(x: 7.19, y: 48.07), controlPoint1: CGPoint(x: 5.16, y: 23.06), controlPoint2: CGPoint(x: 5.56, y: 35.74))
        shape.addCurve(to: CGPoint(x: 20.32, y: 92.86), controlPoint1: CGPoint(x: 9.17, y: 63.47), controlPoint2: CGPoint(x: 13.68, y: 78.65))
        shape.addCurve(to: CGPoint(x: 33.51, y: 115.49), controlPoint1: CGPoint(x: 24.06, y: 100.76), controlPoint2: CGPoint(x: 28.44, y: 108.33))
        shape.addCurve(to: CGPoint(x: 35.77, y: 116.97), controlPoint1: CGPoint(x: 34.01, y: 116.22), controlPoint2: CGPoint(x: 34.89, y: 116.71))
        shape.addCurve(to: CGPoint(x: 36.78, y: 116.39), controlPoint1: CGPoint(x: 36.08, y: 117.03), controlPoint2: CGPoint(x: 37.29, y: 117.12))
        shape.close()
        layer.path = shape.cgPath
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        animation.duration = 2
        
        CATransaction.setCompletionBlock{ [weak self] in
            print("Animation completed")
            //self!.avoidCrash = true
            
        }
        
        layer.add(animation, forKey: "myStroke")
        CATransaction.commit()
        self.layer.addSublayer(layer)
    }
    
    
 

}
