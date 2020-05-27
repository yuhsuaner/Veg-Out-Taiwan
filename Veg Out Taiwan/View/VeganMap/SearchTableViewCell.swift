//
//  SearchTableViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/18.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "我家"
        label.textColor = .G1
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "台北市信義區基隆路四段10號"
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                     paddingTop: 2, paddingLeft: 2, paddingBottom: 2, paddingRight: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
