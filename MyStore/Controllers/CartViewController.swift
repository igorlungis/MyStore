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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        massegeLabel.alpha = 0
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
        massegeLabel.alpha = 1
        massegeLabel.text = "Thanks! Our consultant will contact you shortly."
    }
    
}
