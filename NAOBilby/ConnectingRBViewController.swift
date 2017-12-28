//
//  ConnectingRBViewController.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class ConnectingRBViewController: NSViewController {
    
    @IBOutlet weak var IPAddressTextField: NSTextField!
    
    @IBOutlet weak var EthernetButton: NSButton!
    
    @IBOutlet weak var USBButton: NSButton!
    
    @IBOutlet weak var WIFIButton: NSButton!
    
    @IBOutlet weak var ConnectButton: NSButton!
    
    @IBOutlet weak var CancelButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func ConnectButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
    
    
    
}
