//
//  ViewController.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var MenuImageView: NSImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.MenuImageView.image = NSImage(named: "Robot")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

