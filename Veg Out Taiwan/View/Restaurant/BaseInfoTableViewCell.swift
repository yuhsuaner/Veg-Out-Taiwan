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
    
    @IBOutlet weak var addCommentButton: UIButton!
    
    @IBOutlet weak var addToMyEatListButton: UIButton!
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var navigationButton: UIButton!
    
    var commentButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addCommentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func commentButtonTapped() {
        
        commentButtonAction?()
    }

}
