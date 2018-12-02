//
//  ReviewCell.swift
//  Tabula
//
//  Created by Adi Veliman on 17/10/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit
import Cosmos


protocol ReviewDropdownDelegate : class {
    func viewCommentPressed(_ sender: ReviewCell, status: Bool, indexPath : IndexPath)
}

class ReviewCell: UITableViewCell {
   

    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var ratingStack: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var viewCommentBtn: UIButton!
    
    var pressed : Bool = false
    var index = IndexPath()
    weak var delegate : ReviewDropdownDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ratingStack.settings.updateOnTouch = false
        
        
        // Configure the view for the selected state
    }
    
    @IBAction func viewCommentPressed(_ sender: Any) {
        pressed = !pressed
        delegate?.viewCommentPressed(self, status: pressed, indexPath: index)
        
        
    }
    
}
