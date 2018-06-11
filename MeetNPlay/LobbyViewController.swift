//
//  LobbyViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/6/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var playerTv: UITableView!
    @IBOutlet weak var venueButton: UIButton!
    @IBOutlet weak var venueTv: UITableView!
    @IBOutlet weak var scheduleButton: UIButton!
    
    var playerArray = [String]()
    var venueArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "LOBBY"
        if playerArray.count > 0 && venueArray.count > 0 {
            scheduleButton.isEnabled = true
            scheduleButton.alpha = 1.0
        }
        else {
            scheduleButton.isEnabled = false
            scheduleButton.alpha = 0.75
        }
        if playerArray.count >= 9 {
            playerButton.isEnabled = false
            playerButton.alpha = 0.75
        }
        else {
            playerButton.isEnabled = true
            playerButton.alpha = 1.0
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "LOBBY"
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: true)
        if playerArray.count > 0 && venueArray.count > 0 {
            scheduleButton.isEnabled = true
            scheduleButton.alpha = 1.0
        }
        else {
            scheduleButton.isEnabled = false
            scheduleButton.alpha = 0.75
        }
    }
    
    @IBAction func playerSearched(_ sender: UIButton) {
        self.performSegue(withIdentifier: "find", sender: self)
    }
    
    @IBAction func venueSearched(_ sender: UIButton) {
        self.performSegue(withIdentifier: "findv", sender: self)
    }
    
    @IBAction func scheduleGame(_ sender: UIButton) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == playerTv {
            return playerArray.count
        }
        return venueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == playerTv {
            let playerCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
            playerCell.textLabel?.text = playerArray[indexPath.item]
            return playerCell
        }
        let venueCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath)
        venueCell.textLabel?.text = venueArray[indexPath.item]
        return venueCell
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
