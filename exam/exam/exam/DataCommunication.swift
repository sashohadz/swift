//
//  DataCommunication.swift
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class DataCommunication: NSObject {

    private var session: URLSession!
    var allDataItems: Set<String> = Set<String>()
    
    static let instance: DataCommunication = DataCommunication()
    
    override init() {
        let sessionConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    }

    func registerUser(info:[String:Any?]) {
        
        let username = info[UserDefaultKeys.username.rawValue] as! String
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/zazazo/users/\(username).json") else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONSerialization.data(withJSONObject: info, options: [])
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
    
    func login(with username: String, password: String, completionHandler: @escaping (_ success: Bool)->()) {
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/zazazo/users/\(username).json") else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                if statusCode == 200 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any?]
                        guard let DBUserName = json[UserDefaultKeys.username.rawValue] as? String else {
                            completionHandler(false)
                            return
                        }
                        guard let DBPass = json[UserDefaultKeys.password.rawValue] as? String else {
                            completionHandler(false)
                            return
                        }
                        if DBUserName == username && DBPass == password {
                            completionHandler(true)
                            return
                        }
                        
                    } catch {
                    }
                }
                
                completionHandler(false)
            }
            else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
    
    func placeNewOrder(info:[String:Any?]) {
        
        let username = UserDefaults.standard.string(forKey: UserDefaultKeys.username.rawValue)! as String
        let timestamp = String(Int(Date().timeIntervalSince1970))
        
        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/zazazo/data/\(username)/\(timestamp)/.json") else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONSerialization.data(withJSONObject: info, options: [])
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
    
    func getAllOrdersShallowInfo() {
        
        let username = UserDefaults.standard.string(forKey: UserDefaultKeys.username.rawValue)! as String

        guard let URL = URL(string: "https://softuniswiftexam1.firebaseio.com/zazazo/data/\(username)/.json?shallow=true") else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                if statusCode == 200 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any?]
                        for anItem in json {
                            self.allDataItems.insert(anItem.key)
                        }
                        NotificationCenter.default.post(name: .DataReloaded, object: self)
                        
                    } catch {
                    }
                }
            }
            else {
                print("URL Session Task Failed: %@", error!.localizedDescription)
            }
        })
        task.resume()
    }
    
    
}
