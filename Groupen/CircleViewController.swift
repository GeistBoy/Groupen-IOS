//
//  CircleViewController.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/26.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func newCircle(_ sender: Any) {
        let cViewController = self.storyboard?.instantiateViewController(withIdentifier: "newCircleView") as! newCircleViewController
        self.navigationController?.pushViewController(cViewController, animated: true)
    }
    
    
    
    
    
    var result:[circles] = []
    var input:[circles] = []
    var type:Bool = false
    
    struct circles {
        var cid:Int
        var name:String
        var tag:String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let parameters = "";
        let address = "groupen/ios/circle.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
    }
    
    func completeHandler(json:[String:Any]?, error:Error?){
        if error == nil{
            if json != nil{
                if json!["JoinResult"] != nil{
                    let joinResult = json!["JoinResult"] as! Bool
                    var alertMe:String
                    if(joinResult == true){
                        alertMe = "Join successfully"
                    }else{
                        alertMe = "Failed"
                    }
                    let alert = UIAlertController(title: "Join Result", message:alertMe, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    tableView.reloadData()
                }else{
                    let datas = json!["data"] as! Array<[String:String]>
                    for row in datas{
                        input.append(circles(cid: (row["cid"] as! NSString).integerValue, name: row["name"] as! String, tag: row["tag"] as! String))
                    }
                    self.result = self.input
                    self.searchBar.delegate = self
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    
                    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                }
            }
        }else{
            print(error?.localizedDescription)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            self.result = self.input
        }else{
            result = []
            for circle in input{
                if(circle.name.hasPrefix(searchText)){
                    result.append(circle)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell?.accessoryType = .detailDisclosureButton
        cell?.textLabel!.text = result[indexPath.row].name
        cell?.detailTextLabel?.text = result[indexPath.row].tag
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if UserDefaults.standard.string(forKey: "uid") == nil{
            let alert = UIAlertController(title: "Please login first", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let parameters = "cID=\(result[indexPath.row].cid)&login_user=\(UserDefaults.standard.string(forKey: "uid")!)";
            let address = "groupen/ios/circle.php"
            connectionManager.post(path: address, params: parameters) { json, error in
                self.completeHandler(json: json, error: error)
            }
        }
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
