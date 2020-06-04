//
//  CommentViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/30.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import YPImagePicker

enum ViewState {

    case empty

    case data([UIImage])
}

class CommentViewController: UIViewController {
    
    // MARK: - Properties
    var user = [User]()
    
    var userComment = [UserComment]()
    
    var comment = [Comment]()
    
    let votProvider = VOTProvider()
    
    var currentStar = 3.7
    
    var selectedImages: [UIImage] = []
    
    var selectedItems = [YPMediaItem]()
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var enterButton: UIButton! {
        didSet {
            enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        }
    }
    
        var viewStates: ViewState = .empty {
    
            didSet {
    
                switch viewStates {
    
                case .empty: selectedImages = [#imageLiteral(resourceName: "Add_Photo")]
    
                case .data(let data):
    
                    switch oldValue {
    
                    case .empty: selectedImages = data
    
                    case .data: selectedImages.append(contentsOf: data)
    
                    }
                }
    
                imageCollectionView.reloadData()
            }
        }
    
    // MARK: - ViewLifecyele
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureRatingView()
        
        viewStates = .empty
    }
    
    // MARK: - Helper
    
    func configureUI() {
        navigationItem.title = "我要評論"
        
        imageCollectionView.backgroundColor = .clear
        
        commentTextView.layer.cornerRadius = 5
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
        commentTextView.text = "這裏輸入留言..."
        commentTextView.textColor = UIColor.lightGray
        commentTextView.returnKeyType = .done
        commentTextView.delegate = self
    }
    
    func configureRatingView() {
        
        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        ratingView.didTouchCosmos = { rating in
            
            self.currentStar = Double(rating)
            
            print(rating)
        }
    }
    
    // MARK: - selectors
    
    let group = DispatchGroup()
    
    @objc func enterButtonTapped() {
        
        VOTProgressHUD.show()
        
        if commentTextView.text == "這裏輸入留言..." || commentTextView.text == "" {
            
            VOTProgressHUD.showFailure(text: "尚未輸入任何文字喔～ ")
            
            return
        }
        
        guard
            let restaurantName = restaurantNameLabel.text,
            let commentText = commentTextView.text
            else { return }
        
        guard
            let userName = UserDefaults.standard.value(forKey: "Username") as? String,
            let userImage = UserDefaults.standard.value(forKey: "UserImage") as? String,
            let userMail = UserDefaults.standard.value(forKey: "UserMail") as? String,
            let uid = UserDefaults.standard.value(forKey: "UID") as? String
            else { return }
        
        var newComment = Comment(restaurantName: restaurantName,
                                 imageURL: [],
                                 rating: currentStar,
                                 commentText: commentText,
                                 user: User(uid: uid, username: userName, userImage: userImage, email: userMail),
                                 didLike: false)
        
        var userComment = UserComment(restaurantName: newComment.restaurantName,
                                      imageURL: [],
                                      rating: newComment.rating,
                                      commentText: newComment.commentText)
        
        //seletedImages upload firestore
        for image in selectedImages {
            
            group.enter()
            
            ImageService.shared.saveImage(image: image) { (error, url) in
                
                if let error = error {
                    print(error.localizedDescription)
                    VOTProgressHUD.showFailure(text: "上傳失敗")
                    return
                }
                
                guard let url = url else { return }
                //[String] 放到 newComment 裡面的 imageURL
                newComment.imageURL.append(url)
                userComment.imageURL.append(url)
                
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            //Upload comment 到 realtime database
            self.votProvider.createComment(newComment: newComment) { result in
                guard result else {
                    return
                }
                self.comment.append(newComment)
                
                DispatchQueue.main.async {
                    
                    VOTProgressHUD.showSuccess()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            self.votProvider.createComment(uid: uid, comment: newComment, userComment: userComment) { result in
                
                guard result else {
                    return
                }
                
                self.userComment.append(userComment)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CommentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.postImage.image = selectedImages[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CommentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedImages.removeAll()
        
        let picker = YPImagePicker(configuration: configuration())
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                   
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                _ = items.map { print("🧀 \($0)") }
                
                self.selectedItems = items

                for item in items {
                    
                    switch item {
                        
                    case .photo(let image):
                        
                        let imageV = image.image
                        
                        self.selectedImages.append(imageV)
                        
                    default:
                        print("Default Case")
                    }
                }
                
                picker.dismiss(animated: true, completion: {
                    self.viewStates = .data(self.selectedImages)
                    self.imageCollectionView.reloadData()
                })
            }
        
            present(picker, animated: true, completion: nil)
    }
        
    func configuration() -> YPImagePickerConfiguration {
        
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.wordings.libraryTitle = "我的相簿"
        config.wordings.cameraTitle = "相機"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.maxCameraZoomFactor = 2.0
        config.library.maxNumberOfItems = 10
        config.gallery.hidesRemoveButton = false
        config.library.preselectedItems = selectedItems
        return config
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imageCollectionView.frame.width,
                      height: imageCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

// MARK: - UITextViewDelegate
extension CommentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentTextView.text == "這裏輸入留言..." {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.DG
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentTextView.text == "" {
            commentTextView.text = "這裏輸入留言..."
            commentTextView.textColor = UIColor.lightGray
        }
    }
}
