//
//  PhotoWallViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/7.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase
import collection_view_layouts

class PhotoWallViewController: UIViewController {
    
    // MARK: - Properties
    
    var imageList: [String] = []
    
    var votProvider = VOTProvider()
    
    private func getLayout() -> UICollectionViewLayout {
        
        let layout = InstagramLayout()
        layout.delegate = self
        layout.contentPadding = ItemsPadding(horizontal: 4, vertical: 4)
        layout.cellsPadding = ItemsPadding(horizontal: 4, vertical: 4)
        layout.gridType = .regularPreviewCell
        return layout
    }
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoWallCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchImageComment()
    }
    
    // MARK: - API
    
    func fetchImageComment() {
        
        let customerRef = Database.database().reference().child("comments")
        
        customerRef.observeSingleEvent(of: .value, with: { snapshot in
            
            for commentsChild in snapshot.children {
                
                guard let childSnap = commentsChild as? DataSnapshot else { return }
                
                let imageSnap = childSnap.childSnapshot(forPath: "imageURL")
                
                for imageURL in imageSnap.children {
                    
                    guard let snap = imageURL as? DataSnapshot else { return }
                    guard let image = snap.value as? String else { return }
                    self.imageList.append(image)
                }
            }

            self.collectionView.reloadData()
        })

    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        view.setBackgroundView()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.W1!, .font: UIFont(name: "jf-openhuninn-1.0", size: 25)!]
        navigationItem.title = "你今天 Veg 了嗎？"
    }
}

// MARK: - UICollectionView DataSource
extension PhotoWallViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath) as? PhotoWallCollectionViewCell else { return UICollectionViewCell()}
        
        cell.postImageView.loadImage(imageList[indexPath.row], placeHolder: #imageLiteral(resourceName: "non_photo-4"))
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension PhotoWallViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let viewController = UIStoryboard(name: "UserFoodDiary", bundle: nil).instantiateViewController(identifier: "UserFoodDiary") as? UserFoodDiaryViewController else { return }
        
        show(viewController, sender: nil)
    }
}

// MARK: - LayoutDelegate
extension PhotoWallViewController: LayoutDelegate {
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 200)
    }
}
