//
//  NewProductViewController.swift
//  MyStore
//
//  Created by Igor Lungis on 12/1/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit
import Firebase

class NewProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    var imageString: String = ""
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "products")
    }

    @IBAction func canselBut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBut(_ sender: Any) {
        
        guard let _ = titleText.text, titleText.text != "" else { return }
        guard let _ = descText.text, descText.text != "" else { return }
        guard let _ = priceText.text, priceText.text != "" else { return }
        guard let _ = imgView, imgView.image != nil else { return }
        
        let product = Product(title: titleText.text!, desc: descText.text!, price: priceText.text!)
        
        let productRef = self.ref.child(product.title.lowercased())
        
        let newPostRef = Database.database().reference().child("products").childByAutoId()
        let newPostKey = newPostRef.key
        var strURL = ""
        
        if let imageData = self.imgView.image!.pngData() {
            let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newPostKey!)
            newImageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
                 newImageRef.downloadURL(completion: { (url, error) in
                     if let urlText = url?.absoluteString {
                        strURL = urlText
                        productRef.setValue(["title": product.title, "description": product.desc, "price": product.price, "imageDownloadURL": strURL])
                     }
                 })
             })
        }        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoBut(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgView.image = info[.editedImage] as? UIImage
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tap(_ sender: Any) {
        titleText.resignFirstResponder()
        descText.resignFirstResponder()
        priceText.resignFirstResponder()
    }
}
