//
//  UserCommentWallViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class UserCommentWallViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
        
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(UserCommentWallCollectionViewCell.self, forCellWithReuseIdentifier: "UserCommentWallCollectionViewCell")
        
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        view.setBackgroundView()
        
        navigationItem.title = "評論分享"
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UserCommentWallViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCommentWallCollectionViewCell", for: indexPath) as? UserCommentWallCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .O1
        
        return cell
    }    
}

extension UserCommentWallViewController: UICollectionViewDelegateFlowLayout {
    
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
