//
//  Utilies.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/23.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class Utilies {
    
    func inputContainView(withImage images: UIImage, textFiled: UITextField) -> UIView {
        
        let view = UIView()
        let image = UIImageView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        image.image = images
        view.addSubview(image)
        image.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                     paddingLeft: 8, paddingBottom: 8)
        image.setDimensions(width: 24, height: 24)
        
        view.addSubview(textFiled)
        textFiled.anchor(left: image.rightAnchor, bottom: view.bottomAnchor,
                         right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let divderView = UIView()
        divderView.backgroundColor = .white
        view.addSubview(divderView)
        divderView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                          right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholer placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .W1
        textField.font = UIFont(name: "jf-openhuninn-1.0", size: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textField
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String ) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
