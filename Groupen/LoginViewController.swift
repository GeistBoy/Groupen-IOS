//
//  LoginViewController.swift
//  Groupen
//
//  Created by Zheng Liang on 2018/6/22.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    

    @IBAction func Login(_ sender: Any) {
        let parameters = "username=\(textUsername.text!)&password=\(textPassword.text!)"
        
        let url = URL(string: "http://192.168.1.3/groupen/ios/login.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using:.utf8)
        
        let task = URLSession.shared.dataTask(with:request) {
            (data, respond, error) in
            if error != nil{
                //print error message
                return
            }
            print(data)
            
            
            
        }
        task.resume()
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
