//
//  HeaderView.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/10.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class HeaderView: UICollectionViewCell {
    
 // MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Pic2")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "jf-openhuninn-1.0", size: 24)
        label.textColor = .G2
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.addAttributeText(primaryText: "11", secondaryText: "評論")
        return label
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        label.addAttributeText(primaryText: "1000", secondaryText: "粉絲")
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.addAttributeText(primaryText: "1M", secondaryText: "追蹤中")
        return label
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Setting"), for: .normal)

        return button
    }()
    
// MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.7
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 20
        outerView.layer.cornerRadius = 100/2
        self.contentView.addSubview(outerView)
        outerView.anchor(top: topAnchor, left: self.leftAnchor, paddingTop: 12, paddingLeft: 40, width: 100, height: 100)
        
        outerView.addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: self.leftAnchor, paddingTop: 12, paddingLeft: 40, width: 100, height: 100)
        
        profileImageView.layer.cornerRadius = 100/2
        profileImageView.layer.masksToBounds = true
        
        renderSettingButton()
        renderUsernameLabel()
        renderInfoLabelGroup()
        
        fetchUser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Helper
    
    fileprivate func renderSettingButton() {
        addSubview(settingButton)
        settingButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 15, width: 25, height: 25)
    }
    
    fileprivate func renderUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 50, paddingLeft: 20, paddingRight: 10, height: 30)
    }
    
    fileprivate func renderInfoLabelGroup() {
        let stackView = UIStackView(arrangedSubviews: [postLabel, followerLabel, followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 12, paddingRight: 12, height: 80)
    }
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid  else { return }
        
        UserService.shared.fetchUser(uid: uid) { user in
            
            self.user = user
        }
    }
    
    func configure() {
        guard let user = user else { return }
        
        profileImageView.loadImage(user.profileImageUrl, placeHolder: #imageLiteral(resourceName: "VOT tab bar icons-11"))
        
        usernameLabel.text = user.userName
    }
}

extension UILabel {
    func addAttributeText(primaryText: String, secondaryText: String) {
        
        let attributedText = NSMutableAttributedString(string: "\(primaryText)\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.G2!, NSAttributedString.Key.font: UIFont(name: "jf-openhuninn-1.0", size: 22)!])
                
        attributedText.append(NSAttributedString(string: secondaryText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.G1!, NSAttributedString.Key.font: UIFont(name: "jf-openhuninn-1.0", size: 12)!]))
    
        self.attributedText = attributedText
        self.numberOfLines = 0
        self.textAlignment = NSTextAlignment.center
    }
}
