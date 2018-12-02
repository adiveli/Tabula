//
//  Type3.swift
//  Tabula
//
//  Created by Adi Veliman on 20/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class Type3: UIViewController {

    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewContainer.layer.cornerRadius = self.viewContainer.frame.size.width/40
        self.viewContainer.clipsToBounds = true
        self.viewContainer.layer.borderWidth = 1.0
        self.viewContainer.layer.borderColor = UIColor.black.cgColor
        
        
        descriptionText.textColor = UIColor.gray
        descriptionText.text = "Your text goes here!"
        descriptionText.delegate = self
        // Do any additional setup after loading the view.
    }
    


}

extension Type3: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionText.text = ""
        descriptionText.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(descriptionText.text == ""){
            descriptionText.textColor = UIColor.gray
            descriptionText.text = "Your text goes here!"
        }
    }
}
