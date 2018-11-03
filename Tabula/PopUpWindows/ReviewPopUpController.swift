//
//  ReviewPopUpController.swift
//  Tabula
//
//  Created by Adi Veliman on 01/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Cosmos

class ReviewPopUpController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var ratingStack: CosmosView!
    @IBOutlet weak var reviewText: UITextView!
    
    
    var onSave: ((_ rating: Int,_ description: String,_ date: String)->())?
    
    let date = Date()
    let formatter = DateFormatter()
    var currentDate = String()
    var keyboardHeight = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpMenu()
        formatter.dateFormat = "dd.MM.yyyy"
        currentDate = formatter.string(from: date)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ReviewPopUpController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReviewPopUpController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                
                bottomConstraint.constant = keyboardSize.height + 30
                topConstraint.constant = 35
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        topConstraint.constant = 130
        bottomConstraint.constant = 150
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard(){
        reviewText.endEditing(true)
    }
    
    func setPopUpMenu(){
        ratingStack.rating = 0
        popUpView.layer.cornerRadius = popUpView.frame.size.width / 16
        reviewText.textColor = UIColor.gray
        reviewText.text = "Your text goes here!"
        reviewText.delegate = self
        
        tapGesture.addTarget(self, action: #selector(dismissKeyboard))
        popUpView.addGestureRecognizer(tapGesture)
    }
    

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if(reviewText.text == "Your text goes here!"){
            self.titleLabel.text = "You can't submit an empty review!"
            UIView.animate(withDuration: 0.2, animations: {
                let animation = CGAffineTransform(scaleX: 1.2, y: 1)
                self.titleLabel.transform = animation
                
            
            }) { (value) in
                if(value){
                    UIView.animate(withDuration: 0.2, animations: {
                        self.titleLabel.transform = .identity
                    })
                }
            }
            //titleLabel.text = "You can't submit an empty review!"
        }else{
            onSave?(Int(ratingStack.rating), reviewText.text as String, self.currentDate)
            dismiss(animated: true, completion: nil)
        }
    }
    

}


extension ReviewPopUpController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        reviewText.text = ""
        reviewText.textColor = UIColor.black

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(reviewText.text == ""){
            reviewText.textColor = UIColor.gray
            reviewText.text = "Your text goes here!"

        }
    }
    
    
}

