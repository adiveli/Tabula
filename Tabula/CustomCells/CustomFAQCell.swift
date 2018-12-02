//
//  CustomFAQCell.swift
//  Tabula
//
//  Created by Adi Veliman on 01/12/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class CustomFAQCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerView: UITextView!
    
    var selection : Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
