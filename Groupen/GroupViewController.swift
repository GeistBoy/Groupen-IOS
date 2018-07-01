//
//  GroupViewController.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/26.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var result:[group] = []
    var input:[group] = []
    var type:Bool = false
    
    struct group {
        var gid:Int
        var starterID:String
        var productID:Int
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let parameters = "";
        let address = "groupen/ios/group.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }

    }
    
    func completeHandler(json:[String:Any]?, error:Error?){
        if error == nil {
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
                    
                    // get data again
                    
                    
                    tableView.reloadData();
                }else if json!["newGroup"] != nil{
                    let joinResult = json!["JoinResult"] as! Bool
                    var alertMe:String
                    if(joinResult == true){
                        alertMe = "Create successfully"
                    }else{
                        alertMe = "Failed"
                    }
                    let alert = UIAlertController(title: "Create Result", message:alertMe, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    // get data again
                    
                    
                    tableView.reloadData();
                }else if json!["data"] != nil {
                    let datas = json!["data"] as! Array<[String:String]>
                    for row in datas{
                        let groupID = (row["gid"] as! NSString).integerValue
                        let starterID = row["starter_uid"] as! String
                        let productID = (row["product_pid"] as! NSString).integerValue
                        input.append(group(gid: groupID, starterID: starterID, productID:productID))
                    }
                    self.result = self.input
                    self.searchBar.delegate = self
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    
                    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                }else{
                    let alert = UIAlertController(title: "Internet error", message:"please try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
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
            for group in input{
                if("\(group.productID)".hasPrefix(searchText)){
                    result.append(group)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel!.text = "\(result[indexPath.row].productID)"
        cell?.detailTextLabel?.text = "\(result[indexPath.row].gid)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
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
