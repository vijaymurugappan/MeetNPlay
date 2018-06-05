//
//  User.swift
//  MeetNPlay
//
//  Created by Vijay Murugappan Subbiah on 6/4/18.
//  Copyright © 2018 VMS. All rights reserved.
//

import UIKit

class User: NSObject {
    var Name:String!
    var Age:String!
    var Sex:String!
    var Contact:String!
    var Username:String!
    var Password:String!
    var Sports:String!
    var Day:String!
    var Bowling:String!
    var Badminton:String!
    var Soccer:String!
    var uid:String!
    
    init(name: String, age: String, sex: String, contact: String, username: String, password: String, sports: String, day: String, bowling: String, badminton: String, soccer: String) {
        
        self.Name = name
        self.Age = age
        self.Sex = sex
        self.Contact = contact
        self.Username = username
        self.Password = password
        self.Sports = sports
        self.Day = day
        self.Bowling = bowling
        self.Badminton = badminton
        self.Soccer = soccer
    }
    func id(uid: String) {
        self.uid = uid
    }
}
