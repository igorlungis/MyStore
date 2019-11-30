//
//  ListViewController.swift
//  MyStore
//
//  Created by Igor Lungis on 11/29/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: UserStore!
    var ref: DatabaseReference!
    var products = Array<Product>()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = UserStore(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("products")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "New product", message: "Add new product", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            
            let product = Product(title: textField.text!, userId: self.user.uid)
            let productRef = self.ref.child(product.title.lowercased())
            productRef.setValue(["title": product.title, "userId": product.userId, "comleted": product.completed])
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        do {
        try Auth.auth().signOut()
        } catch {
        print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
