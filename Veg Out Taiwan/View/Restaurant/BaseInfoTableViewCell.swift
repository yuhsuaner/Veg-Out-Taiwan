//
//  BaseInfoTableViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

protocol InfoCellDelegate: class {
    
    func didTapAddToEatListButton(_ sender: UIButton)
    
    func didTapMakePhoneCallButton(_ sender: UIButton)
    
    func didTapNavigationButton(_ sender: UIButton)
}

class BaseInfoTableViewCell: UITableViewCell {
    
    weak var delegate: InfoCellDelegate?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var businessHoursLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var addCommentButton: UIButton!
    
    @IBAction func addToEatListAction(_ sender: UIButton) {
        delegate?.didTapAddToEatListButton(sender)
    }
    
    @IBAction func makePhoneCallAction(_ sender: UIButton) {
        delegate?.didTapMakePhoneCallButton(sender)
    }
    
    @IBAction func navigatedAction(_ sender: UIButton) {
        delegate?.didTapNavigationButton(sender)
    }
    
    var commentButtonAction: (() -> Void)?
    
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
