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

    var imageCache = NSCache<NSString, UIImage>()
    var ref: DatabaseReference!
    var products = Array<Product>()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var butAddOut: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard Auth.auth().currentUser != nil else { return }
        ref = Database.database().reference(withPath: "products")
        tableView.rowHeight = tableView.frame.width + 60
        butAddOut.isEnabled = AppDelegate.admin
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
        cell.backgroundColor = .clear
        cell.imgView.layer.cornerRadius = 20
        let product = products[indexPath.row]
        cell.title.text = product.title
        cell.desc.text = product.desc
        cell.price.text = product.price + " $"
        if product.imageDownloadURL != nil {
            loadImage(url: (product.imageDownloadURL)!) { image in cell.imgView.image = image }
            }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if AppDelegate.admin {
        return true
        } else { return false }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = products[indexPath.row]
            product.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !AppDelegate.admin  {
            let cartVC = storyboard!.instantiateViewController(withIdentifier: "cartVC") as! CartViewController
            cartVC.titleText = products[indexPath.item].title
            cartVC.descText = products[indexPath.item].desc
            cartVC.priceText = products[indexPath.item].price + " $"
            if products[indexPath.item].imageDownloadURL != nil {
                loadImage(url: (products[indexPath.item].imageDownloadURL)!) { image in cartVC.image = image }
            }
            cartVC.modalTransitionStyle = .coverVertical
            cartVC.modalPresentationStyle = .fullScreen
            self.present(cartVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        do {
        try Auth.auth().signOut()
        } catch {
        print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        }  else {
            let request = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                self!.imageCache.setObject(image, forKey: url as NSString)

                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
    
    
}


