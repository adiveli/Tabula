//
//  CustomCellFilter.swift
//  Tabula
//
//  Created by Adi Veliman on 28/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class CustomCellFilter: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected){
            self.accessoryType = .checkmark
        }else{
            self.accessoryType = .none
        }
        // Configure the view for the selected state
    }

}
