//
//  OnlineLibraryViewController.swift
//  NAOBilby
//
//  Created by heather on 11/9/17.
//  Copyright © 2017 YudongGrant. All rights reserved.
//

import Cocoa

class OnlineLibraryViewController: NSViewController {

    @IBOutlet weak var TitleLabel: NSTextField!
    
    @IBOutlet weak var SearchField: NSSearchField!
    
    @IBOutlet weak var Behavior1: NSTextField!
    
    @IBOutlet weak var Behavior2: NSTextField!
    
    @IBOutlet weak var Behavior3: NSTextField!
    
    @IBOutlet weak var Behavior4: NSTextField!
    
    @IBOutlet weak var Behavior5: NSTextField!
    
    @IBOutlet weak var Behavior6: NSTextField!
    
    @IBOutlet weak var ResetButton: NSButton!
    
    @IBOutlet weak var DownloadButton: NSButton!
    
    @IBOutlet weak var LogOffButton: NSButton!
    
    @IBOutlet weak var ShowBehaviorButton: NSButton!
    
    @IBOutlet weak var UploadBehaviorButton: NSButton!
    
    @IBOutlet weak var NotificationLabelTextField: NSTextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
    }
   
    @IBAction func SearchBehavior(_ sender: Any) {
    }
    @IBAction func LogOffButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
    
    @IBAction func ResetButtonTapped(_ sender: Any) {
        Behavior1.stringValue = ""
        Behavior2.stringValue = ""
        Behavior3.stringValue = ""
        Behavior4.stringValue = ""
        Behavior5.stringValue = ""
    }
    
    @IBAction func DownloadButtonTapped(_ sender: Any) {
    }
    
    @IBAction func ShowBehaviorButtonTapped(_ sender: Any) {
        
        //1.确定请求路径 verifying url address
        let myURL = URL(string : "http://localhost:8181/showbehavioursinserver")
        //2.创建请求对象
        //请求对象内部默认已经包含了请求头和请求方法（GET）
        //creating request object
        var request = URLRequest(url : myURL!)
        //3.获得会话对象
        let session: URLSession = URLSession.shared
        
        //设置Http请求方法
        //setting HTTP method as GET
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //Defining task, for dealing with request and response
        let task = session.dataTask(with: request){
            (data: Data?,response: URLResponse?,error :Error?) in
            
            // handling response
            do {
                
                //decoding response json into Dictionary
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //setting json value
                if let parseJSON = json {
                    let BehaviorA = parseJSON["behaviour1"] as? String
                    //print(Behavior1!)
                    self.Behavior1.stringValue = BehaviorA!;
                    //print("behaviour1 = \(String(describing: Behavior1!)) ")
                    
                    let BehaviorB = parseJSON["behaviour2"] as? String
                    //print(Behavior2!)
                    self.Behavior2.stringValue = BehaviorB!;
                    //print("behaviour2 = \(String(describing: Behavior2!)) ")
                    
                    let BehaviorC = parseJSON["behaviour3"] as? String
                    //print(Behavior3!)
                    self.Behavior3.stringValue = BehaviorC!;
                    //print("behaviour3 = \(String(describing: Behavior3!)) ")
                    
                    let BehaviorD = parseJSON["behaviour4"] as? String
                    //print(Behavior4!)
                    self.Behavior4.stringValue = BehaviorD!;
                    //print("behaviour4 = \(String(describing: Behavior4!)) ")
                    
                    let BehaviorE = parseJSON["behaviour5"] as? String
                    //print(Behavior5!)
                    self.Behavior5.stringValue = BehaviorE!;
                    //print("behaviour5 = \(String(describing: Behavior5!)) ")
                    
                } else {
                    // if errors occur, display LogInErrorViewController
                    //self.DisplayLogInErrorController()
                }
                
            } catch{
                //self.NotificationLabelTextField.stringValue = "Some errors occur, please contact ADMIN"
                print(error)
                print("ddd")
            }
            
        }
        // task starts
        task.resume()
    }
    
    @IBAction func UploadBehaviorButtonTapped(_ sender: Any) {
        
        let Behaviourname1 = Behavior1.stringValue
        let Behaviourname2 = Behavior2.stringValue
        let Behaviourname3 = Behavior3.stringValue
        let Behaviourname4 = Behavior4.stringValue
        let Behaviourname5 = Behavior5.stringValue
        
        if (Behaviourname1.isEmpty) && (Behaviourname2.isEmpty) && (Behaviourname3.isEmpty) && (Behaviourname4.isEmpty) && (Behaviourname5.isEmpty) {
            self.NotificationLabelTextField.stringValue = "Please add at least one Behaviour."
            return
        }
    
        //1.确定请求路径 verifying url address
        let myURL = URL(string : "http://localhost:8181/uploadbehaviours")
        //2.创建请求对象
        //请求对象内部默认已经包含了请求头和请求方法（GET）
        //creating request object
        var request = URLRequest(url : myURL!)
        //3.获得会话对象
        let session: URLSession = URLSession.shared
        
        //设置Http请求方法
        //setting HTTP method as POST
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        //setting JSON 字典
        let postString = ["Behaviourname1":Behaviourname1,"Behaviourname2":Behaviourname2,"Behaviourname3":Behaviourname3,"Behaviourname4":Behaviourname4,"Behaviourname5":Behaviourname5] as [String : String]
        
        //添加httpbody的内容，以JSON形式
        //appending HTTPBODY, using JSON
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
            return
        }
    
        //Defining task, for dealing with request and response
        let task = session.dataTask(with: request){
            (data: Data?,response: URLResponse?,error :Error?) in
            
            // no error occurs
            if error != nil {
                self.NotificationLabelTextField.stringValue = "error!."
                print("error=\(String(describing: error)) ")
                print("aaa")
                return
            }
            
            // handling response
            do {
                
                //decoding response json into Dictionary
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //setting json value for Behaviour1
                if let parseJSON = json {
                    let Behaviourname1ID = parseJSON["returnvalue"] as? String
                    print(Behaviourname1ID!)
                    print("returnvalue = \(String(describing: Behaviourname1ID!)) ")
                    
                    if Behaviourname1ID! == "T" {
                        self.NotificationLabelTextField.stringValue = ""
                        
                    } else{
                        // if BehaviournameID1! == F, Upload error occurs
                        self.NotificationLabelTextField.stringValue = "Please input Correct Behaviour1."
                    }
                    
                } else {
                    // if errors occur, display information
                    self.NotificationLabelTextField.stringValue = "Upload Behaviour1 occur errors."
                }
                
                //setting json value for Behaviour2
//                if let parseJSON = json {
//                    let Behaviourname2ID = parseJSON["returnvalue"] as? String
//                    print(Behaviourname2ID!)
//                    print("returnvalue = \(String(describing: Behaviourname2ID!)) ")
//
//                    if Behaviourname2ID! == "T" {
//                        self.NotificationLabelTextField.stringValue = ""
//
//                    } else{
//                        // if BehaviournameID2! == F, Upload error occurs
//                        self.NotificationLabelTextField.stringValue = "Please input Correct Behaviour2."
//                    }
//
//                } else {
//                    // if errors occur, display information
//                    self.NotificationLabelTextField.stringValue = "Upload Behaviour2 occur errors."
//                }
//
//                //setting json value for Behaviour3
//                if let parseJSON = json {
//                    let Behaviourname3ID = parseJSON["returnvalue"] as? String
//                    print(Behaviourname3ID!)
//                    print("returnvalue = \(String(describing: Behaviourname3ID!)) ")
//
//                    if Behaviourname3ID! == "T" {
//                        self.NotificationLabelTextField.stringValue = ""
//
//                    } else{
//                        // if BehaviournameID3! == F, Upload error occurs
//                        self.NotificationLabelTextField.stringValue = "Please input Correct Behaviour3."
//                    }
//
//                } else {
//                    // if errors occur, display information
//                    self.NotificationLabelTextField.stringValue = "Upload Behaviour3 occur errors."
//                }
//
//                //setting json value for Behaviour4
//                if let parseJSON = json {
//                    let Behaviourname4ID = parseJSON["returnvalue"] as? String
//                    print(Behaviourname4ID!)
//                    print("returnvalue = \(String(describing: Behaviourname4ID!)) ")
//
//                    if Behaviourname4ID! == "T" {
//                        self.NotificationLabelTextField.stringValue = ""
//
//                    } else{
//                        // if BehaviournameID4! == F, Upload error occurs
//                        self.NotificationLabelTextField.stringValue = "Please input Correct Behaviour4."
//                    }
//
//                } else {
//                    // if errors occur, display information
//                    self.NotificationLabelTextField.stringValue = "Upload Behaviour4 occur errors."
//                }
//
//                //setting json value for Behaviour5
//                if let parseJSON = json {
//                    let Behaviourname5ID = parseJSON["returnvalue"] as? String
//                    print(Behaviourname5ID!)
//                    print("returnvalue = \(String(describing: Behaviourname5ID!)) ")
//
//                    if Behaviourname5ID! == "T" {
//                        self.NotificationLabelTextField.stringValue = ""
//
//                    } else{
//                        // if BehaviournameID5! == F, Upload error occurs
//                        self.NotificationLabelTextField.stringValue = "Please input Correct Behaviour5."
//                    }
//
//                } else {
//                    // if errors occur, display information
//                    self.NotificationLabelTextField.stringValue = "Upload Behaviour5 occur errors."
//                }
                
            } catch{
                self.NotificationLabelTextField.stringValue = "Some errors occur, please contact ADMIN"
                print(error)
                print("ddd")
            }
            
        }
        // task starts
        task.resume()
        
    }
    
    
    
}
