//
//  Background.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/7.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

extension UIView {
    
    func setBackgroundView() {
        
         let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
         backgroundImage.image = UIImage(named: "background")
         backgroundImage.contentMode = .scaleAspectFill
         self.insertSubview(backgroundImage, at: 0)
        
    }
}
