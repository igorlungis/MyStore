//
//  Product.swift
//  MyStore
//
//  Created by Igor Lungis on 11/30/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//
import UIKit
import Firebase

struct Product {
    let title: String
    let desc: String
    let price: String
    var imageDownloadURL: String?
    private var image: UIImage!
    let ref: DatabaseReference?
    
    init(title: String, desc: String, price: String) {
        self.title = title
        self.desc = desc
        self.price = price
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String : AnyObject]
        title = snapshotValue["title"] as! String
        desc = snapshotValue["description"] as! String
        price = snapshotValue["price"] as! String
        imageDownloadURL = snapshotValue["imageDownloadURL"] as? String
        ref = snapshot.ref
    }
}

