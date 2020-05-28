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
    
    // MARK: - Properties
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
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addCommentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Selector
    @objc func commentButtonTapped() {
        
        commentButtonAction?()
    }
    
    // MARK: - Helper
    func getToday(_ bussinessHour: Restaurant) {
        
        // 設定日期顯示格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        // 取得現在日期資訊
        let timeString = dateFormatter.string(from: Date())
        
        if timeString == "Monday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[0])"
        }
        
        if timeString == "Tuesday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[1])"
        }
        
        if timeString == "Wednesday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[2])"
        }
        
        if timeString == "Thursday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[3])"
        }
        
        if timeString == "Firday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[4])"
        }
        
        if timeString == "Saturday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[5])"
        }
        
        if timeString == "Sunday" {
            businessHoursLabel.text = "營業時間: \(bussinessHour.bussinessHours[6])"
        }
        
    }

}
