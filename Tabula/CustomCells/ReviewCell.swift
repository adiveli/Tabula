//
//  ReviewCell.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {

    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var ratingStack: CosmosView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ratingStack.settings.updateOnTouch = false

        // Configure the view for the selected state
    }

}
