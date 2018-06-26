//
//  newCircleViewController.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/26.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class newCircleViewController: UIViewController {
    @IBOutlet weak var circleName: UITextField!
    @IBOutlet weak var tag: UITextField!
    @IBAction func Create(_ sender: Any) {
        let parameters = "name=\(circleName.text!)&tag=\(tag.text!)";
        let address = "groupen/ios/circle.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
    }
    
    func completeHandler(json:[String:Any]?, error:Error?){
        if error == nil{
            if json != nil{
                if json!["createResult"] != nil{
                    let joinResult = json!["createResult"] as! Bool
                    var alertMe:String
                    if(joinResult == true){
                        alertMe = "Create successfully"
                        
                        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
                        self.present(mainViewController, animated: true, completion: nil)
                    }else{
                        alertMe = "Failed"
                    }
                    let alert = UIAlertController(title: "Create Result", message:alertMe, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
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
