//
//  ProfileViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/5/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var contactLbl: UILabel!
    @IBOutlet weak var sportLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var badmintonLbl: UILabel!
    @IBOutlet weak var soccerLbl: UILabel!
    @IBOutlet weak var bowlingLbl: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var msgBtn: UIButton!
    
    var users = [User]()
    
    let picker = UIImagePickerController()
    var uid = String()
    var uidArray = [String]()
    var contact = String()
    var viewTitle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        let logoutBtn = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logoutPressed))
        logoutBtn.tintColor = UIColor.black
        self.tabBarController?.navigationItem.leftBarButtonItem = logoutBtn
        let ref = Database.database().reference()
        let chdref = ref.child(uid)
        chdref.observe(.value, with: {(FIRDataSnapshot) in
            if let result = FIRDataSnapshot.children.allObjects as? [DataSnapshot] {
                self.viewTitle = (result[3].value as? String)!
                self.tabBarController?.title = self.viewTitle
                self.idLbl.text = result[9].value as? String
                self.nameLbl.text = result[3].value as? String
                self.sportLbl.text = result[8].value as? String
                self.dayLbl.text = result[5].value as? String
                self.badmintonLbl.text = result[1].value as? String
                self.bowlingLbl.text = result[2].value as? String
                self.soccerLbl.text = result[7].value as? String
                self.contact = (result[4].value as? String)!
                self.contactLbl.text = self.contact
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.title = viewTitle
        let logoutBtn = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logoutPressed))
        logoutBtn.tintColor = UIColor.black
        self.tabBarController?.navigationItem.leftBarButtonItem = logoutBtn
    }
    
    @objc func logoutPressed() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        self.tabBarController?.navigationController?.popViewController(animated: true)
        self.tabBarController?.navigationController?.popViewController(animated: true)
    }

    @IBAction func imageChanger(_ sender: UIButton) {
        
    }
    
    @IBAction func callPressed(_ sender: UIButton) {
        let myURL:NSURL = URL(string: "tel://\(self.contact)")! as NSURL
        UIApplication.shared.open(myURL as URL, options: [:], completionHandler: nil)
        //Using alert since we are running on a simulator
        let alertController = UIAlertController(title: "Calling..", message: self.contact, preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
        })
        alertController.addAction(dismissButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func msgPressed(_ sender: UIButton) {
        if(MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hey are you available for a game? from Meet'N Play"
            controller.recipients = [self.contact]
            controller.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
            self.present(controller, animated: true, completion: nil)
        }
        else {
            self.noMessage()
        }
    }
    
    func noMessage()
    {
        let alertVC = UIAlertController(title: "No Messaging",message: "Sorry, this device has no Messaging capabilities",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",style:.default,handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
