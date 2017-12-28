//
//  CurrentRBConfigViewController.swift
//  NAOBilby
//
//  Created by heather on 12/9/17.
//  Copyright © 2017 YudongGrant. All rights reserved.
//

import Cocoa
import Foundation

class CurrentRBConfigViewController: NSViewController {
    
    @IBOutlet weak var Behaviour1TextField: NSTextField!
    
    @IBOutlet weak var Behaviour2TextField: NSTextField!
    
    @IBOutlet weak var Behaviour3TextField: NSTextField!
    
    @IBOutlet weak var Behaviour4TextField: NSTextField!
    
    @IBOutlet weak var Behaviour5TextField: NSTextField!
    
    @IBOutlet weak var IPAddressTextField: NSTextField!
    
    @IBOutlet weak var Choose1Button: NSButton!
    
    @IBOutlet weak var Choose2Button: NSButton!
    
    @IBOutlet weak var Choose3Button: NSButton!
    
    @IBOutlet weak var Choose4Button: NSButton!
    
    @IBOutlet weak var Choose5Button: NSButton!
    
    @IBOutlet weak var UploadButton: NSButton!
    
    @IBOutlet weak var CreateFolderButton: NSButton!
    
    
    @IBOutlet weak var SettingNAOButton: NSButton!
    
    @IBOutlet weak var SettingRBNotificationTestField: NSTextField!
    
    @IBOutlet weak var UploadProgressIndicator: NSProgressIndicator!
    
    
    @IBOutlet weak var RobotImageView: NSImageView!
    
    var setNao : Bool = true // for whether nao has been set
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.RobotImageView.image = NSImage(named: "RobotNAO")
        //self.RobotImageCell.image = NSImage(named: "RobotNAO")
        //self.RobotImageCell.image = NSImage(named: "Robot")
        self.SettingNAOButton.isHidden = true
    }
    
    
    @IBAction func Choose1ButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["AAA"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                Behaviour1TextField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func Choose2ButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["AAA"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                Behaviour2TextField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func Choose3ButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file"
        //dialog.canChooseFiles = true
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseDirectories    = true
        dialog.canCreateDirectories    = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes        = ["AAA"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                Behaviour3TextField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func Choose4ButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["AAA"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                Behaviour4TextField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func Choose5ButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["aaa"];
        
        if (dialog.runModal() == NSModalResponseOK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                Behaviour5TextField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
    }
    
    @IBAction func SettingNAOButtonTapped(_ sender: Any) {
        setNao = true
        DispatchQueue.main.async {
            let SettingRBController = self.storyboard?.instantiateController(withIdentifier: "SettingRBViewController") as! SettingRBViewController
            
            self.presentViewControllerAsSheet(SettingRBController)
        }
    }

    @IBAction func UploadButtonTapped(_ sender: Any) {
        if (!setNao) {
            SettingRBNotificationTestField.stringValue = "Please Set NAO first"
        } else if (IPAddressTextField.stringValue.isEmpty) {

            self.DisplayRobotUploadErrorController()
        } else if (Behaviour1TextField.stringValue.isEmpty && Behaviour2TextField.stringValue.isEmpty && Behaviour3TextField.stringValue.isEmpty && Behaviour4TextField.stringValue.isEmpty && Behaviour5TextField.stringValue.isEmpty) {
            self.DisplayRobotUploadErrorController()
        } else if (IPAddressTextField.stringValue.characters.count < 12 || IPAddressTextField.stringValue.characters.count > 13){
            self.DisplayRobotUploadErrorController()
        } else {
            let start = IPAddressTextField.stringValue.index(IPAddressTextField.stringValue.startIndex, offsetBy: 12)
            let b = IPAddressTextField.stringValue.substring(to: start)
            
            if (b != "192.168.1.10") {
                self.DisplayRobotUploadErrorController()
            } else {
                let destinationdirectory = "nao@"+IPAddressTextField.stringValue+":/home/nao"
                var counter : Int = 0
                 //this task has been moved to Create Folder Button Part
                /*
                let task1 = Process()
                task1.launchPath = "/bin/mkdir"
                task1.arguments = ["/Users/mac/Documents/NAO/NAO_Application"]
                task1.launch()
                 */
                let task2 = Process()
                task2.launchPath = "/bin/mkdir"
                task2.arguments = ["/Users/mac/Documents/NAO/NAO_Application/HFB"]
                task2.launch()
                let task3 = Process()
                task3.launchPath = "/bin/mkdir"
                task3.arguments = ["/Users/mac/Documents/NAO/NAO_Application/HMB"]
                task3.launch()
                let task4 = Process()
                task4.launchPath = "/bin/mkdir"
                task4.arguments = ["/Users/mac/Documents/NAO/NAO_Application/HRB"]
                task4.launch()
                let task5 = Process()
                task5.launchPath = "/bin/mkdir"
                task5.arguments = ["/Users/mac/Documents/NAO/NAO_Application/LFRB"]
                task5.launch()
                let task6 = Process()
                task6.launchPath = "/bin/mkdir"
                task6.arguments = ["/Users/mac/Documents/NAO/NAO_Application/RFLB"]
                task6.launch()
                
                
                if (!Behaviour1TextField.stringValue.isEmpty) {
                    let behaviour1path = Behaviour1TextField.stringValue + "/"
                    let task13 = Process()
                    task13.launchPath = "/bin/rm"
                    task13.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application/HFB/"]
                    task13.launch()
                    let task7 = Process()
                    task7.launchPath = "/bin/cp"
                    task7.arguments = ["-r",behaviour1path,"/Users/mac/Documents/NAO/NAO_Application/HFB"]
                    task7.launch()
                    
                    counter += 1
                }
                
                if (!Behaviour2TextField.stringValue.isEmpty){
                    let behaviour2path = Behaviour2TextField.stringValue + "/"
                    let task14 = Process()
                    task14.launchPath = "/bin/rm"
                    task14.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application/HMB/"]
                    task14.launch()
                    let task8 = Process()
                    task8.launchPath = "/bin/cp"
                    task8.arguments = ["-r",behaviour2path,"/Users/mac/Documents/NAO/NAO_Application/HMB"]
                    task8.launch()
                    //print("bbb")
                    counter += 1
                    //小哥别改需求好不好
                }
                
                if (!Behaviour3TextField.stringValue.isEmpty){
                    let behaviour3path = Behaviour4TextField.stringValue + "/"
                    let task15 = Process()
                    task15.launchPath = "/bin/rm"
                    task15.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application/HRB/"]
                    task15.launch()
                    let task9 = Process()
                    task9.launchPath = "/bin/cp"
                    task9.arguments = ["-r",behaviour3path,"/Users/mac/Documents/NAO/NAO_Application/HRB"]
                    task9.launch()
                    print("aaa")
                    counter += 1
                }
                
                if (!Behaviour4TextField.stringValue.isEmpty){
                    let behaviour4path = Behaviour4TextField.stringValue + "/"
                    let task16 = Process()
                    task16.launchPath = "/bin/rm"
                    task16.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application/LFRB/"]
                    task16.launch()
                    let task10 = Process()
                    task10.launchPath = "/bin/cp"
                    task10.arguments = ["-r",behaviour4path,"/Users/mac/Documents/NAO/NAO_Application/LFRB"]
                    task10.launch()
                    counter += 1
                    // 我真他妈累啊靠
                }
                
                if (!Behaviour5TextField.stringValue.isEmpty){
                    
                    let behaviour5path = Behaviour5TextField.stringValue + "/"
                    let task17 = Process()
                    task17.launchPath = "/bin/rm"
                    task17.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application/RFLB/"]
                    task17.launch()
                    let task11 = Process()
                    task11.launchPath = "/bin/cp"
                    task11.arguments = ["-r",behaviour5path,"/Users/mac/Documents/NAO/NAO_Application/RFLB"]
                    task11.launch()
                    print("aaa")
                    counter += 1
                    
                }
                
                if (counter > 0) {
                    let task12 = Process()
                    task12.launchPath = "/usr/bin/scp"
                    task12.arguments = ["-r","/Users/mac/Documents/NAO/NAO_Application/",destinationdirectory]
                    task12.launch()
                } // counter ends
            } // check b if ends
            } // whole loop ends
    } // function ends
    
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
    }
    
    
    
    
    
    func DisplayRobotUploadErrorController() {
        DispatchQueue.main.async {
            let RobotUploadErrorController = self.storyboard?.instantiateController(withIdentifier: "RobotUploadErrorViewController") as! RobotUploadErrorViewController
            
            self.presentViewControllerAsSheet(RobotUploadErrorController)
        }
        
    }
    
    
}
