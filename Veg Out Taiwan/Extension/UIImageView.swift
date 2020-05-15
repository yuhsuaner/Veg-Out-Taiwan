//
//  UIImageView.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWith(_ linkString: String?) {
        guard let linkString = linkString,
            let url = URL(string: linkString) else { return }
        self.kf.setImage(with: url)
        
    }
    
    func setImageWith(url: URL?) {
        guard let url = url else { return  }
        self.kf.setImage(with: url)
    }
}
