//
//  Product.swift
//  MyStore
//
//  Created by Igor Lungis on 11/30/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import Foundation
import Firebase

struct Product {
    let title: String
    let userId: String
    let ref: DatabaseReference?
    var completed = false
    
    init(title: String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String : AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
