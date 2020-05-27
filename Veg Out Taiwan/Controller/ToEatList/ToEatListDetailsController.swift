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
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.backgroundColor = UIColor.W1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
        
    }
    
    // MARK: - API
//    fileprivate func fetchCategory() {
//        
//        APIService.shared.fetchCategoryAPI(urlLocation: url) { (podcast) in
//            
//            self.podcasts = podcast
//            self.collectionView.reloadData()
//        }
//    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.backgroundColor = .W1
        
        navigationItem.title = "我的 To Eat List"
    }
    
    func configureTableView() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        collectionView.register(ToEatListDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "DetailsCell")
        collectionView.dataSource = self
    }
}

extension ToEatListDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? ToEatListDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .G2
        
        return cell
    }
    
}
