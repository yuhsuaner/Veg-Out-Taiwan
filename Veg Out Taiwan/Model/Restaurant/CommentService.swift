//
//  CommentService.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/14.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import FirebaseDatabase

//struct CommentService {
//
//    static let shared = CommentService()
//
//    var comment: [Comment] = []
//
//    var ref = Database.database().reference()
//
//    func fetchCommentfromFirebase(restaurantName: String, completion: @escaping(Comment) -> Void) {
//
//        var result: [Comment] = []
//
//        ref.child("comment_user").queryOrdered(byChild: "restaurantName").queryEqual(toValue: restaurantName).observe(.value, with: { (snapshot) in
//
//            guard let dictionary = snapshot.value as? [String: [String: Any]] else { return }
//
//            guard let data = try? JSONSerialization.data(withJSONObject: Array(dictionary.values), options: .fragmentsAllowed) else { return }
//
//            do {
//
//                let json = try JSONDecoder().decode([Comment].self, from: data)
//                result.append(contentsOf: json)
//
//            } catch {
//                print(error)
//            }
//
//            self.comment = result
//            completion(result)
//        })
//    }
//}
