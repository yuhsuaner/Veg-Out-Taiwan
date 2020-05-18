//
//  CommentViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/30.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Cosmos
import YPImagePicker
import AVKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

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
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    private let imagePicker = UIImagePickerController()
    
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
    
    var selectedImages: [UIImage] = []
    
    // MARK: - ViewLifecyele
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureRatingView()
        
        viewStates = .empty
    }
    
    // MARK: - Helper
    
    func configureUI() {
        navigationController?.navigationBar.tintColor = .black
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
                                 user: User(uid: uid, username: userName, userImage: userImage, email: userMail))
        
        var userComment = UserComment(
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
        
        //Open Image Picker
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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

extension CommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let image: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        viewStates = .data([image])
        
        picker.dismiss(animated: true) { () -> Void in
            
            self.imageCollectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

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
