//
//  PlayerViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/6/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit
import Firebase

class PlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var sportPicker: UIPickerView!
    @IBOutlet weak var skillLvl: UILabel!
    @IBOutlet weak var skillSlider: UISlider!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!
    
    var sportData = ["Badminton", "Soccer", "Bowling"]
    var dayData = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var temp = Int()
    var badskill = Int()
    var bowskill = Int()
    var socskill = Int()
    var strbad = String()
    var strbow = String()
    var strsoc = String()
    var strday = String()
    var chosenUID = String()
    var sport = String()
    var pid = String()
    var uid = String()
    var uidArray = [String]()
    var badskillArray = [Int]()
    var bowskillArray = [Int]()
    var socskillArray = [Int]()
    var sportArray = [String]()
    var dayArray = [String]()
    var chosenUIDArray = [String]()
    var chldref = DatabaseReference()
    var count = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "FIND PLAYERS"
        dayTextField.inputView = dayPicker
        sportTextField.inputView = sportPicker
        skillSlider.isHidden = true
        skillLvl.isHidden = true
        skillLvl.text = "\(Int(skillSlider.value))"
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.setHidesBackButton(false, animated: true)
        self.tabBarController?.navigationItem.backBarButtonItem?.tintColor = UIColor.black
        searchButton.isEnabled = false
        searchButton.alpha = 0.5
        fetchKey()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "FIND PLAYERS"
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.setHidesBackButton(false, animated: true)
        self.tabBarController?.navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enableButton() {
        searchButton.isEnabled = true
        searchButton.alpha = 1.0
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        skillLvl.text = "\(Int(sender.value))"
    }
    
    @IBAction func searchClicked(_ sender:UIButton) {
        for str in sportArray {
            if(str == "Badminton") { //if badminton
                for skl in badskillArray {
                    if(sportTextField.text == str && Int(skillLvl.text!)! == skl) { //checking whether there is a match with the database value
                        for uidd in uidArray {
                            temp = 1
                            transferData(str: str,skl: skl,temp: temp,uidd: uidd) //if yes transfer it to a function
                        }
                        break
                    }
                }
                break
            }
            if(str == "Soccer") { //if soccer
                for skl in socskillArray {
                    if(sportTextField.text == str && Int(skillLvl.text!)! == skl) {
                        for uidd in uidArray {
                            temp = 2
                            transferData(str: str,skl: skl,temp: temp,uidd: uidd)
                        }
                        break
                    }
                }
                break
            }
            if(str == "Bowling") { //if bowling
                for skl in bowskillArray {
                    if(sportTextField.text == str && Int(skillLvl.text!)! == skl) {
                        for uidd in uidArray {
                            temp = 3
                            transferData(str: str,skl: skl,temp: temp,uidd: uidd)
                        }
                        break
                    }
                }
                break
            }
        }
    }
    
    func transferData(str:String,skl:Int,temp:Int,uidd:String) {
        let ref = Database.database().reference()
        //print("enter array")
        self.chldref = ref.child(uidd)
        chldref.observe(.value, with: {(FIRDataSnapshot)  in
            if let results = FIRDataSnapshot.children.allObjects as? [DataSnapshot] {
                self.count += 1
                if(temp == 1) { // reference number passed to identify the sport and skill
                    self.pid = results[10].value as! String
                    if(self.pid == self.uid) // not for showing the user's own stats and profile
                    {
                        //Do nothing
                    }
                    else {
                        self.strbad = results[2].value as! String
                        self.badskill = Int(self.strbad)!
                        self.sport = results[9].value as! String
                        //print(self.sport)
                        if(self.badskill == skl && self.sport == str) {
                            self.chosenUID = results[10].value as! String
                            //print(self.chosenUID)
                            self.chosenUIDArray.append(self.chosenUID)
                            //print(self.chosenUIDArray)
                        }
                    }
                }
                
                if(temp == 2) {
                    self.pid = results[10].value as! String
                    if(self.pid == self.uid)
                    {
                        //Do nothing
                    }
                    else {
                        self.strbow = results[3].value as! String
                        self.bowskill = Int(self.strbow)!
                        self.sport = results[9].value as! String
                        if(self.bowskill == skl && self.sport == str) {
                            self.chosenUID = results[10].value as! String
                            self.chosenUIDArray.append(self.chosenUID)
                        }
                    }
                }
                if(temp == 3) {
                    self.pid = results[10].value as! String
                    if(self.pid == self.uid)
                    {
                        //Do nothing
                    }
                    else {
                        self.strsoc = results[8].value as! String
                        self.socskill = Int(self.strsoc)!
                        self.sport = results[9].value as! String
                        if(self.socskill == skl && self.sport == str) {
                            self.chosenUID = results[10].value as! String
                            self.chosenUIDArray.append(self.chosenUID)
                        }
                    }
                }
            }
            if(self.count == self.uidArray.count) {
                self.performSegue(withIdentifier: "opponent", sender: self)
            }
        })
    }
    
    func fetchKey() {
        let ref = Database.database().reference()
        ref.observe(.value, with: {(snapshot) in
            if let res = snapshot.children.allObjects as? [DataSnapshot] {
                let counter = res.count
                for i in 0...(counter-1) {
                    self.uidArray.append(res[i].key)
                }
                self.fetchData()
            }
        })
    }
    
    func fetchData() {
        let ref = Database.database().reference()
        for uidd in uidArray {
            let chldref = ref.child(uidd)
            chldref.observe(.value, with: {(FIRDataSnapshot) in
                if let results = FIRDataSnapshot.children.allObjects as? [DataSnapshot] {
                    self.strbad = results[2].value as! String
                    self.badskill = Int(self.strbad)!
                    self.badskillArray.append(self.badskill)
                    self.strbow = results[3].value as! String
                    self.bowskill = Int(self.strbow)!
                    self.bowskillArray.append(self.bowskill)
                    self.strsoc = results[8].value as! String
                    self.socskill = Int(self.strsoc)!
                    self.socskillArray.append(self.socskill)
                    self.sport = results[9].value as! String
                    self.sportArray.append(self.sport)
                    self.strday = results[5].value as! String
                    self.dayArray.append(self.strday)
                }
            })
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sportPicker {
            return sportData.count
        }
        return dayData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sportPicker {
            return sportData[row]
        }
        return dayData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sportPicker {
            sportTextField.text = sportData[row]
            skillSlider.isHidden = false
            skillLvl.isHidden = false
            if(!(dayTextField.text?.isEmpty)! && !(sportTextField.text?.isEmpty)!) {
                enableButton()
            }
            return
        }
        if(!(dayTextField.text?.isEmpty)! && !(sportTextField.text?.isEmpty)!) {
            enableButton()
        }
        dayTextField.text = dayData[row]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "opponent") {
            let vc2 = segue.destination as! PlayerMapViewController
            vc2.uidArray = chosenUIDArray
        }
    }

}
