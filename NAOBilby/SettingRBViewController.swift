//
//  SettingRBViewController.swift
//  NAOBilby
//
//  Created by Mac on 14/10/2017.
//  Copyright © 2017 YudongGrant. All rights reserved.
//

import Cocoa

class SettingRBViewController: NSViewController {
    @IBOutlet weak var SetAutoTestField: NSTextField!
    
    @IBOutlet weak var SetInitializationTestField: NSTextField!
    
    @IBOutlet weak var SetMainTestField: NSTextField!
    
    @IBOutlet weak var CreateFolderTestField: NSTextField!
    
    @IBOutlet weak var IPAddressTestField: NSTextField!
    
    @IBOutlet weak var SetAutoButton: NSButton!
    
    @IBOutlet weak var SetInitializationButton: NSButton!
    
    @IBOutlet weak var SetMainButton: NSButton!
    
    @IBOutlet weak var CreateFolderButton: NSButton!
    
    @IBOutlet weak var UploadButton: NSButton!
    
    @IBOutlet weak var BackButton: NSButton!
    
    var CreateFolderValue : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func SetAutoButtonTapped(_ sender: Any) { //set autoload.ini file
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose a .ini file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["ini"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                SetAutoTestField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func SetInitializationButtonTapped(_ sender: Any) { // set initialization.py file
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .py file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["py"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                SetInitializationTestField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func SetMainButtonTapped(_ sender: Any) { //set main.py file
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .py file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["py"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                SetMainTestField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func CreateFolderButtonTapped(_ sender: Any) {
        
        let task1 = Process()
        repeat {
            task1.launchPath = "/bin/mkdir"
            task1.arguments = ["/Users/mac/Documents/NAO"]
            task1.launch()
        } while (task1.isRunning == false)
            let task2 = Process()
            task2.launchPath = "/bin/mkdir"
            task2.arguments = ["/Users/mac/Documents/NAO/NAO_Application"]
            task2.launch()
            CreateFolderValue = true
        
        
    }
    
    @IBAction func UploadButtonTapped(_ sender: Any) {
        
        if (IPAddressTestField.stringValue.isEmpty) {
            self.DisplayRobotUploadErrorController()
        } else if (SetMainTestField.stringValue.isEmpty || SetInitializationTestField.stringValue.isEmpty || SetAutoTestField.stringValue.isEmpty || (!CreateFolderValue)) {
            print("bbb")
            self.DisplayRobotUploadErrorController()
        } else if (IPAddressTestField.stringValue.characters.count < 12 || IPAddressTestField.stringValue.characters.count > 13){
            self.DisplayRobotUploadErrorController()
        } else {
            let start = IPAddressTestField.stringValue.index(IPAddressTestField.stringValue.startIndex, offsetBy: 12)
            let b = IPAddressTestField.stringValue.substring(to: start)
            print("aaa")
            if (b != "192.168.1.10") {
            self.DisplayRobotUploadErrorController()
            } else  {
                let destinationpath = "nao@" + IPAddressTestField.stringValue + ":/home/nao"
                let destinationautoloadpath = "nao@" + IPAddressTestField.stringValue + ":/home/nao/naoqi/preferences"
                let destinationmainpath = "nao@" + IPAddressTestField.stringValue + ":/home/nao/NAO_Application"
                let task3 = Process()
                repeat {
                    task3.launchPath = "/usr/bin/scp"
                    task3.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application",destinationpath]
                    task3.launch()
                } while (task3.isRunning == false)
                
                let task6 = Process()
                task6.launchPath = "/usr/bin/scp"
                task6.arguments = [SetMainTestField.stringValue,destinationmainpath]
                task6.launch()
                let task4 = Process()
                task4.launchPath = "/usr/bin/scp"
                task4.arguments = [SetAutoTestField.stringValue,destinationautoloadpath]
                task4.launch()
                let task5 = Process()
                task5.launchPath = "/usr/bin/scp"
                task5.arguments = [SetInitializationTestField.stringValue,destinationpath]
                task5.launch()
                
                print("upload success")
            }
        }
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(self)
        // 我真他妈累啊靠 凌晨两点十二分
    }
    
    func DisplayRobotUploadErrorController() {
        DispatchQueue.main.async {
            let RobotUploadErrorController = self.storyboard?.instantiateController(withIdentifier: "RobotUploadErrorViewController") as! RobotUploadErrorViewController
            
            self.presentViewControllerAsSheet(RobotUploadErrorController)
        }
        
    }
}
