//
//  AppDelegate.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/3/15.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // swiftlint:disable force_cast
    static let shared = UIApplication.shared.delegate as! AppDelegate
    // swiftlint:enable force_cast
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabViewController()
        window?.makeKeyAndVisible()
        
        // Remove TabBar Top Line
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().shadowImage = nil
        // Remove NavigationBar Under Line
        UINavigationBar.appearance().shadowImage = UIImage()
        
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey("AIzaSyCLkSUXcmNSdFZZEBybhsiTGz3dwoY1zBQ")
        GMSPlacesClient.provideAPIKey("AIzaSyCLkSUXcmNSdFZZEBybhsiTGz3dwoY1zBQ")
        
        return true
    }
    
}
