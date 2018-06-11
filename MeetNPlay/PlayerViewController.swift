//
//  PlayerViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/6/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit

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
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        skillLvl.text = "\(Int(sender.value))"
    }
    
    @IBAction func searchClicked(_ sender:UIButton) {
        
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
            return
        }
        dayTextField.text = dayData[row]
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
