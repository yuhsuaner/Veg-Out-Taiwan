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
    
    case data([String])
}

class CommentViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    private let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var enterButton: UIButton!
    
    var viewStates: ViewState = .empty {
        
        didSet {
            
            switch viewStates {
                
            case .empty: datas = []
                
            case .data(let data): datas = data
                
            }
            
            imageCollectionView.reloadData()
        }
    }
    
    var datas: [String] = []
    
    // MARK: - ViewLifecyele
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        viewStates = .data(["12", "24"])
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
    
}

// MARK: - UICollectionViewDataSource
extension CommentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CommentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch viewStates {
        case .empty:
            //Open Image Picker
            present(imagePicker, animated: true, completion: nil)
        default: break
        }
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
