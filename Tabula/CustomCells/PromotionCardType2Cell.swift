//
//  PromotionCardType2Cell.swift
//  Tabula
//
//  Created by Adi Veliman on 03/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class PromotionCardType2Cell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.cornerRadius = viewContainer.frame.size.width/40
        viewContainer.clipsToBounds = true
        viewContainer.layer.borderColor = UIColor.black.cgColor
        viewContainer.layer.borderWidth = 2.0
    }
   
    
    
    
}
