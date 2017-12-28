//
//  LoginViewController.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    @IBOutlet weak var UsernameTextField: NSTextField!

    @IBOutlet weak var PasswordSecureTextField: NSSecureTextField!
    
    @IBOutlet weak var LogInButton: NSButton!
    
    @IBOutlet weak var CancelButton: NSButton!
    
    @IBOutlet weak var NotificationLabelTextField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.NotificationLabelTextField.stringValue = "ABCD"
        LogInButton.stringValue = " aaaaa"
        // Do view setup here.
    }
    
    @IBAction func LogInButtonTapped(_ sender: Any) {
        
        let Username = UsernameTextField.stringValue
        let Password = PasswordSecureTextField.stringValue
        
        if (Username.isEmpty) || (Password.isEmpty) {
            self.NotificationLabelTextField.stringValue = "Please input Username and Password"
            return
        }
        
        //1.确定请求路径 verifying url address
        let myURL = URL(string : "http://localhost:8181/loginandrew")
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
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //setting JSON 字典
        let postString = ["Username":Username,"Password":Password] as [String : String]
        
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
                self.DisplayLogInErrorController()
                print("error=\(String(describing: error)) ")
                print("aaa")
                return
            }
            
            // handling response
            do {
                
                //decoding response json into Dictionary
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //setting json value
                if let parseJSON = json {
                    let userID = parseJSON["returnvalue"] as? String
                    print(userID!)
                    print("returnvalue = \(String(describing: userID!)) ")
                    
                    //jump to main page
                    if userID! == "T" {
                        //jump to main page
                        self.NotificationLabelTextField.stringValue = ""
                        self.JumpToOnlineLibraryController()
                        
                    } else{
                        // if userID! == F, login error occurs
                        self.NotificationLabelTextField.stringValue = "Please input Correct Username and Password"
                        self.DisplayLogInErrorController()
                    }
                    
                    
                } else {
                    // if errors occur, display LogInErrorViewController
                    self.DisplayLogInErrorController()
                }
                
            } catch{
                self.NotificationLabelTextField.stringValue = "Some errors occur, please contact ADMIN"
                print(error)
                print("ddd")
            }
            
        }
        // task starts
        task.resume()

    }
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
    func DisplayLogInErrorController() {
        DispatchQueue.main.async {
            let LogInErrorController = self.storyboard?.instantiateController(withIdentifier: "LogInErrorViewController") as! LogInErrorViewController
            self.presentViewControllerAsSheet(LogInErrorController)
        }
        
    }
    
    func JumpToOnlineLibraryController() -> Void {
        DispatchQueue.main.async {
            let OnlineLibraryViewController = self.storyboard?.instantiateController(withIdentifier: "OnlineLibraryViewController") as! OnlineLibraryViewController
            self.presentViewControllerAsSheet(OnlineLibraryViewController)
        }
    }
    
    
    
}
