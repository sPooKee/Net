//
//  ResponseSerialization.swift
//  Net
//
//  Created by Le Van Nghia on 7/31/14.
//  Copyright (c) 2014 Le Van Nghia. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ResponseData
{
    var urlResponse : NSURLResponse
    var data: NSData

    init(response: NSURLResponse, data: NSData) {
        self.urlResponse = response
        self.data = data
    }

    /**
    *  parse json with urlResponse
    *
    *  @param NSErrorPointer
    *
    *  @return json dictionary
    */
    func json(error: NSErrorPointer = nil) -> JSON? {
        if let httpResponse = urlResponse as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200{
                let jsonData = JSON(data: data)
                return jsonData
            }
            else if error != nil {
                error.memory = NSError(domain: "HTTP_ERROR_CODE", code: httpResponse.statusCode, userInfo: nil)
            }
        }
        return nil
    }

    /**
    *  convert urlResponse to image
    *
    *  @return UIImage
    */
    func image(error: NSErrorPointer = nil) -> UIImage? {
        if let httpResponse = urlResponse as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 && data.length > 0 {
                return UIImage(data: data)
            }
            else if error != nil {
                error.memory = NSError(domain: "HTTP_ERROR_CODE", code: httpResponse.statusCode, userInfo: nil)
            }
        }
        return nil
    }

    /**
    *  parse xml
    *
    *  @param NSXMLParserDelegate
    *
    *  @return
    */
    func parseXml(delegate: NSXMLParserDelegate, error: NSErrorPointer = nil) -> Bool {
        if let httpResponse = urlResponse as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                let xmlParser = NSXMLParser(data: data)
                xmlParser.delegate = delegate
                xmlParser.parse()
                return true
            }
            else if error != nil {
                error.memory = NSError(domain: "HTTP_ERROR_CODE", code: httpResponse.statusCode, userInfo: nil)
            }
        }
        return false
    }
}
