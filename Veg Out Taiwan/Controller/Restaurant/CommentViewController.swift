//
//  CommentViewController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/30.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import Cosmos

enum ViewState {
    
    case empty
    
    case data([UIImage])
}

class CommentViewController: UIViewController {
    
    // MARK: - Properties
    
    var userComment = [Comment]()
    
    let votProvider = VOTProvider()
    
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
                
            case .empty: datas = [#imageLiteral(resourceName: "Add_Photo")]
                
            case .data(let data):
                
                switch oldValue {
                    
                case .empty: datas = data
                    
                case .data: datas.append(contentsOf: data)
                    
                }
            }
            
            imageCollectionView.reloadData()
        }
    }
    
    var datas: [UIImage] = []
    
    // MARK: - ViewLifecyele
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        viewStates = .empty
    }
    
    // MARK: - Helper
    
    func configureUI() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "我要評論"
        
        commentTextView.layer.cornerRadius = 5
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
    
    func configureRatingView() {
        
        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        ratingView.didTouchCosmos = { rating in
            
        }
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        ratingView.didFinishTouchingCosmos = { rating in
            
        }
    }
    
    // MARK: - selectors
    @objc func enterButtonTapped() {
        guard
            let restaurantName = restaurantNameLabel.text,
            let commentText = commentTextView.text
            else { return }
        
        let newComment = Comment(restaurantName: restaurantName, imageURL: [""], rating: "", commentText: commentText)
        
        votProvider.createComment(newComment: newComment) { result in
            guard result else {
                return
            }
            self.userComment.append(newComment)
            print(newComment)
            
//            DispatchQueue.main.async {
//
//                self.navigationController?.popViewController(animated: true)
//            }
        }
    }
}

//    @objc func enterButtonTapped() {
//
//        VOTProvider.shared.createComment(commentText: "happy day is Monday", imageURL: ["hnfjenfl", "fendjlf"], reating: 4.3, restaurantName: "POPOPOO") { (err) in
//
//            if let err = err {
//                print("Failed to create post object", err)
//                return
//            }
//
//            print("Finished post comment")
//        }
//    }

// MARK: - UICollectionViewDataSource
extension CommentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.postImage.image = datas[indexPath.item]
        
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
