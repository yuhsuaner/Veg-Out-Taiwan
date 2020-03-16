//
//  STTabBarViewController.swift
//  STYLiSH
//
//  Created by WU CHIH WEI on 2019/2/11.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

private enum Tab {
    
    case veganMap
    
    case toEatList
    
    case profile
    
    func controller() -> UIViewController {
        
        var controller: UIViewController
        
        switch self {
            
        case .veganMap: controller = UIStoryboard.veganMap.instantiateInitialViewController()!
            
        case .toEatList: controller = UIStoryboard.toEatList.instantiateInitialViewController()!
            
        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!
        }
        
        controller.tabBarItem = tabBarItem()
        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
        
        return controller
    }
    
    func tabBarItem() -> UITabBarItem {
        
        switch self {
            
        case .veganMap:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.pin),
                selectedImage: UIImage.asset(.pin)
            )
            
        case .toEatList:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.menu),
                selectedImage: UIImage.asset(.menu)
            )
            
        case .profile:
            return UITabBarItem(
                title: nil,
                image: UIImage.asset(.user),
                selectedImage: UIImage.asset(.user)
            )
        }
    }
}

class STTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.veganMap, .toEatList, .profile]
    
//    var trolleyTabBarItem: UITabBarItem!
    
    var orderObserver: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({ $0.controller() })
        
        //        trolleyTabBarItem = viewControllers?[2].tabBarItem
        //
        //        trolleyTabBarItem.badgeColor = .brown
        
        //        orderObserver = StorageManager.shared.observe(
        //            \StorageManager.orders,
        //            options: .new,
        //            changeHandler: { [weak self] _, change in
        //
        //                guard let newValue = change.newValue else { return }
        //
        //                if newValue.count > 0 {
        //
        //                    self?.trolleyTabBarItem.badgeValue = String(newValue.count)
        //
        //                } else {
        //
        //                    self?.trolleyTabBarItem.badgeValue = nil
        //                }
        //            }
        //        )
        
        //        StorageManager.shared.fetchOrders()
        
        delegate = self
    }
    
    // MARK: - UITabBarControllerDelegate
    
    //    func tabBarController(
    //        _ tabBarController: UITabBarController,
    //        shouldSelect viewController: UIViewController
    //    ) -> Bool {
    //
    //        guard let navVC = viewController as? UINavigationController,
    //              navVC.viewControllers.first is ProfileViewController
    //        else { return true }
    //
    //        guard KeyChainManager.shared.token != nil else {
    //
    //            if let authVC = UIStoryboard.auth.instantiateInitialViewController() {
    //
    //                authVC.modalPresentationStyle = .overCurrentContext
    //
    //                present(authVC, animated: false, completion: nil)
    //            }
    //
    //            return false
    //        }
    //
    //        return true
    //    }
}
