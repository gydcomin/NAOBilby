//
//  MenuViewController.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class MenuViewController: NSViewController {
    
    @IBOutlet weak var ConnectServerButton: NSButton!
    
    @IBOutlet weak var ConnectRobotButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func ConnectServerButtonTapped(_ sender: Any) {
        print("ConnectServerButtonTapped")
    }
    
    @IBAction func ConnectRobotButtonTapped(_ sender: Any) {
        print("ConnectRobotButtonTapped")
    }
    
}
