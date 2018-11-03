//
//  SpecificCategoryCell.swift
//  Tabula
//
//  Created by Adi Veliman on 13/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Cosmos

class SpecificCategoryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var chenarView: UIImageView!
    @IBOutlet weak var ratingStack: CosmosView!
    
    var idCompany = Int()
    weak var delegate : SpecificCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.chenarView.addGestureRecognizer(tap)
        chenarView.isUserInteractionEnabled = true
        ratingStack.settings.updateOnTouch = false
        ratingStack.isUserInteractionEnabled = false
        
        
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.specificCategoryTapped(self,Name: nameLabel.text ?? "Error", ID: idCompany)
    }

}
