//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//    Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import MySQL
import mysqlclient
import Cocoa
import PerfectMustache
import Foundation

let testHost = "127.0.0.1"
let testUser = "root"
// PLEASE change to whatever your actual password is before running these tests
let testPassword = "12345678"
let testSchema = "Schema_NAO"



public class UserInfo : JSONConvertibleObject{
    var User_Name : String = ""
    var User_Password : String = ""
    var User_Authority : Int = 0
    
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
    
    
    static let registerName = "person"
    
    override public func setJSONValues(_ values: [String : Any]) {
        self.User_Name        = getJSONValue(named: "firstName", from: values, defaultValue: "")
        self.User_Password        = getJSONValue(named: "lastName", from: values, defaultValue: "")
    }
    override public func getJSONValues() -> [String : Any] {
        return [
            "Username": User_Name,
            "UserPassword": User_Password,
            "UserAuthority": User_Authority
        ]
    }
}

public class Behav_Info : JSONConvertibleObject{
    var Be_ID : Int = 0
    var Be_Name : String = ""
    var Be_Code : String = ""
    var Be_Description : String = ""
    var Be_EditDate : Int = 0
    var Be_Tags : String = ""
    var Be_Type : String = ""
    var Be_Username : String = ""
    
    func SetBe_ID(Be_ID : Int) -> Void {
        self.Be_ID = Be_ID
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
    
    func GetBe_ID() -> Int {
        return self.Be_ID
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

func returnJSONMessage(message : String, response : HTTPResponse ) {
    do {
        try response.setBody(json: ["message" : message, "test" : "Testvolume1"])
            .setHeader(.contentType , value: "application/json")
            .completed()
    } catch  {
        response.setBody(string: "Error Handling Request : \(error)")
            .completed(status: .internalServerError)
    }
}


public func useMysql(_ request: HTTPRequest, response: HTTPResponse) {
    let dataMysql = MySQL()
    //建立UserInfo对象
    let obj1 = UserInfo()
    let obj2 = UserInfo()
    let json = request.postBodyString!
    do {
        let incoming = try json.jsonDecode() as! [String : String]
        obj1.SetUser_Name(User_Name: incoming["Username"]!)
        obj1.SetUser_Password(User_Password: incoming["Password"]!)
        print(obj1.GetUser_Name())
        print(obj1.GetUser_Password())
    } catch {
        print("Error")
    }
    
    // connecting database
    guard dataMysql.connect(host: testHost, user: testUser, password: testPassword ) else {
        Log.info(message: "Failure connecting to data server \(testHost)")
        return
    }
    
    defer {
        dataMysql.close()  // defer ensures we close our db connection at the end of this request
    }
    
    //set database to be used, this example assumes presence of a users table and run a raw query, return failure message on a error
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from Users limit 1") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        
        return
    }
    
    //store complete result set
    let results = dataMysql.storeResults()
    
    //setup an array to store results
    
    var resultArray = [[String!]]()
    
    resultArray.append((results?.next())! as! [String])
    
    var value : String = "Yes"
    obj2.SetUser_Name(User_Name: resultArray[0][0])
    obj2.SetUser_Password(User_Password: resultArray[0][1])
    
    if (obj1.GetUser_Name()==obj2.GetUser_Name()) && (obj1.GetUser_Password()==obj2.GetUser_Password()) {
        value = "T"
    } else {
        value = "F"
    }
    
    
    let postString = ["returnvalue" : value] as [String : String]
    
    do {
        try response.setBody(json: postString)
            .setHeader(.contentType , value: "application/json")
            .completed()
    } catch  {
        response.setBody(string: "Error Handling Request : \(error)")
            .completed(status: .internalServerError)
    }
    
    
}

public func showBehavioursInServer(_ request: HTTPRequest, response: HTTPResponse){
    let dataMysql = MySQL()
    var behaviour1 = Behav_Info()
    var behaviour2 = Behav_Info()
    var behaviour3 = Behav_Info()
    var behaviour4 = Behav_Info()
    var behaviour5 = Behav_Info()
    
    guard dataMysql.connect(host: testHost, user: testUser, password: testPassword ) else {
        Log.info(message: "Failure connecting to data server \(testHost)")
        return
    }
    
    defer {
        dataMysql.close()  // defer ensures we close our db connection at the end of this request
    }
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from Behaviour where ID='1'") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }
    //store complete result set
    let resultsfor1 = dataMysql.storeResults()
    //print(results)
    //setup an array to store results
    var resultArray = [[String!]]()
    resultArray.append((resultsfor1?.next())! as! [String])
    /*
     resultArray.append((resultsfor1?.next())! as! [String])
     behaviour1.SetBe_Name(Be_Name: resultArray[0][1]!)
     behaviour1.SetBe_Username(Be_Username: resultArray[0][7]!)
     behaviour2.SetBe_Name(Be_Name: resultArray[1][1]!)
     behaviour2.SetBe_Username(Be_Username: resultArray[1][7]!)
     behaviour3.SetBe_Name(Be_Name: resultArray[2][1]!)
     behaviour3.SetBe_Username(Be_Username: resultArray[2][7]!)
     behaviour4.SetBe_Name(Be_Name: resultArray[3][1]!)
     behaviour4.SetBe_Username(Be_Username: resultArray[3][7]!)
     behaviour5.SetBe_Name(Be_Name: resultArray[4][1]!)
     behaviour5.SetBe_Username(Be_Username: resultArray[4][7]!)
     */
    
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from Behaviour where ID='2'") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }
    
    let resultsfor2 = dataMysql.storeResults()
    resultArray.append((resultsfor2?.next())! as! [String])
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from Behaviour where ID='3'") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }
    
    let resultsfor3 = dataMysql.storeResults()
    resultArray.append((resultsfor3?.next())! as! [String])
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from Behaviour where ID='4'") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }
    
    let resultsfor4 = dataMysql.storeResults()
    resultArray.append((resultsfor4?.next())! as! [String])
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: "select * from Behaviour where ID='5'") else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        return
    }
    
    let resultsfor5 = dataMysql.storeResults()
    resultArray.append((resultsfor5?.next())! as! [String])
    //setting behaviors name
    behaviour1.SetBe_Name(Be_Name: resultArray[0][1]!)
    behaviour1.SetBe_Username(Be_Username: resultArray[0][7]!)
    behaviour2.SetBe_Name(Be_Name: resultArray[1][1]!)
    behaviour2.SetBe_Username(Be_Username: resultArray[1][7]!)
    behaviour3.SetBe_Name(Be_Name: resultArray[2][1]!)
    behaviour3.SetBe_Username(Be_Username: resultArray[2][7]!)
    behaviour4.SetBe_Name(Be_Name: resultArray[3][1]!)
    behaviour4.SetBe_Username(Be_Username: resultArray[3][7]!)
    behaviour5.SetBe_Name(Be_Name: resultArray[4][1]!)
    behaviour5.SetBe_Username(Be_Username: resultArray[4][7]!)
    
    print(behaviour1.GetBe_Name(),behaviour1.GetBe_Username(),behaviour4.GetBe_Name(),behaviour5.GetBe_Username())
    
    //setting JSON 字典
    let postString = ["behaviour1":behaviour1.GetBe_Name(),"behaviour2":behaviour2.GetBe_Name(),"behaviour3":behaviour3.GetBe_Name(),"behaviour4":behaviour4.GetBe_Name(),"behaviour5":behaviour5.GetBe_Name()] as [String : String]
    
    do {
        print("response sent")
        try response.setBody(json: postString)
            .setHeader(.contentType , value: "application/json")
            .completed()
        
    } catch  {
        response.setBody(string: "Error Handling Request : \(error)")
            .completed(status: .internalServerError)
    }
}

struct UploadHandler: MustachePageHandler { // all template handlers must inherit from PageHandler
    
    // This is the function which all handlers must impliment.
    // It is called by the system to allow the handler to return the set of values which will be used when populating the template.
    // - parameter context: The MustacheEvaluationContext which provides access to the WebRequest containing all the information pertaining to the request
    // - parameter collector: The MustacheEvaluationOutputCollector which can be used to adjust the template output. For example a `defaultEncodingFunc` could be installed to change how outgoing values are encoded.
    //let dataMysql = MySQL()
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        print("bbbbb")
        var obj = Behav_Info()
        
        #if DEBUG
            print("UploadHandler got request")
        #endif
        var values = MustacheEvaluationContext.MapType()
        // Grab the WebRequest so we can get information about what was uploaded
        let request = contxt.webRequest
        
        // create uploads dir to store files
        let fileDir = Dir(Dir.workingDir.path + "files")
        do {
            try fileDir.create()
            print("create dir success")
        } catch {
            print(error)
        }
        // Grab the fileUploads array and see what's there
        // If this POST was not multi-part, then this array will be empty
        
        if let uploads = request.postFileUploads, uploads.count > 0 {
            // Create an array of dictionaries which will show what was uploaded
            // This array will be used in the corresponding mustache template
            var ary = [[String:Any]]()
            print("aaa")
            
            for upload in uploads {
                ary.append([
                    
                    "fieldName" : upload.fieldName,
                    "contentType": upload.contentType,
                    "fileName": upload.fileName,
                    //"fileSize": upload.fileSize,
                    "tmpFileName": upload.tmpFileName
                    ])
                obj.SetBe_Name(Be_Name: upload.fileName)
                obj.SetBe_Description(Be_Description: upload.fieldName)
                print(upload.fieldName)
                print(upload.contentType)
                print(upload.fileName)
                // move file to webroot
                let thisFile = File(upload.tmpFileName)
                do {
                    let _ = try thisFile.moveTo(path: fileDir.path + upload.fileName, overWrite: true)
                } catch {
                    print(error)
                }
                obj.SetBe_Code(Be_Code: fileDir.path + upload.fileName)
            }
            values["files"] = ary
            values["count"] = ary.count
        }
        
        UploadBehaviourName(BehaviourName: obj.GetBe_Name(),BehaviourCode: obj.GetBe_Code(), BehaviourDescription: obj.GetBe_Description()) //store name into database
        // Grab the regular form parameters
        let params = request.params()
        if params.count > 0 {
            // Create an array of dictionaries which will show what was posted
            // This will not include any uploaded files. Those are handled above.
            var ary = [[String:Any]]()
            print(params.count)
            for (name, value) in params {
                ary.append([
                    "paramName":name,
                    "paramValue":value
                    ])
            }
            values["params"] = ary
            values["paramsCount"] = ary.count
            print(params.count)
        }
        values["title"] = "Upload Enumerator"
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
    
}

public func UploadBehaviourName(BehaviourName : String ,BehaviourCode : String, BehaviourDescription : String) -> Void {
    let dataMysql = MySQL()
    
    if BehaviourName != "" {
        
        
        guard dataMysql.connect(host: testHost, user: testUser, password: testPassword ) else {
            Log.info(message: "Failure connecting to data server \(testHost)")
            return
        }
        
        defer {
            dataMysql.close()  // defer ensures we close our db connection at the end of this request
        }
        
        
        //INSERT INTO `Behaviour` (`Behav_Name`, `Behav_Description`) VALUES ('hello.txt', 'uploadFile');
        var sqlstatement : String = "insert into Behaviour (Behav_Name,Behav_Code,Behav_Description) values (\'\(BehaviourName)\',\'\(BehaviourCode)\',\'\(BehaviourDescription)\')"
        
        
        
        guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: sqlstatement) else {
            Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
            
            return
        }
        
    }
    
    
    
    
}
if let audioUrl = URL(string: "http://freetone.org/ring/stan/iPhone_5-Alarm.mp3") {
    // create your document folder url
    let documentsUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    // your destination file url
    let destination = documentsUrl.appendingPathComponent(audioUrl.lastPathComponent)
    print(destination)
    // check if it exists before downloading it
    if FileManager().fileExists(atPath: destination.path) {
        print("The file already exists at path")
    } else {
        //  if the file doesn't exist
        //  just download the data from your url
        URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) in
            // after downloading your data you need to save it to your destination url
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("audio"),
                let location = location, error == nil
                else { return }
            do {
                try FileManager.default.moveItem(at: location, to: destination)
                print("file saved")
            } catch {
                print(error)
            }
        }).resume()
    }
}

public func uploadBehaviours(_ request: HTTPRequest, response: HTTPResponse) {
    let dataMysql = MySQL()
    var obj3 = Behav_Info()
    var obj4 = Behav_Info()
    var obj5 = Behav_Info()
    var obj6 = Behav_Info()
    var obj7 = Behav_Info()
    let json = request.postBodyString!
    print("aaa")
    do {
        let incoming = try json.jsonDecode() as! [String : String]
        obj3.SetBe_Name(Be_Name: incoming["Behaviourname1"]!)
        obj3.SetBe_ID(Be_ID: 1)
        obj4.SetBe_Name(Be_Name: incoming["Behaviourname2"]!)
        obj4.SetBe_ID(Be_ID: 2)
        obj5.SetBe_Name(Be_Name: incoming["Behaviourname3"]!)
        obj5.SetBe_ID(Be_ID: 3)
        obj6.SetBe_Name(Be_Name: incoming["Behaviourname4"]!)
        obj6.SetBe_ID(Be_ID: 4)
        obj7.SetBe_Name(Be_Name: incoming["Behaviourname5"]!)
        obj7.SetBe_ID(Be_ID: 5)
        //obj3.SetBe_Code(Be_Code: incoming["code"]!)
    } catch {
        print("Error")
    }
    guard dataMysql.connect(host: testHost, user: testUser, password: testPassword ) else {
        Log.info(message: "Failure connecting to data server \(testHost)")
        return
    }
    
    defer {
        dataMysql.close()  // defer ensures we close our db connection at the end of this request
    }
    
    var sqlstatement1 : String = "update Behaviour set Behav_Name=\""
    sqlstatement1.append(obj3.GetBe_Name())
    sqlstatement1.append("\" where ID=\"")
    var idtostring1 = "\(obj3.GetBe_ID())"
    sqlstatement1.append(idtostring1)
    sqlstatement1.append("\"")
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: sqlstatement1) else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        
        return
    }
    var sqlstatement2 : String = "update Behaviour set Behav_Name=\""
    sqlstatement2.append(obj4.GetBe_Name())
    sqlstatement2.append("\" where ID=\"")
    var idtostring2 = "\(obj4.GetBe_ID())"
    sqlstatement2.append(idtostring2)
    sqlstatement2.append("\"")
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: sqlstatement2) else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        
        return
    }
    var sqlstatement3 : String = "update Behaviour set Behav_Name=\""
    sqlstatement3.append(obj5.GetBe_Name())
    sqlstatement3.append("\" where ID=\"")
    var idtostring3 = "\(obj5.GetBe_ID())"
    sqlstatement3.append(idtostring3)
    sqlstatement3.append("\"")
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: sqlstatement3) else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        
        return
    }
    var sqlstatement4 : String = "update Behaviour set Behav_Name=\""
    sqlstatement4.append(obj6.GetBe_Name())
    sqlstatement4.append("\" where ID=\"")
    var idtostring4 = "\(obj6.GetBe_ID())"
    sqlstatement4.append(idtostring4)
    sqlstatement4.append("\"")
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: sqlstatement4) else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        
        return
    }
    var sqlstatement5 : String = "update Behaviour set Behav_Name=\""
    sqlstatement5.append(obj7.GetBe_Name())
    sqlstatement5.append("\" where ID=\"")
    var idtostring5 = "\(obj7.GetBe_ID())"
    sqlstatement5.append(idtostring5)
    sqlstatement5.append("\"")
    
    guard dataMysql.selectDatabase(named: testSchema) && dataMysql.query(statement: sqlstatement5) else {
        Log.info(message: "Failure: \(dataMysql.errorCode()) \(dataMysql.errorMessage())")
        
        return
    }
    print("bb")
    var value : String = "T"
    
    let postString = ["returnvalue" : value] as [String : String]
    
    do {
        try response.setBody(json: postString)
            .setHeader(.contentType , value: "application/json")
            .completed()
    } catch  {
        response.setBody(string: "Error Handling Request : \(error)")
            .completed(status: .internalServerError)
    }
    
    
}


// Create HTTP server.
let server = HTTPServer()


var routes = Routes()
routes.add(method: .post, uri: "/uploadbehaviours", handler: {
    (request: HTTPRequest, response: HTTPResponse) in
    
    let webRoot = request.documentRoot
    mustacheRequest(request: request, response: response, handler: UploadHandler(), templatePath: webRoot + "/response.mustache")
})

routes.add(method: .get, uri: "/t", handler: {
    request, response in
    useMysql(request, response: response)
    //        response.setHeader(.contentType, value: "text/html")
    //        response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    //        response.completed()
}
)
// login function
routes.add(method: .post, uri: "/loginandrew", handler: {
    request, response in
    useMysql(request, response: response)
})
//show behaviour function
routes.add(method: .get, uri: "/showbehavioursinserver", handler: {
    request, response in
    showBehavioursInServer(request, response: response)
})

// upload behaviour function
routes.add(method: .post, uri: "/upload", handler: {
    request, response in
    uploadBehaviours(request, response: response)
})

//This route will be used to fetch data from the mysql database
//routes.add(method: .get, uri: "/use", handler: useMysql)

routes.add(method: .get, uri: "/hello", handler: {
    request, response in
    returnJSONMessage(message: "Message!!!", response: response)
})



// Add the routes to the server.
server.addRoutes(routes)

server.documentRoot = "./webroot"
// Set a listen port of 8181
server.serverPort = 8181

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**






//start server
do {
    // Launch the HTTP server.
    try server.start()
    
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}

