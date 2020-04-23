//
//  MainTabViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/29.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        delegate = self
        
        //        tabBar.barTintColor = .W1
    }
    
    // MARK: - Helpers
    
    func setupViewController() {
        
        viewControllers = [
            
            generateNavigationController(for: MapViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-2"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-3")),
            
            generateNavigationController(for: PhotoWallViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-7"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-8")),
            
            generateNavigationController(for: ToEatListViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-4"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-5")),
            
            generateNavigationController(for: ProfileController(), image: #imageLiteral(resourceName: "VOT tab bar icons-10"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-11"))
        ]
    }
    
    fileprivate func generateNavigationController(for rootViewConroller: UIViewController, image: UIImage, selectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewConroller)
        
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 8, left: 0, bottom: -5, right: 0)
        
        navController.navigationBar.barTintColor = UIColor.W1
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "jf-openhuninn-1.0", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.G2!]
        
        return navController
    }
    
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let navVC = viewController as? UINavigationController,
            navVC.viewControllers.first is ProfileController else {
                return true
        }
        
        guard Auth.auth().currentUser != nil else {
            
            if let authVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "LogInVC") as? LogInViewController {
                
                authVC.modalPresentationStyle = .overCurrentContext
                
                present(authVC, animated: false, completion: nil)
            }
            
            return false
        }
        return true
    }
}
