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

    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var ratingStack: CosmosView!
    
    @IBOutlet weak var cellView: UIView!
    
    
    var idCompany = Int()
    var itemNr : Int!
    weak var delegate : SpecificCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
       
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        ratingStack.settings.updateOnTouch = false
        ratingStack.isUserInteractionEnabled = false
        cellView.layer.cornerRadius = self.frame.size.width / 30
        //cellView.clipsToBounds = true
        //cellView.dropShadow(color: .gray, opacity: 0.7, offSet: CGSize(width: -1, height: 1), radius: 10, scale: true)
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOpacity = 1.2
        cellView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cellView.layer.shadowRadius = 10
        cellView.layer.shadowPath = UIBezierPath(rect: CGRect(x: cellView.bounds.origin.x+10, y: cellView.bounds.origin.y+10, width: cellView.bounds.width-35, height: 150)).cgPath
        companyImage.layer.cornerRadius = companyImage.frame.size.width / 30
        companyImage.clipsToBounds = true
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.specificCategoryTapped(self,Name: nameLabel.text ?? "Error", ID: idCompany, itemNr: self.itemNr)
    }

}
