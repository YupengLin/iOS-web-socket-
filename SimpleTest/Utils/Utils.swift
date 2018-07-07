//
//  Utils.swift
//  ChatExample
//
//  Created by Yupeng Lin on 6/26/18.
//

import Foundation
import Alamofire
import MessageKit

//struct Message : Codable {
//    var message : String
//    var username : String
//    var user_id : Int
//    var message_type : String
//    var uuid : String
//    var created_at : String
//}

final internal class Utils {
    
    static let shared = Utils()
    
    private init() {}
    
    
//    var currentSender: Sender {
//        return Sender(id: String(2), displayName: "yupeng")
//    }
    
//    func getCurrentSenderId() -> Int {
//        return 2
//    }
    
    
    func getMessagesFromServer(count: Int, completion: @escaping ([MockMessage]) -> Void) {
        
        var messages: [MockMessage] = []
        let urlString = Constants.BASEURL + "/test"
        
        Alamofire.request(urlString).responseString { response in
            
            if let text = response.result.value {
                let jsonTextData: Data = text.data(using: .utf8)!
                let decodedMessages = try? JSONDecoder().decode([Message].self, from: jsonTextData)
                
                for msg in decodedMessages! {
                    
                    messages.append(MockMessage(text: msg.message, sender:Sender(id: String(msg.user_id), displayName: msg.username), messageId: msg.uuid, date: self.convertStringToDate(timestamp: msg.created_at)))
                }
                
                
                
                
            }
            
            completion(messages)
            
        }
        
    }
    
    func convertStringToDate(timestamp: String) -> Date{
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        
        
        let date = RFC3339DateFormatter.date(from: timestamp)
        return date!
    }
    
    
    
    
    
}


