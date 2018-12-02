//
//  PromotionCardType1Cell.swift
//  Tabula
//
//  Created by Adi Veliman on 03/11/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class PromotionCardType1Cell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var specializationIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var voucherLabel: UILabel!
    @IBOutlet weak var viewColorContainer : CustomView!

    
    override func awakeFromNib() {
        viewColorContainer.layer.cornerRadius = viewColorContainer.frame.size.width / 40
        viewColorContainer.clipsToBounds = true
        viewColorContainer.layer.borderColor = UIColor.black.cgColor
        viewColorContainer.layer.borderWidth = 2.0
    }
    
    
    
    
}
