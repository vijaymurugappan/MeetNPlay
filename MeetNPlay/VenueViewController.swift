//
//  VenueViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/10/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit

class VenueViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ratingTv: UITextField!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var sportTv: UITextField!
    @IBOutlet weak var sportPicker: UIPickerView!
    @IBOutlet weak var radiusTv: UITextField!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var searchButton: UIButton!
    
    var sportData = ["Badminton", "Soccer", "Bowling"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "FIND VENUE"
        sportTv.inputView = sportPicker
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.setHidesBackButton(false, animated: true)
        self.tabBarController?.navigationItem.backBarButtonItem?.tintColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "FIND VENUE"
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.setHidesBackButton(false, animated: true)
        self.tabBarController?.navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ratingSliderChanged(_ sender: UISlider) {
        ratingTv.text = "\(Int(sender.value))"
    }
    
    @IBAction func radiusSliderChanged(_sender: UISlider) {
        radiusTv.text = "\(Int(_sender.value)) mi"
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "loc", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sportTv.text = sportData[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loc") {
            let vcTemp = segue.destination as! VenueMapViewController
            vcTemp.radius = radiusTv.text!
            vcTemp.rating = ratingTv.text!
            vcTemp.game = sportTv.text!
        }
    }

}
