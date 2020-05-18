//
//  ProfileController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/10.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class ProfileController: UICollectionViewController {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerViewId = "HeaderView"
    
    // MARK: - Properties
    var user: User? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var userComment: [UserComment]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let votProvider = VOTProvider()
    
    var ref: DatabaseReference!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getUserComment()
    }
    
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
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewId)
        
        self.collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: - API
    func getUserComment() {
        
        ref = Database.database().reference()
        
        guard let user = Auth.auth().currentUser?.uid else { return }
        
        ref.child("user_comments").child("\(user)").observe(.value, with: { (snapshot) in
            
            var comment: [[String: Any]] = []
            
            for child in snapshot.children {
                
                print(child)
                
                print(type(of: child))
                
                guard let childSnapShot = child as? DataSnapshot,
                    let value = childSnapShot.value as? [String: Any] else {
                        
                        print(789)
                        
                        return
                }
                
                print(87979879)

                comment.append(value)
            }
            
            print(comment.count)
            
            guard let data = try? JSONSerialization.data(withJSONObject: comment, options: .fragmentsAllowed) else { return }
            
            do {

                let json = try JSONDecoder().decode([UserComment].self, from: data)
                print(json)

            } catch {
                print(error)
            }
            
        })
        
    }
    
}


// MARK: - UICollectionView DataSource/ Delegate
extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: headerViewId,
            for: indexPath) as? HeaderView else {
                
                fatalError("Cannot create header view")
        }
        
        headerView.user = user
        
        headerView.settingButton.addTarget(self, action: #selector(handleSetting), for: .touchUpInside)
        
        return headerView
    }
    
    @objc func handleSetting() {
        do {
            try Auth.auth().signOut()
            VOTProgressHUD.showSuccess(text: "登出")
        } catch let error {
            print(error.localizedDescription)
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let tab = appDelegate.window?.rootViewController as? MainTabViewController else { return }
        tab.selectedIndex = 0
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewController = UIStoryboard(name: "UserFoodDiary", bundle: nil).instantiateViewController(identifier: "UserFoodDiary") as? UserFoodDiaryViewController else { return }
        
        show(viewController, sender: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Int((collectionView.frame.width - 40) / 3), height: Int(collectionView.frame.width / 3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
}
