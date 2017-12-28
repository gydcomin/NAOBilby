//
//  UserInfo.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class UserInfo: NSObject {
    var User_Name : String
    var User_Password : String
    var User_Authority : Int
    
    init(User_Name : String, User_Password:String, User_Authority:Int) {
        self.User_Name = User_Name
        self.User_Password = User_Password
        self.User_Authority = User_Authority
    }
    
    func GetUser_Name() -> String {
        return User_Name
    }
    
    func GetUser_Password() -> String {
        return User_Password
    }
    
    func GetUser_Authority() -> Int {
        return User_Authority
    }
    func SetUser_Name(User_Name : String) -> Void {
        self.User_Name = User_Name
    }
    func SetUser_Password(User_Password : String) -> Void {
        self.User_Password = User_Password
    }
    func SetUser_Authority(User_Authority : Int) -> Void {
        self.User_Authority = User_Authority
    }

}
