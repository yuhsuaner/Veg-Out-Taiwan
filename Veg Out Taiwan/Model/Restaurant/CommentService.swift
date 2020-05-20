//
//  CommentService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/14.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct CommentService {
    
    static let shared = CommentService()
    
    func likeComment(comment: Comment, completion: @escaping (DatabaseCompletion)) {
        
        guard let  uid = Auth.auth().currentUser?.uid else { return }
        
        guard let didlike = comment.didLike else { return }
        
        let likes  = didlike == true ? comment.likes - 1 : comment.likes + 1
        
        Database.database().reference().child("comments").child(comment.commentId).child("likes").setValue(likes)
        
        if didlike == true {
            //[Unlike]remove like data from firebase
            Database.database().reference().child("user-likes").child(uid).child(comment.commentId).removeValue { (err, ref) in
                
                Database.database().reference().child("comment-likes").child(comment.commentId).removeValue(completionBlock: completion)
            }
            
        } else {
            //[Like]add like data to firebase
            Database.database().reference().child("user-likes").child(uid).updateChildValues([comment.commentId: 1]) { (err, ref) in
                
                Database.database().reference().child("comment-likes").child(comment.commentId).updateChildValues([uid: 1], withCompletionBlock: completion)
            }
        }
    }
}
