//
//  RobotUploadErrorViewController.swift
//  NAOBilby
//
//  Created by Mac on 13/10/2017.
//  Copyright © 2017 YudongGrant. All rights reserved.
//

import Cocoa

class RobotUploadErrorViewController: NSViewController {
    @IBOutlet weak var ErrorMessageTestField: NSTextField!
    
    @IBOutlet weak var BackButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
}
