//
//  StartViewController.swift
//  SimpleTest
//
//  Created by Yupeng Lin on 7/3/18.
//  Copyright © 2018 vluxe. All rights reserved.
//

import UIKit
import Alamofire

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let jwtToken = UserDefaults.standard.string(forKey: "early.token") ?? ""
        if jwtToken != "" {
            let url = Constants.BASEURL + "/api/v1/auth/user"
            let Auth_header    = [ "Authorization" : ShareData.shared.getAuthToken(jwt: jwtToken), "Content-Type" : "application/json"]
            
            Alamofire.request(url, headers: Auth_header).responseString { response in
                if let text = response.result.value {
                    let jsonTextData: Data = text.data(using: .utf8)!
                    if let decodedUser = try? JSONDecoder().decode(User.self, from: jsonTextData) {
                        ShareData.shared.setCurrentUser(u: decodedUser)
                        self.present(ConversationViewController(), animated: true, completion: nil)
                    }
                }
            }
        }

        
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        print("login")
        self.performSegue(withIdentifier: "LoginSelected", sender: self)
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
