//
//  CommentTableViewCell.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/12.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var restaurantName = ""
    
    var restaurantComments: [Comment] = []
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var tapForMoreLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CategoryRowDelegate?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.layer.cornerRadius = 15
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateData(restaurantName: String) {
        
        self.restaurantName = restaurantName
        
        getCommentfromFirebase()
    }
    // MARK: - API
    
    func getCommentfromFirebase() {

        ref = Database.database().reference()
        ref.child("comment_user").queryOrdered(byChild: "restaurantName").queryEqual(toValue: self.restaurantName).observe(.value, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: [String: Any]] else { return }
            
            guard let data = try? JSONSerialization.data(withJSONObject: Array(dictionary.values), options: .fragmentsAllowed) else { return }
            
            do {
                
                let json = try JSONDecoder().decode([Comment].self, from: data)
                self.restaurantComments = json
                
            } catch {
                print(error)
            }
        })
    }
}

extension CommentTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell", for: indexPath) as? CommentCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderColor = UIColor.G1?.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("DidSelect: CommentCollectionViewCell")
        
        if delegate != nil {
        delegate?.cellTapped()
        }
    }
}

extension CommentTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width * 0.9,
                      height: collectionView.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
}
