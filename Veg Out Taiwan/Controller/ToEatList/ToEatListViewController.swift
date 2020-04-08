//
//  ToEatListViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/16.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class ToEatListViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.setBackgroundView()
        
        navigationItem.title = "我的 To Eat List"
    }
}
