//
//  BehavInfo.swift
//  NAOBilby
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 YudongGrant. All rights reserved.
//

import Cocoa

class BehavInfo: NSObject {
    var Be_Name : String
    var Be_Code : String
    var Be_Description : String
    var Be_EditDate : Int
    var Be_Tags : String
    var Be_Type : String
    var Be_Username : String
    
    init(Be_Name : String,Be_Code : String,Be_Description : String,Be_EditDate : Int,Be_Tags : String,Be_Type : String,Be_Username : String) {
        self.Be_Code = Be_Code
        self.Be_Name = Be_Name
        self.Be_Description = Be_Description
        self.Be_EditDate = Be_EditDate
        self.Be_Tags = Be_Tags
        self.Be_Type = Be_Type
        self.Be_Username = Be_Username
    }
    
    func SetBe_Name(Be_Name : String) -> Void {
        self.Be_Name = Be_Name
    }
    
    func SetBe_Code(Be_Code : String) -> Void {
        self.Be_Code = Be_Code
    }
    
    func SetBe_Description(Be_Description : String) -> Void {
        self.Be_Description = Be_Description
    }
    
    func SetBe_EditDate(Be_EditDate : Int) -> Void {
        self.Be_EditDate = Be_EditDate
    }
    
    func SetBe_Tags(Be_Tags : String) -> Void {
        self.Be_Tags = Be_Tags
    }
    
    func SetBe_Type(Be_Type : String) -> Void {
        self.Be_Type = Be_Type
    }
    
    func SetBe_Username(Be_Username : String) -> Void {
        self.Be_Username = Be_Username
    }
    
    func GetBe_Name() -> String {
        return self.Be_Name
    }
    
    func GetBe_Code() -> String {
        return self.Be_Code
    }
    
    func GetBe_Description() -> String {
        return self.Be_Description
    }
    
    func GetBe_EditDate() -> Int {
        return self.Be_EditDate
    }
    
    func GetBe_Tags() -> String {
        return self.Be_Tags
    }
    
    func GetBe_Type() -> String {
        return self.Be_Type
    }
    
    func GetBe_Username() -> String {
        return self.Be_Username
    }
    

}
