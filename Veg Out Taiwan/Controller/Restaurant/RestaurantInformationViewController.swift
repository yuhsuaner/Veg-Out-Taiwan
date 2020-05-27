//
//  RestaurantInfomationViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/5.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase

class RestaurantInformationViewController: UIViewController {
    
    // MARK: - Properties
    let votProvider = VOTProvider()
    
    let  restaurant: Restaurant
    
    var comments: [Comment] = []
    
    var wnatToGo: [WantToGo] = []
    
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
    
    // MARK: - API
    func createWantToGo() {
        
        guard
            let uid = Auth.auth().currentUser?.uid
            else {
                return
                
        }
        
        votProvider.addWantToGoList(uid: uid, restaurant: restaurant) { [weak self] result in
            
            guard let self = self else { return }
            
            guard result else {
                return
            }
            
            self.wnatToGo.append(WantToGo(restaurant: [self.restaurant]))
            
            DispatchQueue.main.async {
                
                VOTProgressHUD.showSuccess()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
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
        
        controller.restaurantComments = comments
        
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
        
        cell.topImageView.loadImage(restaurant.imageURL[0], placeHolder: UIImage.init(named: "non_photo-1"))
        
        return cell
    }
}

// MARK: - InfoCellDelegate
extension RestaurantInformationViewController: InfoCellDelegate {
    
    func didTapAddToEatListButton(_ sender: UIButton) {
        
        //        self.openAlert(title: "!",
        //                       message: "正在開發中🚧",
        //                       alertStyle: .alert,
        //                       actionTitles: ["OK"],
        //                       actionStyles: [.default],
        //                       actions: [{_ in print("okay click")}]
        //        )
        
        self.openAlert(title: "加入收藏清單",
                       message: "add your message",
                       alertStyle: .actionSheet,
                       actionTitles: ["Want 2 Go", "My Favorite", "Other", "取消"],
                       actionStyles: [.default, .default, .default, .cancel],
                       actions: [
                        { _ in
                            self.createWantToGo()
                        },
                        
                        { _ in
                            print(123)
                        },
                        
                        { _ in
                            
                            print(456)
                        },
                        
                        { _ in
                            print("cancel click")
                        }
        ])
    }
    
    func didTapMakePhoneCallButton(_ sender: UIButton) {
        
        let phoneNumber = restaurant.phone.replacingOccurrences(of: " ", with: "")
        guard let number = URL(string: "tel://" + "\(phoneNumber)") else { return }
        UIApplication.shared.open(number)
    }
    
    func didTapNavigationButton(_ sender: UIButton) {
        
        let latitude = restaurant.coordinates.latitude
        
        let longitude = restaurant.coordinates.longitude
        
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
        }
        
    }
    
}
