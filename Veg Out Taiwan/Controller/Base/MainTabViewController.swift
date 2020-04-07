//
//  MainTabViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/29.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        
        tabBar.barTintColor = UIColor(named: "CreamyWhite")
        tabBar.unselectedItemTintColor = UIColor.systemPink
    }
    
    // MARK: - Helpers
    
    func setupViewController() {
        
        viewControllers = [
            
            generateNavigationController(for: MapViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-2"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-3")),
            
            generateNavigationController(for: PhotoWallViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-7"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-8")),
            
            generateNavigationController(for: ToEatListViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-4"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-5")),
            
            generateNavigationController(for: ProfileViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-10"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-11"))
        ]
    }
    
    fileprivate func generateNavigationController(for rootViewConroller: UIViewController, image: UIImage, selectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewConroller)
        rootViewConroller.navigationItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
        
        return navController
    }
    
}
