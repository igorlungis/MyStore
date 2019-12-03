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

   // var user: UserStore!
    var ref: DatabaseReference!
    var products = Array<Product>()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
       // user = UserStore(user: currentUser)
        //ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("products")
        ref = Database.database().reference(withPath: "products")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { (snapshot) in
            var _products = Array<Product>()
            for item in snapshot.children {
                let product = Product(snapshot: item as! DataSnapshot)
            _products.append(product)
            }
            self.products = _products
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
       // let productTitle = products[indexPath.row].title
        //cell.textLabel?.text = productTitle
      //  toggleComletion(cell, isCompleted: isCompleted)
        //cell.imgView.image = convertBase64ToImage(product.imgString!)
        cell.title.text = product.title
        cell.desc.text = product.desc
        cell.price.text = product.price + " $"
        
        if product.imageDownloadURL != nil {
            cell.loadImage(url: (product.imageDownloadURL)!) { image in cell.imgView.image = image }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = products[indexPath.row]
            product.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) else { return }
//        let product = products[indexPath.row]

    }
    
    @IBAction func addButton(_ sender: Any) {
        //        let alertController = UIAlertController(title: "New product", message: "Add new product", preferredStyle: .alert)
        //        alertController.addTextField()
        //        let save = UIAlertAction(title: "Save", style: .default) { _ in
        //            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
        //
        //            let product = Product(title: textField.text!, userId: self.user.uid)
        //            let productRef = self.ref.child(product.title.lowercased())
        //            productRef.setValue(["title": product.title, "userId": product.userId, "comleted": product.completed])
        //        }
        //        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        //        alertController.addAction(save)
        //        alertController.addAction(cancel)
        //
        //        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        do {
        try Auth.auth().signOut()
        } catch {
        print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func convertBase64ToImage(_ str: String) -> UIImage {
            let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
    }
    
    
    
}


