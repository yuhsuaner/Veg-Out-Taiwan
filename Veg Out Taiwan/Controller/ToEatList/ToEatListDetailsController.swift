//
//  ToEatListDetailsController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/27.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

enum ListType {
    
    case wantToGo
    
    case myFavorite
    
    case other
    
    var url: String {
        
        switch self {
            
        case .wantToGo:
            
            return "https://itunes.apple.com/search?term=business&kind=podcast&genreId=1321&country=TW&limit=15"
            
        case .myFavorite:
            
            return "https://itunes.apple.com/search?term=technology&kind=podcast&genreId=1318&country=TW&limit=15"
            
        case .other:
            
            return "https://itunes.apple.com/search?term=education&kind=podcast&genreId=1304&country=TW&limit=15"
        }
        
    }
    
    var listTitle: String {
        
        switch self {
        case .wantToGo:
            return "want 2 Go"
        case .myFavorite:
            return "My Favorite"
        case .other:
            return "Other"
        }
    }
}

class ToEatListDetailsController: UIViewController {

    // MARK: - Properties
    var bigTitle: String = ""
    
    private lazy var collectionView: UICollectionView = {
         
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         
         collectionView.translatesAutoresizingMaskIntoConstraints = false
                collectionView.register(ToEatListDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCell")
//         collectionView.showsHorizontalScrollIndicator = false
         collectionView.layer.cornerRadius = 15
         
         collectionView.backgroundColor = UIColor.W1
         
         collectionView.delegate = self
         collectionView.dataSource = self
         
         return collectionView
     }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
        
    }
    
    // MARK: - API
    fileprivate func fetchCategory() {
        
        APIService.shared.fetchCategoryAPI(urlLocation: url) { (podcast) in
            
            self.podcasts = podcast
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.backgroundColor = .W1
        
        navigationItem.title = "我的 To Eat List"
    }
    
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
    }
}

// MARK: - UICollectionViewDataSource
extension ToEatListDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? ToEatListDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.restaurantName.text = "HiHi"
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ToEatListDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Int((collectionView.frame.width - 40) / 2),
                      height: Int(collectionView.frame.width * 0.7))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
}

// MARK: - UICollectionViewDelegate
extension ToEatListDetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
