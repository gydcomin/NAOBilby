//
//  UploadBehavioursViewController.swift
//  NAOBilby
//
//  Created by heather on 12/10/17.
//  Copyright © 2017 YudongGrant. All rights reserved.
//

import Cocoa
import Foundation
import AppKit

class UploadBehavioursViewController: NSViewController {
    
    @IBOutlet weak var TitleLabelTextField: NSTextField!

    @IBOutlet weak var WordNameLabel: NSTextField!
    
    @IBOutlet weak var BehaviourNameTextField: NSTextField!
    
    @IBOutlet weak var BehaviourPathTextField: NSTextField! //for description
    
    
    @IBOutlet weak var UploadButton: NSButton!
    
    @IBOutlet weak var OKButton: NSButton!
    
    
    @IBOutlet weak var CancelButton: NSButton!
    
    var behaviourPath : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    
    @IBAction func UploadButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .zip file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["zip"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                behaviourPath = path
                BehaviourNameTextField.stringValue = (behaviourPath as NSString).lastPathComponent    //file name
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func OKButtonTapped(_ sender: Any) {
        //let image = NSImage(named: "Robot")
        //let imageData = NSImagePNGRepresentation(image!)
        //let imageData = NSimage
        
        //let filepath : NSURL = NSURL(String : "/Users/mac/Documents/hello.txt")
        if behaviourPath != "" {
            guard let url = URL(string : "http://localhost:8181/uploadbehaviours") else { return } //服务器API
            let cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
            
            //var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 2.0)
            var request = URLRequest(url : url)
            
            let session = URLSession.shared
            
            request.httpMethod = "POST"
            
            let boundary = generateBoundary()//SET boundary constant
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            //request.setValue("multipart/from-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            //let mimeType = "image.png"
            //let mimeType = "text/csv"
            let mimeType = "application/zip" //this 服务器显示是这个
            //self.mimeType = "application/x-zip"
            //self.mimeType = "application/octet-stream"  //this
            //self.mimeType = "application/x-zip-compressed"
            //self.mimeType = "application/zip-compressed"
            //self.mimeType = "multipart/x-zip"
            var fieldName = "uploadFile"
            if BehaviourPathTextField.stringValue != "" {
                fieldName = BehaviourPathTextField.stringValue //for description
            }
            let theFileName = (behaviourPath as NSString).lastPathComponent    //file的名字
            let zipData = try! Data(contentsOf: URL(fileURLWithPath: behaviourPath))
            
            //setting request environment
            let boundaryStart = "--\(boundary)\r\n"
            let boundaryEnd = "--\(boundary)--\r\n"
            let contentDispositionString = "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(theFileName)\"; tmpFileName=\"\(theFileName)\"\r\n"
            let contentTypeString = "Content-Type: \(mimeType)\r\n\r\n"
            
            
            var requestBodyData : Data = Data()
            requestBodyData.append(boundaryStart.data(using: String.Encoding.utf8)!)
            requestBodyData.append(contentDispositionString.data(using: String.Encoding.utf8)!)
            requestBodyData.append(contentTypeString.data(using: String.Encoding.utf8)!)
            requestBodyData.append(zipData)
            requestBodyData.append(boundaryEnd.data(using: String.Encoding.utf8)!)
            request.httpBody = requestBodyData
            
            /*
            var dataString = "--\(boundary)\r\n"
            //设置data的内容
            dataString += "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(theFileName)\"\r\n"
            dataString += "Content-Type: \(mimeType)\r\n\r\n"
            //dataString += NSString.stringWithContentsOfFile(contentsOfFile : filepath, encoding: NSUTF8StringEncoding, error: &error)!
            do{
                try dataString += String(contentsOfFile : behaviourPath, encoding: String.Encoding.utf8)
                dataString.append(<#T##other: String##String#>)
            } catch {
                print(error)
            }
            dataString += "\r\n"
            dataString += "--\(boundary)--\r\n"
            
            print(dataString) // This would allow you to see what the dataString looks like.
            
            // Set the HTTPBody we'd like to submit
            let requestBodyData = dataString.data(using: .utf8)
            request.httpBody = requestBodyData
            //print(request.httpBody)
            */
            let task = session.dataTask(with: request){(data, response, error) in
                if error != nil{
                    print(error!)
                }else{
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    //print("上传完毕：\(str)")
                    print("Upload Success")
                    self.TitleLabelTextField.stringValue = "Upload Success!!!"
                }
            }
            /*
             let task = session.dataTaskWithRequest(request) { (data, response, error) ->Void in
             handler(response: response, data: data, connetionError: error)
             
             */
            task.resume()
            
            
        } else {
            TitleLabelTextField.stringValue = "Please select one file"
        }
        
        
 
    }
    
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}
