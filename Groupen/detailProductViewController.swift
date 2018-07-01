//
//  detailProductViewController.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/26.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import UIKit

class detailProductViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var productID: UILabel!
    @IBOutlet weak var postBy: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var fDiscount: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var groupSize: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var descri: UILabel!
    
    struct prodcut{
        var name:String
        var price:Float
        var fDiscount:Float
        var discout:Float
    }
    
    var pid:Int = 0;
    
    override func viewWillAppear(_ animated: Bool) {
        let parameters = "ProductID=\(pid)";
        let address = "groupen/ios/singleProduct.php"
        connectionManager.post(path: address, params: parameters) { json, error in
            self.completeHandler(json: json, error: error)
        }
    }
    
    func completeHandler(json:[String:Any]?, error:Error?){
        if (error == nil) && (json != nil) {
            if json!["product"] != nil{
                let datas = json!["product"] as! [String:Any]
                    let name = datas["name"] as! String
                    let productID = pid
                    let postBy = datas["user_uid"] as! String
                    let price = (datas["price"] as! NSString).floatValue
                    let fDiscount = (datas["first_discount"] as! NSString).floatValue * 100
                    let discout = (datas["discount"] as! NSString).floatValue * 100
                    let groupSize = (datas["grouping_size"] as! NSString).intValue
                    let startTime = datas["start_time"] as! String
                let endTIme = datas["end_time"] as! String
                let decri = datas["description"] as! String
                
                self.name.text = name
                self.productID.text = "\(productID)"
                self.postBy.text = postBy
                self.price.text = "\(price)"
                self.fDiscount.text = "\(fDiscount) %"
                self.discount.text = "\(discout) %"
                self.groupSize.text = "\(groupSize)"
                self.startTime.text = startTime
                self.endTime.text = endTIme
                self.descri.text = decri
                
            }else{
                let alert = UIAlertController(title: "Internet error", message:"please try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
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
