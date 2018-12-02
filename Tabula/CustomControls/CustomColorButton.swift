//
//  CustomColorButton.swift
//  Tabula
//
//  Created by Adi Veliman on 13/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit


class CustomColorButton: UIButton {

    @IBInspectable var fillColor : UIColor = UIColor.green
    private var selection : Bool = false
    private var avoidCrash : Bool = true
    

    override func draw(_ rect: CGRect) {
        

        let path = UIBezierPath(ovalIn: CGRect(x: self.bounds.origin.x+2.5, y: self.bounds.origin.y+2.5, width: self.bounds.width-5, height: self.bounds.height-5))
        fillColor.setFill()
        path.fill()

        if(selection == true && avoidCrash == true){
            underlineWithAnimation(color: UIColor.black, completion: {()->() in
        
            })
            
        } else if (selection == false && avoidCrash == true) {
            underlineWithAnimation(color: fillColor, completion: {()->() in
                self.removeSelection()
            })
            
        }
        
        
    }
    
    func removeSelection(){
        if layer.sublayers != nil{
        for layer in layer.sublayers!{
            layer.removeFromSuperlayer()
        }
        }
        selection = false
        //setNeedsDisplay()
    }
    
    override func awakeFromNib() {
        addTarget(self, action: #selector(changeState), for: UIControlEvents.touchUpInside)
    }
    
    @objc func changeState(){
        selection = !selection
        setNeedsDisplay()
    }
    
    
    
    
    func underlineCircle(color: UIColor){
        let selectionPath = UIBezierPath(ovalIn: CGRect(x: self.bounds.origin.x+2.5, y: self.bounds.origin.y+2.5, width: self.bounds.width-5, height: self.bounds.height-5))
        
        selectionPath.lineWidth = 1
        color.setStroke()
        selectionPath.stroke()
        
        
    }
    
    func underlineWithAnimation(color : UIColor,completion : @escaping ()->()){
        CATransaction.begin()
        avoidCrash = false
        
        let layer : CAShapeLayer = CAShapeLayer()
        layer.strokeColor = color.cgColor
        
        layer.lineWidth = 2.0
        layer.lineCap = kCALineCapRound
        
        
        layer.fillColor = UIColor.clear.cgColor
        
        let path : UIBezierPath = UIBezierPath(ovalIn: CGRect(x: self.bounds.origin.x+3.5, y: self.bounds.origin.y+3.5, width: self.bounds.width-6, height: self.bounds.height-6))
        layer.path = path.cgPath
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        animation.duration = 0.5
        
        CATransaction.setCompletionBlock{ [weak self] in
            //print("Animation completed")
            self!.avoidCrash = true
            completion()
        }
        
        layer.add(animation, forKey: "myStroke")
        CATransaction.commit()
        self.layer.addSublayer(layer)
        
    }

    
    
 

}
