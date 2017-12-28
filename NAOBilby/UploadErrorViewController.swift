//
//  UploadErrorViewController.swift
//  NAOBilby
//
//  Created by LiHO on 2017/10/7.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class UploadErrorViewController: NSViewController {

    @IBOutlet weak var UploadErrorTextField: NSTextField!
    
    @IBOutlet weak var CancelButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
}
