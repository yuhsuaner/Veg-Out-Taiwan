//
//  ProfileController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/10.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileController: UICollectionViewController {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerViewId = "HeaderView"
    
    // MARK: - Properties
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    // initialized with a non-nil layout parameter
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureCollectionView() {
        
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        collectionView.backgroundColor = .white
        
//        let headerNib = UINib(nibName: "HeaderView", bundle: nil)
//        self.collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewId)
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewId)
        
        self.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerViewId,
            for: indexPath) as? HeaderView else {
                
                fatalError("Cannot create header view")
        }
        
        headerView.settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        
        return headerView
    }
    
    @objc func handleSetting() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let tab = appDelegate.window?.rootViewController as? MainTabViewController else { return }
        tab.selectedIndex = 0
        
//
//        if let authVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "LogInVC") as? LogInViewController {
//            
//
//            
//            authVC.modalPresentationStyle = .overCurrentContext
//            
//            present(authVC, animated: false, completion: nil)
//        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 25
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 40) / 3, height: collectionView.frame.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
}
