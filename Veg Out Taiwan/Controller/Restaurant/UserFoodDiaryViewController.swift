//
//  UserFoodDiaryViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/13.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class UserFoodDiaryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    var currentPage = 0
    
    var restaurantComments: Comment?
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func handleFollowAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var contentOfCommentTextView: UITextView!
    
    @IBOutlet weak var postDateLabel: UILabel!
    
    @IBOutlet weak var collectionButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func handleLeaveMessage(_ sender: Any) {
    }
    @IBAction func handleAddFavorite(_ sender: Any) {
    }
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureComment()
        
        imagePageControl.numberOfPages = restaurantComments?.imageURL.count ?? 0
        imagePageControl.pageIndicatorTintColor = UIColor.W1
        imagePageControl.currentPageIndicatorTintColor = UIColor.O1
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        view.setBackgroundView()
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.W1!, .font: UIFont(name: "jf-openhuninn-1.0", size: 25)!]
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "VOT_back_Gray"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    func configureComment() {
        
        self.restaurantNameLabel.text = restaurantComments?.restaurantName
        userNameLabel.text = restaurantComments?.user.userName
        userImageView.loadImage(restaurantComments?.user.profileImageUrl, placeHolder: #imageLiteral(resourceName: "VOT tab bar icons-12"))
        contentOfCommentTextView.text = restaurantComments?.commentText
    }
}

extension UserFoodDiaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let image = restaurantComments?.imageURL else { return 0 }
        
        return image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.postImage.loadImage(restaurantComments?.imageURL[indexPath.row], placeHolder: #imageLiteral(resourceName: "non_photo-2"))
        
        return cell
    }
}

extension UserFoodDiaryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x / pageWidth))
        self.imagePageControl.currentPage = self.currentPage
    }
}
