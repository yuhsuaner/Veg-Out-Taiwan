//
//  ToEatListDetailsController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/27.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase

enum ListType {
    
    case wantToGo
    
    case myFavorite
    
    case other
    
    var listName: String {
        
        switch self {
            
        case .wantToGo:
            
            return "want2Go"
            
        case .myFavorite:
            
            return "myFavorite"
            
        case .other:
            
            return "other"
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
    
    var listName: String = ""
    
    var restaurant: [Restaurant] = []
    
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
        fetchToEatList(listName: listName)
        
    }
    
    // MARK: - API
    
    fileprivate func fetchToEatList(listName: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let listRef = Database.database().reference().child("toEatList").child(uid).child(listName)
        
        listRef.observeSingleEvent(of: .value, with: { snapshot in

            var restaurant: [[String: Any]] = []
            
            for child in snapshot.children {
                
                guard let childSnap = child as? DataSnapshot else { return }
                
                guard let value = childSnap.value as? [String: Any] else { return }
                restaurant.append(value)

            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: restaurant, options: .fragmentsAllowed) else { return }
            
            do {

                let json = try JSONDecoder().decode([Restaurant].self, from: data)
                
                self.restaurant = json
                
            } catch {
                print(error)
            }

            self.collectionView.reloadData()
        })
    }
    
    // MARK: - Helper

    func configureUI() {
        
        view.backgroundColor = .W1
        
        navigationItem.title = bigTitle
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
        
        return restaurant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? ToEatListDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.restaurantName.text = restaurant[indexPath.row].restaurantName
        cell.cellImageView.loadImage(restaurant[indexPath.row].imageURL[0], placeHolder: #imageLiteral(resourceName: "non_photo-4"))
        
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
        
        let data = restaurant[indexPath.item]
        
        let viewController = UIStoryboard(name: "RestaurantInformation", bundle: nil).instantiateViewController(
            identifier: "RestaurantInformation",
            creator: { coder in
                RestaurantInformationViewController(coder: coder, restaurant: data)
        })
        
        show(viewController, sender: self)
    }
}
