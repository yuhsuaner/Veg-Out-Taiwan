//
//  BaseInfoTableViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

//protocol AddCommentDelegate: class {
//    func goToWriteComment()
//}

class BaseInfoTableViewCell: UITableViewCell {
    
//    weak var delegate: AddCommentDelegate?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var businessHoursLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var addCommentLabel: UIButton!
    
    var commentButtonAction : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addCommentLabel.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func commentButtonTapped() {
        
        commentButtonAction?()
    }

}
