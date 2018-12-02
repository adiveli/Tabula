//
//  Type1.swift
//  Tabula
//
//  Created by Adi Veliman on 20/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class Type1: UIViewController {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var promotionCodeText: UITextView!
    @IBOutlet weak var viewContainer : CustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextViews()
        // Do any additional setup after loading the view.
    }
    
    func setTextViews(){
        descriptionText.textColor = UIColor.gray
        descriptionText.text = "Your text goes here!"
        descriptionText.delegate = self
        
        promotionCodeText.textColor = UIColor.gray
        promotionCodeText.text = "Your text goes here!"
        promotionCodeText.delegate = self
    }
    

   
}

extension Type1: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.tag == 1){
        descriptionText.text = ""
        descriptionText.textColor = UIColor.black
        } else if textView.tag == 2{
        promotionCodeText.text = ""
        promotionCodeText.textColor = UIColor.black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.tag == 1){
            if(descriptionText.text == ""){
                descriptionText.textColor = UIColor.gray
                descriptionText.text = "Your text goes here!"
                
            }
        }
        if(textView.tag == 2){
            if(promotionCodeText.text == ""){
                promotionCodeText.textColor = UIColor.gray
                promotionCodeText.text = "Your text goes here!"
                
            }
        }
    }
    
    
}
