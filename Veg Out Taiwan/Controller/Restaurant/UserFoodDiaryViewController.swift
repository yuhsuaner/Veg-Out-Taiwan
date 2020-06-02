//
//  UserFoodDiaryViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/13.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Firebase

class UserFoodDiaryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    var currentPage = 0
    
    var restaurantComments: Comment?
    
    var userLikeComment: [String] = []
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func handleFollowAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var contentOfCommentTextView: UITextView!
    
    @IBOutlet weak var postDateLabel: UILabel!
    
    @IBOutlet weak var collectionButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func handleReplyTapped(_ sender: Any) {
    }
    
    @IBAction func handleLikeTapped(_ sender: Any) {
        
        if userLikeComment != [""] {
            // 拿出userLikeArray的值 與當前commentId比較
            for (index, value) in self.userLikeComment.enumerated() {
                print("Item \(index + 1): \(value)")
                
                guard let commentId = self.restaurantComments?.commentId else { return }
                
                if value != commentId {
                    self.createdTappedLikeComment()
                }
            }
            
        } else {
            self.createdTappedLikeComment()
        }
    }
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePageControl.numberOfPages = restaurantComments?.imageURL.count ?? 0
        imagePageControl.pageIndicatorTintColor = UIColor.W1
        imagePageControl.currentPageIndicatorTintColor = UIColor.O1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        configureUI()
        configureComment()
        fetchUserLike()
        getUserLikeArray()
    }
    
    // MARK: - API
    
    //拿到全部currentUser 按過Like的存進userLikeArray
    func getUserLikeArray() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("user-likes").child(uid).observeSingleEvent(of: .value) { snapshot in
            
            print(snapshot)
            print(snapshot.childrenCount)
            
            if snapshot.childrenCount != 0 {
                guard let dictionary = snapshot.value as? [String: Int] else { return }
                
                for keys in dictionary.keys {
                    
                    print(keys)
                    
                    print(type(of: keys))
                    
                    self.userLikeComment.append(keys)
                }
            }
        }
    }
    
    func fetchUserLike() {
        
        guard let comment = restaurantComments else { return }
        
        CommentService.shared.userLikeComment(comment) { didLike in
            guard didLike == true else { return }
            
            if comment.commentId == self.restaurantComments?.commentId {
                
                self.likeButton.setImage(UIImage(named: "like_filled"), for: .normal)
                
            }
        }
    }
    
    func createdTappedLikeComment() {
        
        guard let comment = restaurantComments else { return }
        
        CommentService.shared.likeComment(comment: comment) { [weak self] (err, ref) in
            guard let self = self else { return }

            self.restaurantComments?.didLike?.toggle()
            
            let like = self.restaurantComments!.didLike! ? self.restaurantComments!.likes + 1 : self.restaurantComments!.likes - 1
            
            self.restaurantComments!.likes = like
            
            self.setLikeButtonImage()
            
            let text = self.restaurantComments!.didLike! ? "Like" : "DisLike"
            
            VOTProgressHUD.showSuccess(text: text)
        }
    }
    
    func setLikeButtonImage() {
        
        guard let comment = restaurantComments else { return }
        
        if comment.didLike == true {
            DispatchQueue.main.async {
                self.likeButton.setImage(UIImage(named: "like_filled"), for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.likeButton.setImage(UIImage(named: "like"), for: .normal)
            }
        }
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
