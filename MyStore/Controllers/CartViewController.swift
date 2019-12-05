//
//  CartViewController.swift
//  MyStore
//
//  Created by Igor Lungis on 12/2/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var massegeLabel: UILabel!
    @IBOutlet weak var buyOutlet: UIButton!
    @IBOutlet weak var phoneOut: UILabel!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailOut: UILabel!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var titleBuy: UILabel!
    @IBOutlet weak var descBuy: UILabel!
    @IBOutlet weak var priceBuy: UILabel!
    
    @IBOutlet weak var imageBuy: UIImageView!
    
    var titleText: String = ""
    var descText = ""
    var priceText = ""
    var image = UIImage(named: "noImage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyOutlet.layer.cornerRadius = 5
        imageBuy.layer.cornerRadius = 10
        titleBuy.text = titleText
        descBuy.text = descText
        priceBuy.text = priceText
        imageBuy.image = image
        NotificationCenter.default.addObserver(self, selector: #selector(CartViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CartViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    @IBAction func canselBut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buyBut(_ sender: Any) {
        
        buyOutlet.alpha = 0
        phoneOut.alpha = 0
        phoneText.alpha = 0
        emailOut.alpha = 0
        emailText.alpha = 0
        priceBuy.alpha = 0
        massegeLabel.text = "Thanks! Our consultant will contact you shortly."
    }
    
    @IBAction func tap(_ sender: Any) {
        phoneText.resignFirstResponder()
        emailText.resignFirstResponder()
    }
    
    
}
