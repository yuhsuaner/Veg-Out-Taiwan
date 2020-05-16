//
//  RestaurantInfomationViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/5.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class RestaurantInformationViewController: UIViewController {
    
    // MARK: - Properties
    
    let  restaurant: Restaurant
    
    var comments: [Comment] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
    
    init?(coder: NSCoder, restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        navigationController?.navigationBar.tintColor = .W1
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension RestaurantInformationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaseInfoTableViewCell", for: indexPath) as? BaseInfoTableViewCell else { return UITableViewCell() }
            
            cell.restaurantNameLabel.text = restaurant.restaurantName
            cell.addressLabel.text = restaurant.address
            cell.ratingLabel.text = "★ \(restaurant.rating)"
            
            cell.commentButtonAction = { [unowned self] in
                
                guard let title = cell.restaurantNameLabel.text else { return }
                
                let viewController = UIStoryboard(name: "Comment", bundle: nil).instantiateViewController(
                    identifier: "Comment",
                    creator: { coder in
                        
                        CommentViewController(coder: coder)
                })
                
                viewController.loadViewIfNeeded()
                
                viewController.restaurantNameLabel.text = title
                
                self.show(viewController, sender: self)
            }
            
            cell.delegate = self
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(toNextPage))
            cell.tapForMoreLabel.addGestureRecognizer(tap)
            
            cell.updateData(restaurantName: restaurant.restaurantName)
            
            //            cell.delegate = self
            cell.didpassCommentData = { [weak self] comment in
                
                let viewController = UIStoryboard(name: "UserFoodDiary", bundle: nil).instantiateViewController(
                    identifier: "UserFoodDiary",
                    creator: { coder in
                        
                        UserFoodDiaryViewController(coder: coder)
                })
                
                viewController.restaurantComments = comment
                
                self?.show(viewController, sender: self)
            }
            
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    // MARK: - Selector
    @objc func toNextPage() {
        
        let controller = UserCommentWallViewController()
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension RestaurantInformationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height / 4 + 10
        } else {
            return (UIScreen.main.bounds.height / 4) + 5
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RestaurantInformationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantHeaderImageViewCell", for: indexPath) as? RestaurantHeaderImageViewCell else { return UICollectionViewCell() }
        
        cell.topImageView.loadImage(restaurant.imageURL[0], placeHolder: #imageLiteral(resourceName: "Pic0"))
        
        return cell
    }
}

// MARK: - InfoCellDelegate
extension RestaurantInformationViewController: InfoCellDelegate {
    
    func didTapAddToEatListButton(_ sender: UIButton) {
        
        self.openAlert(title: "!",
                       message: "正在開發中🚧",
                       alertStyle: .alert,
                       actionTitles: ["OK"],
                       actionStyles: [.default],
                       actions: [{_ in print("okay click")}]
        )
    }
    
    func didTapMakePhoneCallButton(_ sender: UIButton) {
        
        let phoneNumber = restaurant.phone.replacingOccurrences(of: " ", with: "")
        guard let number = URL(string: "tel://" + "\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
    
    func didTapNavigationButton(_ sender: UIButton) {
        
    }
    
}
