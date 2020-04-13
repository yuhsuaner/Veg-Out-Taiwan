//
//  UserCommentWallViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class UserCommentWallViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.setBackgroundView()
        
        navigationItem.title = "評論分享"
    }
}
