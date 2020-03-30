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

    }
    
    // MARK: - Helpers
    
    func setupViewController() {
        
        viewControllers = [
            
            generateNavigationController(for: MapViewController(), image: #imageLiteral(resourceName: "Map")),
            
            generateNavigationController(for: ToEatListViewController(), image: #imageLiteral(resourceName: "EatList")),
         
//            generateNavigationController(for: LibraryController.storyboardInstance()!, title: "Library", image: #imageLiteral(resourceName: "playlist-3")),
            
            generateNavigationController(for: ProfileViewController(), image: #imageLiteral(resourceName: "Profile"))
        ]
    }
    
    fileprivate func generateNavigationController(for rootViewConroller: UIViewController, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewConroller)
        rootViewConroller.navigationItem.title = title
//        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
}
