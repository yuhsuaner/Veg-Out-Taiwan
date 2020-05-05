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
    
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: NSLayoutConstraint!
    
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
        
        imagePageControl.numberOfPages = 10
        imagePageControl.pageIndicatorTintColor = UIColor.W1
        imagePageControl.currentPageIndicatorTintColor = UIColor.O1
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        view.setBackgroundView()
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.W1!, .font: UIFont(name: "jf-openhuninn-1.0", size: 25)!]
        
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "VOT_back_Gray"), style: .plain, target: self, action: #selector(back(sender:)))
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "VOT_back_Gray"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
//    @objc func back(sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }
}

extension UserFoodDiaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.postImage.image = UIImage(named: "Pic\(indexPath.item)")
        
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
