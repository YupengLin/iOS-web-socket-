//
//  Variables.swift
//  SimpleTest
//
//  Created by Yupeng Lin on 7/6/18.
//  Copyright © 2018 vluxe. All rights reserved.
//

import Foundation
import MessageKit


struct Constants {
    static let BASEURL = "http://localhost:8000"
    struct Message {
        static let MessageToFetch = 100
    }
}

final internal class ShareData {
    
    static let shared = ShareData()
    
    private init() {}
    
    var currUser = User(user_id:0, username: "")
    var currSender = Sender(id: String(0), displayName: "")
    
    func setCurrentUser(u: User) {
        self.currUser = u
        self.currSender = Sender(id: String(u.user_id), displayName: u.username)
    }
    
    func getCurrentUser() -> User {
        return self.currUser
    }
    
    func getAuthToken(jwt: String) -> String {
        return "BEARER " + jwt
    }
    
    func getCurrentSender() -> Sender {
        return self.currSender
    }

    func getCurrentSenderId() -> Int {
        return 2
    }
}
