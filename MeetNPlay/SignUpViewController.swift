//
//  SignUpViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/1/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var sexPicker: UIPickerView!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var sportPicker: UIPickerView!
    @IBOutlet weak var badmintonSwitch: UISwitch!
    @IBOutlet weak var badmintonLabel: UILabel!
    @IBOutlet weak var badmintonSlider: UISlider!
    @IBOutlet weak var soccerSwitch: UISwitch!
    @IBOutlet weak var soccerLabel: UILabel!
    @IBOutlet weak var soccerSlider: UISlider!
    @IBOutlet weak var bowlingSwitch: UISwitch!
    @IBOutlet weak var bowlingLabel: UILabel!
    @IBOutlet weak var bowlingSlider: UISlider!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registerBtn: UIButton!
    
    let rootref = Database.database().reference()
    
    var agePickerData = [Int]()
    var sexPickerData = ["M","F"]
    var dayPickerData = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var sportPickerData = ["Badminton","Soccer","Bowling"]
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...100 {
            agePickerData.append(i)
        }
        
        bowlingSlider.isHidden = true
        soccerSlider.isHidden = true
        badmintonSlider.isHidden = true
        
        ageTextField.inputView = agePicker
        sexTextField.inputView = sexPicker
        dayTextField.inputView = dayPicker
        sportTextField.inputView = sportPicker
        
        nameTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        sexTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        contactTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        userTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        dayTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        sportTextField.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        registerBtn.isEnabled = false
        registerBtn.alpha = 0.5
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        sexTextField.resignFirstResponder()
        contactTextField.resignFirstResponder()
        userTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        dayTextField.resignFirstResponder()
        sportTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         scrollView.setContentOffset(CGPoint(x: 0,y: 200) , animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0,y: 0) , animated: true)
    }
    
    @objc func enableButton(_textfield: UITextField) {
        if(_textfield.text?.count == 1) {
            if(_textfield.text?.first == " ") {
                _textfield.text = ""
                return
            }
        }
        guard(!(nameTextField.text?.isEmpty)! && !(ageTextField.text?.isEmpty)! && !(sexTextField.text?.isEmpty)! && !(contactTextField.text?.isEmpty)! && !(userTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! && !(sportTextField.text?.isEmpty)! && !(dayTextField.text?.isEmpty)!)
            else {
                registerBtn.isEnabled = false
                registerBtn.alpha = 0.5
                return
        }
        registerBtn.isEnabled = true
        registerBtn.alpha = 1.0
    }

    @IBAction func badSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            badmintonLabel.text = "\(Int(badmintonSlider.value))"
            badmintonSlider.isHidden = false
        }
        else {
            badmintonLabel.text = ""
            badmintonSlider.isHidden = true
        }
    }
    
    @IBAction func socSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            soccerLabel.text = "\(Int(soccerSlider.value))"
            soccerSlider.isHidden = false
        }
        else {
            soccerLabel.text = ""
            soccerSlider.isHidden = true
        }
    }
    
    @IBAction func bowlSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            bowlingLabel.text = "\(Int(bowlingSlider.value))"
            bowlingSlider.isHidden = false
        }
        else {
            bowlingLabel.text = ""
            bowlingSlider.isHidden = true
        }
    }
    
    @IBAction func badSliderChanged(_ sender: UISlider) {
        badmintonLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func socSliderChanged(_ sender: UISlider) {
        soccerLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func bowlSliderChanged(_ sender: UISlider) {
        bowlingLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func registerClicked(_ sender: UIButton) {
        //Appending to the User object
        self.users.append(User(name: self.nameTextField.text!, age: self.ageTextField.text!, sex: self.sexTextField.text!, contact: self.contactTextField.text!, username: self.userTextField.text!, password: self.passwordTextField.text!, sports: self.sportTextField.text!, day: self.dayTextField.text!, bowling: self.bowlingLabel.text!, badminton: self.badmintonLabel.text!, soccer: self.soccerLabel.text!))
        for item in users  {
            //New user creating using firebase clouse database with username and password
            Auth.auth().createUser(withEmail: item.Username, password: item.Password, completion: { (user, error) in
                if(error == nil)
                { //From the user object extracting the files and storing it in the database
                    let descref = self.rootref.child((user?.uid)!)
                    let nameref = descref.child("name")
                    let ageref = descref.child("age")
                    let sexref = descref.child("sex")
                    let contactref = descref.child("number")
                    let idref = descref.child("uid")
                    let sportsref = descref.child("sports")
                    let dayref = descref.child("preferred day")
                    let badmintonref = descref.child("badminton level")
                    let bowlingref = descref.child("bowling level")
                    let soccerref = descref.child("soccer level")
                    //print(item.Name)
                    nameref.setValue(item.Name)
                    ageref.setValue(item.Age)
                    sexref.setValue(item.Sex)
                    contactref.setValue(item.Contact)
                    idref.setValue(user?.uid)
                    sportsref.setValue(item.Sports)
                    dayref.setValue(item.Day)
                    badmintonref.setValue(item.Badminton)
                    bowlingref.setValue(item.Bowling)
                    soccerref.setValue(item.Soccer)
                    item.id(uid: (user?.uid)!)
                    self.performSegue(withIdentifier: "Login", sender: self)
                }
                else {
                    let alertVC = UIAlertController(title: "Error",message: error?.localizedDescription,preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok",style:.default,handler: nil)
                    alertVC.addAction(okAction)
                    self.present(alertVC,animated: true,completion: nil)
                }
            })
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case agePicker:
            return agePickerData.count
        case sexPicker:
            return sexPickerData.count
        case dayPicker:
            return dayPickerData.count
        default:
            return sportPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case agePicker:
            return "\(agePickerData[row])"
        case sexPicker:
            return sexPickerData[row]
        case dayPicker:
            return dayPickerData[row]
        default:
            return sportPickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case agePicker:
            ageTextField.text = "\(agePickerData[row])"
        case sexPicker:
            sexTextField.text = sexPickerData[row]
        case dayPicker:
            dayTextField.text = dayPickerData[row]
        default:
            sportTextField.text = sportPickerData[row]
        }
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
