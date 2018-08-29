//
//  ServiceTableViewCell.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 5/27/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
