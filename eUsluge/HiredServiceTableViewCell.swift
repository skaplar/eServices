//
//  HiredServiceTableViewCell.swift
//  eUsluge
//
//  Created by Sebastijan Kaplar on 12/14/18.
//  Copyright © 2018 Sebastijan Kaplar. All rights reserved.
//

import UIKit

class HiredServiceTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var serviceProviderImageView: UIImageView!
    @IBOutlet weak var serviceProviderNameLabel: UILabel!
    @IBOutlet weak var serviceCityLabel: UILabel!
    @IBOutlet weak var serviceFinishedLabel: UILabel!
    @IBOutlet weak var serviceDateLabel: UILabel!
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
