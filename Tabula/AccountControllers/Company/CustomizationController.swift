//
//  CustomizationController.swift
//  Tabula
//
//  Created by Adi Veliman on 13/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import SVProgressHUD

class CustomizationController: UIViewController {
    
    
    @IBOutlet var colorBtns: [CustomColorButton]!
    
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var stackViewBTNS: UIStackView!
    @IBOutlet weak var backBtn : UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var netService = NetworkServices()
    
    var customizationStage : Int = 0
    
    var container : ContainerViewController!

    var voucherColor : UIColor = UIColor.white
    
    var curentView : UIViewController!
    
    var itemIndex = Int()
    
    let defaultValues = UserDefaults.standard
    
    let date = Date()
    let formatter = DateFormatter()
    var currentDate = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.isHidden = true
        backBtn.alpha = 0
        
        formatter.dateFormat = "dd.MM.yyyy"
        currentDate = formatter.string(from: date)
        
        //setItem(index: itemIndex)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setItem(index: itemIndex)
        tapGesture.addTarget(self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.activateEditing(control: false)
    }
    
    @objc func dismissKeyboard(){
        
        self.view.endEditing(true)

    }
    
    
    @IBAction func nextPressed(_ sender: Any) {

        if(customizationStage == 0){
            nextBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, animations: {
            self.stackViewBTNS.transform = CGAffineTransform(translationX: -self.stackViewBTNS.frame.size.width-self.stackViewBTNS.frame.origin.x, y: self.stackViewBTNS.bounds.origin.y)
            self.backBtn.isHidden = false
            self.backBtn.alpha = 1
        }) { (true) in
            
            self.nextBtn.isUserInteractionEnabled = true
           self.highlightText()
            self.activateEditing(control: true)
            self.customizationStage = self.customizationStage + 1
            
            }
        }else if customizationStage == 1{
            
            nextBtn.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.4, animations: {
                self.nextBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
            }) { (true) in
                self.nextBtn.isUserInteractionEnabled = true
                UIView.animate(withDuration: 0.4, animations: {
                    self.nextBtn.transform = CGAffineTransform(rotationAngle: 1.5708)
                })

            }
            
            self.removeAnimations()
            self.activateEditing(control: false)
            //nextBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.customizationStage = self.customizationStage + 1
        }else if customizationStage == 2{
            
            saveSpecificVoucher()
            
        }
        
    }
    
    
    func saveSpecificVoucher(){
        
        
        SVProgressHUD.show(withStatus: "Saving promotion!")
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setDefaultMaskType(.black)
        
        if itemIndex == 0{
            if let curentView = self.container.currentViewController as? Type1{
                netService.savePromotion(companyID: self.defaultValues.integer(forKey: "cid"), description: curentView.descriptionText.text, type: 1, color: "\(voucherColor.toHex() as! String)", code: curentView.promotionCodeText.text, date: currentDate) { (isSaved) in
                    if isSaved{
                        SVProgressHUD.showSuccess(withStatus: "Succes!")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
            
        }else if itemIndex == 1{
            if let curentView = self.container.currentViewController as? Type2{
                netService.savePromotion(companyID: self.defaultValues.integer(forKey: "cid"), description: curentView.descriptionText.text, type: 2, color: "\(voucherColor.toHex() as! String)", code: "-", date: currentDate) { (isSaved) in
                    if isSaved{
                        SVProgressHUD.showSuccess(withStatus: "Succes!")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }else if itemIndex == 2{
            if let curentView = self.container.currentViewController as? Type3{
                netService.savePromotion(companyID: self.defaultValues.integer(forKey: "cid"), description: curentView.descriptionText.text, type: 3, color: "\(voucherColor.toHex() as! String)", code: "-", date: currentDate) { (isSaved) in
                    if isSaved{
                        SVProgressHUD.showSuccess(withStatus: "Succes!")
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
        
        
    }
    
    func highlightText(){
        if itemIndex == 0{
            if let curentView = self.container.currentViewController as? Type1{
                curentView.descriptionText.layer.cornerRadius = curentView.descriptionText.frame.size.width/30
                curentView.descriptionText.clipsToBounds = true
                curentView.promotionCodeText.layer.cornerRadius = curentView.descriptionText.frame.size.width/30
                curentView.promotionCodeText.clipsToBounds = true
                animateBorderWidth(view: curentView.descriptionText, from: 0, to: 2, duration: 1)
                animateBorderWidth(view: curentView.promotionCodeText, from: 0, to: 2, duration: 1)

                
            }
            
            
        }else if itemIndex == 1{
            if let curentView = self.container.currentViewController as? Type2{
                let borderWidth:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
                curentView.descriptionText.layer.cornerRadius = curentView.descriptionText.frame.size.width/30
                curentView.descriptionText.clipsToBounds = true
                animateBorderWidth(view: curentView.descriptionText, from: 0, to: 2, duration: 1)
                
            }
        }else if itemIndex == 2{
            if let curentView = self.container.currentViewController as? Type3{
                curentView.descriptionText.layer.cornerRadius = curentView.descriptionText.frame.size.width/30
                curentView.descriptionText.clipsToBounds = true
                animateBorderWidth(view: curentView.descriptionText, from: 0, to: 2, duration: 1)
                
            }
        }
        
        
    }
    
    func animateBorderWidth(view: UIView, from: CGFloat, to: CGFloat, duration: Double) {
        
            let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
            animation.fromValue = from
            animation.toValue = to
            animation.duration = duration
            animation.repeatCount = Float.infinity
            animation.isRemovedOnCompletion = false
            view.layer.add(animation, forKey: "Width")
            view.layer.borderWidth = to
        
    }
    
    
    @IBAction func backPressed(_ sender: UIButton){
        
        if customizationStage == 1{
            backBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.stackViewBTNS.transform = .identity
            self.backBtn.alpha = 0
        }) { (true) in
            self.backBtn.isHidden = true
            self.backBtn.isUserInteractionEnabled = true
            self.removeAnimations()
        }
            self.activateEditing(control: false)
            customizationStage = customizationStage - 1
        }else if customizationStage == 2{
            backBtn.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.4, animations: {
                self.nextBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.nextBtn.transform = CGAffineTransform(rotationAngle: 0)
            }) { (true) in
                self.backBtn.isUserInteractionEnabled = true
            }
            
            self.highlightText()
            self.activateEditing(control: true)
            customizationStage = customizationStage - 1
            self.nextBtn.setImage(UIImage(named: "nextButton"), for: .normal)
            
        }
        

    }
    
    func activateEditing(control : Bool){
        
        if itemIndex == 0{
            if let curentView = self.container.currentViewController as? Type1{
                
                curentView.descriptionText.isUserInteractionEnabled = control
                curentView.promotionCodeText.isUserInteractionEnabled = control
                
                
                
            }
            
            
        }else if itemIndex == 1{
            if let curentView = self.container.currentViewController as? Type2{
                curentView.descriptionText.isUserInteractionEnabled = control
                
            }
        }else if itemIndex == 2{
            if let curentView = self.container.currentViewController as? Type3{
                curentView.descriptionText.isUserInteractionEnabled = control
                
            }
        }
        
        
    }
    
    func removeAnimations(){
        
        if itemIndex == 0{
            if let curentView = self.container.currentViewController as? Type1{
                
                curentView.descriptionText.layer.removeAllAnimations()
                curentView.promotionCodeText.layer.removeAllAnimations()
                curentView.descriptionText.layer.borderWidth = 0
                curentView.promotionCodeText.layer.borderWidth = 0
                
                
            }
            
            
        }else if itemIndex == 1{
            if let curentView = self.container.currentViewController as? Type2{
                curentView.descriptionText.layer.removeAllAnimations()
                curentView.descriptionText.layer.borderWidth = 0
                
            }
        }else if itemIndex == 2{
            if let curentView = self.container.currentViewController as? Type3{
                curentView.descriptionText.layer.removeAllAnimations()
                curentView.descriptionText.layer.borderWidth = 0
                
            }
        }
        
        
    }
    
    
    func setIndex(index: Int){
        self.itemIndex = index
    }
    
    
    
    func setItem(index: Int){
        if index == 0{
            self.container.segueIdentifierReceivedFromParent("type1")
            if let curentView = self.container.currentViewController as? Type1{
                curentView.viewContainer.backgroundColor = voucherColor
                curentView.nameLabel.text = "\(defaultValues.object(forKey: "companyName") as! String)"
                
            }
            //curentView.
        }else if index == 1{
            self.container.segueIdentifierReceivedFromParent("type2")
            if let curentView = self.container.currentViewController as? Type2{
                curentView.viewContainer.backgroundColor = voucherColor
                curentView.nameLabel.text = "\(defaultValues.object(forKey: "companyName") as! String)"
                
            }
        }else if index == 2{
            self.container.segueIdentifierReceivedFromParent("type3")
            if let curentView = self.container.currentViewController as? Type3{
                curentView.nameLabel.text = "\(defaultValues.object(forKey: "companyName") as! String)"
                
            }
        }
    }
    
    func setColor(){
        if itemIndex == 0{
            if let curentView = self.container.currentViewController as? Type1{
                curentView.viewContainer.backgroundColor = voucherColor
            }
            //curentView.
        }else if itemIndex == 1{
            if let curentView = self.container.currentViewController as? Type2{
                curentView.viewContainer.backgroundColor = voucherColor
            }
        }else if itemIndex == 2{
            if let curentView = self.container.currentViewController as? Type3{
                curentView.viewContainer.backgroundColor = voucherColor
            }
        }
    }

    
    
    @IBAction func colorBtnPressed(_ sender: CustomColorButton) {
        if(sender.tag == 0){
            var tempArray = colorBtns
            tempArray?.remove(at: 0)
            for btn in tempArray!{
                btn.removeSelection()
                
            }
            voucherColor = sender.fillColor
            setColor()
            
        }else if(sender.tag == 1){
            var tempArray = colorBtns
            tempArray?.remove(at: 1)
            for btn in tempArray!{
                btn.removeSelection()
            }
            voucherColor = sender.fillColor
            setColor()
          
        }else if(sender.tag == 2){
            var tempArray = colorBtns
            tempArray?.remove(at: 2)
            for btn in tempArray!{
                btn.removeSelection()
                
            }
            voucherColor = sender.fillColor
            setColor()
            
        }
        else if(sender.tag == 3){
            var tempArray = colorBtns
            tempArray?.remove(at: 3)
            for btn in tempArray!{
                btn.removeSelection()
            }
            voucherColor = sender.fillColor
            setColor()
            
        }
            
        else if(sender.tag == 4){
            var tempArray = colorBtns
            tempArray?.remove(at: 4)
            for btn in tempArray!{
                btn.removeSelection()
            }
            voucherColor = sender.fillColor
            setColor()
            
        }
        else if(sender.tag == 5){
            var tempArray = colorBtns
            tempArray?.remove(at: 5)
            for btn in tempArray!{
                btn.removeSelection()
            }
            voucherColor = sender.fillColor
            setColor()
            
        }else if(sender.tag == 6){
            var tempArray = colorBtns
            
            tempArray?.remove(at: 6)
            for btn in tempArray!{
                btn.removeSelection()
            }
            voucherColor = sender.fillColor
            setColor()
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
            
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.5, .transitionCrossDissolve)
        }
    }


}







