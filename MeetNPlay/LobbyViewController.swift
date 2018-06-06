//
//  LobbyViewController.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/6/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "LOBBY"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.navigationItem.title = "LOBBY"
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
