//
//  DownloadBehavioursViewController.swift
//  NAOBilby
//
//  Created by heather on 12/10/17.
//  Copyright © 2017 YudongGrant. All rights reserved.
//

import Cocoa

class DownloadBehavioursViewController: NSViewController {

    @IBOutlet weak var TitleLabelTextField: NSTextField!
    
    @IBOutlet weak var NameLabelTextField: NSTextField!
    
    @IBOutlet weak var BehaviourNameTextField: NSTextField!
    
    
    @IBOutlet weak var DownloadButton: NSButton!
    
    @IBOutlet weak var CancelButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func DownloadButtonTapped(_ sender: Any) {
        if BehaviourNameTextField.stringValue != "" {
            let url = URL(string : "http://localhost:8181/\(BehaviourNameTextField.stringValue).zip")
            
            let request = URLRequest(url: url!)
            
            let session = URLSession.shared
            /*
            let downloadTask = session.downloadTask(with: url!, completionHandler: {(location : URL?, response : URLResponse?, error : Error?) -> Void in
                try print(location)
                self.TitleLabelTextField.stringValue = "Download Success!"
                } as! (URL?, URLResponse?, Error?) -> Void)
            */
            let downloadTask = session.downloadTask(with: request, completionHandler: { (location:URL?, response:URLResponse?, error:Error?) -> Void in
                //输出下载文件原来的存放目录
                print("location:\(location)")
                //location位置转换
                let locationPath = location!.path
                //拷贝到用户目录
                let document:String = NSHomeDirectory() + "/Documents/" + self.BehaviourNameTextField.stringValue + ".zip"
                //创建文件管理器
                let fileManager = FileManager.default
                try! fileManager.moveItem(atPath: locationPath, toPath: document)
                print("new location:\(document)")
                self.TitleLabelTextField.stringValue = "Download Success!"
            })
            
            downloadTask.resume()
            
            //self.TitleLabelTextField.stringValue = "Download Success!"
        } else {
            TitleLabelTextField.stringValue = "Please input Behaviour Name!"
        }
        
        
    }
 
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
    
    
}
