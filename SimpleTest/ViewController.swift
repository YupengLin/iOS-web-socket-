//
//  ViewController.swift
//  SimpleTest
//
//  Created by Dalton Cherry on 8/12/14.
//  Copyright (c) 2014 vluxe. All rights reserved.
//

import UIKit
import Starscream



class ViewController: UIViewController, WebSocketDelegate {
    var socket: WebSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var request = URLRequest(url: URL(string: "http://localhost:8000/ws")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request, protocols: ["chat","superchat"])
        socket.delegate = self
        socket.connect()
    }
    
    @IBOutlet weak var userMessage: UITextField!
    
    // MARK: Websocket Delegate Methods.
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        if let e = error as? WSError {
            print("websocket is disconnected: \(e.message)")
        } else if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
             print("websocket disconnected")
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
//        print("receive text")

        let jsonTextData: Data = text.data(using: .utf8)!


        let decodedMessages = try? JSONDecoder().decode([Message].self, from: jsonTextData)
        
        for msg in decodedMessages! {
            print("message: \(msg.message)")
        }
        
        
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count)")
    }
    
    // MARK: Write Text Action
    
    @IBAction func writeText(_ sender:
        UIBarButtonItem) {
        print("send message")
        do {
            let messageText = userMessage.text!
            let um = Message(message: messageText, username: "yupeng", user_id: 1, message_type: "user-message")
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(um)
            let umjson = String(data: jsonData, encoding: String.Encoding.utf8)
            
            socket.write(string: umjson!)
        } catch {
            print(error)
        }
    }
    
    // MARK: Disconnect Action
    
    @IBAction func disconnect(_ sender: UIBarButtonItem) {
        if socket.isConnected {
            sender.title = "Connect"
            socket.disconnect()
        } else {
            sender.title = "Disconnect"
            socket.connect()
        }
    }
    
    
    
}


