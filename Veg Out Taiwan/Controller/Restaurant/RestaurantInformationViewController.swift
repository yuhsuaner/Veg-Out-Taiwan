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
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
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
            
            //            cell.delegate = self
            cell.commentButtonAction = { [unowned self] in
                
                guard let viewController = UIStoryboard(name: "Comment", bundle: nil).instantiateViewController(identifier: "Comment") as? CommentViewController else { return }
                
                self.show(viewController, sender: nil)
            }
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(toNextPage))
            cell.tapForMoreLabel.addGestureRecognizer(tap)
            
            cell.delegate = self
            
            return cell
            
        default:
            return UITableViewCell()
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
            return UIScreen.main.bounds.height / 4
        } else {
            return (UIScreen.main.bounds.height / 4) + 10
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RestaurantInformationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantHeaderImageViewCell", for: indexPath) as? RestaurantHeaderImageViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
}

// MARK: - CategoryRowDelegate
extension RestaurantInformationViewController: CategoryRowDelegate {
    
    func cellTapped() {
        
        guard let viewController = UIStoryboard(name: "UserFoodDiary", bundle: nil).instantiateViewController(identifier: "UserFoodDiary") as? UserFoodDiaryViewController else { return }
        
        show(viewController, sender: nil)
    }
}
