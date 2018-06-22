//
//  model.swift
//  SimpleTest
//
//  Created by Yupeng Lin on 6/22/18.
//  Copyright © 2018 vluxe. All rights reserved.
//

import Foundation

struct Message : Codable {
    var message : String
    var username : String
    var user_id : Int
    var message_type : String
}

