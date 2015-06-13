//
//  WSLWebSiteTitle.swift
//  WSLHTMLEntities
//
//  Created by Stephen Darlington on 05/09/2014.
//  Copyright (c) 2014 Wandle Software Limited. All rights reserved.
//

import Foundation

@objc public class WSLWebSiteTitle : NSObject, NSURLSessionDelegate {

    let operationQueue:NSOperationQueue
    let url:NSURL
    
    @objc public init(url:NSURL, operationQueue:NSOperationQueue = NSOperationQueue.mainQueue()) {
        self.operationQueue = operationQueue
        self.url = url
    }
    
    @objc public func title(completionHandler:(title:String?,error:NSError?) -> Void) {
        let update = titleURLSession().dataTaskWithURL(url, completionHandler:{
            data, response, error in
            
            if error != nil {
                completionHandler(title: nil, error: error)
                return
            }
            
            let httpResponse = response as! NSHTTPURLResponse
            if httpResponse.statusCode == 200 {
                
                let returnText:NSString = NSString(data:data, encoding:NSUTF8StringEncoding)!

                let scanner = NSScanner(string: returnText as String)
                scanner.caseSensitive = false
                scanner.scanUpToString("<title", intoString:nil)
                scanner.scanUpToString(">", intoString:nil)
                scanner.scanString(">", intoString:nil)
                var newTitleScanner:NSString?
                scanner.scanUpToString("</title>", intoString:&newTitleScanner)
                var newTitle = newTitleScanner as String?

                if newTitle != nil {
                    newTitle = WSLHTMLEntities.convertHTMLtoString(newTitle)
                    newTitle = newTitle?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                }
                
                completionHandler(title:newTitle,error:nil)
            }
            else {
                completionHandler(title: nil,
                    error: NSError(domain: "WSL", code: 500, userInfo: [ NSLocalizedDescriptionKey : "Server returned non-200 status code" ]))
            }
            
            
            })
        update.resume()
    }

    // TODO: this should probably be shared between calls
    func titleURLSession() -> NSURLSession {
        let app = NSBundle.mainBundle()
        let infoDict = app.infoDictionary!
        let myName:AnyObject? = infoDict["CFBundleDisplayName"]
        var appName:String = "Unknown"
        if myName is String {
            appName = myName as! String
        }
        let myVersion:AnyObject? = infoDict["CFBundleVersion"]
        var appVersionNumber:String = "Unknown"
        if myVersion is String {
            appVersionNumber = myVersion as! String
        }
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        config.HTTPAdditionalHeaders = [
            "Accept" : "text/html",
            "User-Agent" : appName + "/" + appVersionNumber,
        ]
        let urlSession = NSURLSession(configuration: config, delegate: self, delegateQueue: operationQueue)

        return urlSession
    }

}
