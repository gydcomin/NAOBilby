//
//  LogInErrorViewController.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class LogInErrorViewController: NSViewController {

    @IBOutlet weak var LogInErrorTextField: NSTextField!
    
    @IBOutlet weak var CancelButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
    }
    
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
}
