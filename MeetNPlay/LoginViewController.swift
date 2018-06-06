//
//  ViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 5/31/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var uid = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true {
            self.uid = UserDefaults.standard.string(forKey: "userID")!
            UIView.setAnimationsEnabled(false)
            self.performSegue(withIdentifier: "profile", sender: self)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true {
            self.uid = UserDefaults.standard.string(forKey: "userID")!
            UIView.setAnimationsEnabled(false)
            self.performSegue(withIdentifier: "profile", sender: self)
        }
        self.navigationController?.isNavigationBarHidden = true
        userTextField.text = ""
        passwordTextField.text = ""
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // keyboard resigned when touched outside of the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scrollView.endEditing(true)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 200) , animated: true) // moving keyboard up when text field did begin editing
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0) , animated: true)  // moving keyboard back down when text field did end editing
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

    @IBAction func loginClicked(_ sender: UIButton) {
        if userTextField.text == "" || passwordTextField.text == "" {
            showAlert(Title: "INVALID", Desc: "Username or Password not found")
            return
        }
        Auth.auth().signIn(withEmail: userTextField.text!, password: passwordTextField.text!, completion: {
            (user,error) in
            if (error == nil) {
                self.uid = (user?.uid)!
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set(self.uid, forKey: "userID")
                UserDefaults.standard.synchronize()
                UIView.setAnimationsEnabled(false)
                self.performSegue(withIdentifier: "profile", sender: self)
                return
            }
            self.showAlert(Title: "INCORRECT", Desc: "Username or Password Incorrect")
        })
    }
    
    func showAlert(Title: String, Desc: String) {
        let alertController = UIAlertController(title: Title, message: Desc, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) {
            (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            let tabCtrl = segue.destination as! UITabBarController
            let nav = tabCtrl.viewControllers![0] as! UINavigationController
            let vc = nav.viewControllers[0] as! ProfileViewController
            vc.uid = uid
        }
    }

}

