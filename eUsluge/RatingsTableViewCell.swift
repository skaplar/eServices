//
//  RatingsTableViewCell.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/16/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class RatingsTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var userLeftTheCommentLabel: UILabel!
    @IBOutlet weak var ratingUserLeftLabel: UILabel!
    @IBOutlet weak var dateCommentLeftLabel: UILabel!
    @IBOutlet weak var serviceProvidedLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
