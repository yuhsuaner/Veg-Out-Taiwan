//
//  MainTabViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/29.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase

class MainTabViewController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        
//        tabBar.barTintColor = .W1
        
//        authenicateAndConfigureUI()
    }
    
    // MARK: - API
//    func authenicateAndConfigureUI() {
//        let isLoggedIn = Auth.auth().currentUser != nil
//
//        if !isLoggedIn {
//            DispatchQueue.main.async {
//                let nav = UINavigationController(rootViewController: LogInViewController())
//
//                nav.modalPresentationStyle = .fullScreen
//
//                self.present(nav, animated: true)
//            }
//        }
//        else {
//            configureViewControllers()
//
//            UserService.shared.fetchUser { user in
//                let _ = (self.viewControllers ?? []).map { (viewController) -> Void in
//                    guard let nav = viewController as? UINavigationController else {
//                        return
//                    }
//
//                    guard let vc = nav.viewControllers.first as? RootViewController else {
//                        return
//                    }
//
//                    vc.currentUser = user
//
//                    return
//                }
//            }
//        }
//    }
//
//    func logOut() {
//
//        do {
//            try Auth.auth().signOut()
//        } catch let error {
//            print(error)
//        }
//    }
    
    
    // MARK: - Helpers
    
    func setupViewController() {
        
        viewControllers = [
            
            generateNavigationController(for: MapViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-2"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-1")),
            
            generateNavigationController(for: PhotoWallViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-7"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-8")),
            
            generateNavigationController(for: ToEatListViewController(), image: #imageLiteral(resourceName: "VOT tab bar icons-4"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-5")),
            
            generateNavigationController(for: ProfileController(), image: #imageLiteral(resourceName: "VOT tab bar icons-10"), selectedImage: #imageLiteral(resourceName: "VOT tab bar icons-11"))
        ]
    }
    
    fileprivate func generateNavigationController(for rootViewConroller: UIViewController, image: UIImage, selectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewConroller)
        
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
        
        navController.navigationBar.barTintColor = UIColor.W1
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "jf-openhuninn-1.0", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.G2!]
        
        return navController
    }
    
}
