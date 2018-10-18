//
//  CategoriesCell.swift
//  Tabula
//
//  Created by Adi Veliman on 13/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit



class CategoriesCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    weak var delegate: CategoriesCellDelegate?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    // adding action to every category
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.containerView.addGestureRecognizer(tap)
        containerView.isUserInteractionEnabled = true
        
        
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.categoryTapped(self,value: categoryNameLabel.text ?? "Error")
    }
    


}
