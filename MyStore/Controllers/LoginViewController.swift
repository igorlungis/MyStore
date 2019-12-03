//
//  ViewController.swift
//  MyStore
//
//  Created by Igor Lungis on 11/29/19.
//  Copyright © 2019 Igor Lungis. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        warnLabel.alpha = 0
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "listSegue", sender: nil)
            }
        })
        ref = Database.database().reference(withPath: "users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailText.text = ""
        passText.text = ""
    }
    
    func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        warnLabel.alpha = 1
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailText.text, let pass = passText.text, email != "", pass != "" else {
            displayWarningLabel(withText: "Incorrect info")
            return
        }
       
        Auth.auth().signIn(withEmail: email, password: pass, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Authentication error")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: "listSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        })
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        guard let email = emailText.text, let pass = passText.text, email != "", pass != "" else {
                   displayWarningLabel(withText: "Incorrect info")
                   return
               }
        Auth.auth().createUser(withEmail: email, password: pass, completion: nil)
    }

}

