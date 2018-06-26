//
//  connectionManager.swift
//  Groupen
//
//  Created by MacBook Pro on 2018/6/23.
//  Copyright © 2018年 Groupen. All rights reserved.
//

import Foundation
class connectionManager{
    
    class func post(path:String, params:String, completion: @escaping (([String:Any]?, Error?)->Void)){
        
//        let ipAddress = "http://192.168.1.3/"
        let ipAddress = "http://10.13.100.184/"
        let address = ipAddress+path
        
        var request = URLRequest(url: URL(string: address)!)
        request.httpMethod = "POST"
        request.httpBody = params.data(using:.utf8)
        
        let task = URLSession.shared.dataTask(with:request) {
            (data, respond, error) in
            if let error = error{
                completion(nil, error)
            }else if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    DispatchQueue.main.async {
                        completion(json, nil)
                    }
                }catch{
                    
                }
                
            }
        }
        task.resume()
    }
    
}
