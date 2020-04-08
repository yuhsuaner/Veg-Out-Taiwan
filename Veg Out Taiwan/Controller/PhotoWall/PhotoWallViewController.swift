//
//  PhotoWallViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/7.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class PhotoWallViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.setBackgroundView()
        
//        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.W1!, .font: UIFont(name: "jf-openhuninn-1.0", size: 25)!]
        navigationItem.title = "你今天 Veg 了嗎？"
    }
}
