//
//  ViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 5/31/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginClicked(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: userTextField.text!, password: passwordTextField.text!, completion: {
            (user,error) in
            self.performSegue(withIdentifier: "profile", sender: self)
        })
    }

}

