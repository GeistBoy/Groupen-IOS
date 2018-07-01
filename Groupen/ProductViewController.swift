//
//  ProductViewController.swift
//  Groupen
//
//  Created by Zheng Liang on 2018/6/22.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate  {
    struct prodcut{
        var name:String
        var price:Float
        var fDiscount:Float
        var discout:Float
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var result:[prodcut] = []
    var input:[prodcut] = []
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    override func viewWillAppear(_ animated: Bool) {
        let parameters = "";
        let address = "groupen/ios/productList.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
    }
    // data handling
    func completeHandler(json:[String:Any]?, error:Error?){
        if (error == nil) && (json != nil) {
            if json!["data"] != nil{
                let datas = json!["data"] as! Array<[String:String]>
                for row in datas{
                    let name = row["name"] as! String
                    let price = (row["price"] as! NSString).floatValue
                    let fDiscount = (row["first_discount"] as! NSString).floatValue
                    let discout = (row["discount"] as! NSString).floatValue
                    let imageBase64 = row["photo"] as! String
                    
//                    if let decodedImageData = Data(base64Encoded: imageBase64, options: .ignoreUnknownCharacters) {
//                        let image = UIImage(data: decodedImageData)
//                        input.append(prodcut(name: name, price: price, fDiscount: fDiscount, discout: discout, image: image!))
//                    }
                    input.append(prodcut(name: name, price: price, fDiscount: fDiscount, discout: discout))
                    
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
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText == ""{
            self.result = self.input
        }else{
            result = []
            for prod in input{
                if("\(prod.name)".hasPrefix(searchText)){
                    result.append(prod)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel!.text = "\(result[indexPath.row].name)"
        cell?.detailTextLabel?.text = "\(result[indexPath.row].price)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let dProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailProdcutView") as! detailProductViewController
        dProductViewController.pid = indexPath.row
        
        self.navigationController?.pushViewController(dProductViewController, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getData(){
        let parameters = "";
        let address = "groupen/ios/productList.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
        
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
