//
//  ProfileViewController.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/25.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        UserDefaults.standard.removeObject(forKey: "uid")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "uid") == nil{
            let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            self.present(accountViewController, animated: false, completion: nil)
        }else{
            let logoutButton = UIButton(frame: CGRect(x: 130, y: 300, width: 100, height: 50))
            logoutButton.backgroundColor = .red
            logoutButton.setTitle("Log out", for: [])
            logoutButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            self.view.addSubview(logoutButton)
        }
    }
    
    @objc func buttonAction(){
        UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "address")
        UserDefaults.standard.removeObject(forKey: "balance")
        UserDefaults.standard.removeObject(forKey: "admin")
        // switch screen
        let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
        self.present(mainViewController, animated: true, completion: nil)
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
