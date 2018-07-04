//
//  StartViewController.swift
//  SimpleTest
//
//  Created by Yupeng Lin on 7/3/18.
//  Copyright © 2018 vluxe. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let jwtToken = UserDefaults.standard.string(forKey: "early.token") ?? ""
        print("local jwt \(jwtToken)")
        if jwtToken != "" {
            self.performSegue(withIdentifier: "LoginExist", sender: self)
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
