//
//  LogInViewController.swift
//  SimpleTest
//
//  Created by Yupeng Lin on 7/3/18.
//  Copyright © 2018 vluxe. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func onLoginConnection(_ sender: Any) {
        
        let emailText =  email.text!
        let passwordTextCombo = emailText + password.text!
        let data = passwordTextCombo.data(using: .utf8)
        
        
        
        let url = Constants.BASEURL + "/ap1/v1/auth/token"
        
        let parameters: Parameters = [
            "email": emailText,
            "password": data!.base64EncodedString()
        ]
        
        Alamofire.request(url, parameters: parameters).responseString { response in

            if let serverResponse = response.response {
                if serverResponse.statusCode == 200 {
                    let jwtToken = response.result.value!
                    let defaults = UserDefaults.standard
                    defaults.set(jwtToken, forKey: "early.token")
                    
                    
                    let url = Constants.BASEURL + "/api/v1/auth/user"
                    let Auth_header    = [ "Authorization" : ShareData.shared.getAuthToken(jwt: jwtToken),  "Content-Type" : "application/json"]
                    Alamofire.request(url, headers: Auth_header).responseString { response in
                        if let text = response.result.value {
                            let jsonTextData: Data = text.data(using: .utf8)!
                            if let decodedUser = try? JSONDecoder().decode(User.self, from: jsonTextData) {
                                ShareData.shared.setCurrentUser(u: decodedUser)
                                self.present(ConversationViewController(), animated: true, completion: nil)
                            }
                        }
                    }
                } else {
                    print("failed")
                }
            }
          
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
