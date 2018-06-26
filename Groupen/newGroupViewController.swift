//
//  newGroupViewController.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/26.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class newGroupViewController: UIViewController {
    @IBOutlet weak var groupName: UITextField!
    
    @IBAction func Create(_ sender: Any) {
        let parameters = "pid=\(groupName.text!)&uid=\(UserDefaults.standard.string(forKey: "uid")!)";
        print(parameters)
        let address = "groupen/ios/group.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
    }
    
    func completeHandler(json:[String:Any]?, error:Error?){
        if error == nil{
            if json != nil{
                var alertMe:String
                if json!["newGroup"] != nil{
                        alertMe = "Create successfully"
                        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
                    self.present(mainViewController, animated: true, completion: nil)
                }else{
                        alertMe = json!["newGroup"] as! String
                    }
                    let alert = UIAlertController(title: "Create Result", message:alertMe, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
        }else{
            print(error?.localizedDescription)
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
