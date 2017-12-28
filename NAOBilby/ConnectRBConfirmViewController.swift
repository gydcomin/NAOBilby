//
//  ConnectRBConfirmViewController.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class ConnectRBConfirmViewController: NSViewController {

    @IBOutlet weak var OKButton: NSButton!
    
    @IBOutlet weak var CancelButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(self)
    }
    
    
    @IBAction func OKButtonTapped(_ sender: Any) {
        print("OKBUTTONTAPPED")
        let ConnectingRBViewController = self.storyboard?.instantiateController(withIdentifier: "ConnectingRBViewController") as! ConnectingRBViewController
        self.presentViewControllerAsSheet(ConnectingRBViewController)
        let conn = self.storyboard?.instantiateController(withIdentifier: "ConnectRBConfirmViewController") as! ConnectRBConfirmViewController
        
        self.dismissViewController(conn)
        
    }
}
