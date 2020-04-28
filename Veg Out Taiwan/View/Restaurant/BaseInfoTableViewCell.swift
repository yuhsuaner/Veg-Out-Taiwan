//
//  BaseInfoTableViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class BaseInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var businessHoursLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
