//
//  RestaurantInfomationViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/5.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class RestaurantInfomationViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.setBackgroundView()
        
//        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.tintColor = .G1
    }
}
