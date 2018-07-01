//
//  SignupViewController.swift
//  Groupen
//
//  Created by Zheng Liang on 2018/6/22.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var usernmae: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBAction func Signup(_ sender: Any) {
        let parameters = "username=\(usernmae.text!)&password=\(password.text!)&email=\(email.text)"
        let address = "groupen/ios/register.php"
        
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
    }
    
    func completeHandler(json:[String:Any]?, error:Error?){
        // no error
        if error == nil{
            if json != nil{
                if json!["message"] == nil{
                    // update user
                    let datas = json!["accountInfo"] as! Array<Any>
                    let account = datas[0] as! [String:Any]
                    let userID = account["uid"] as! String
                    let email = account["email"] as! String
                    let address = account["address"] as! String
                    let balance = (account["balance"] as! NSString).doubleValue
                    let admin = (account["admin"] as! NSString).intValue
                    
                    UserDefaults.standard.set(userID, forKey: "uid")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(address, forKey: "address")
                    UserDefaults.standard.set(balance, forKey: "balance")
                    UserDefaults.standard.set(admin, forKey: "admin")
                    
                    // switch screen
                    let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
                    self.present(mainViewController, animated: true, completion: nil)
                    
                }else{
                    self.errorMessage.text = "Failed to sign up, check your input."
                }
            }else{
                // internet error
                self.errorMessage.text = "Internet problem"
            }
        }else{
            self.errorMessage.text = error?.localizedDescription
        }
        self.errorMessage.textColor = UIColor.red
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
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
