//
//  MTUserRequestWorker.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 6/11/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

class MTUserRequestWorker: MTRequestWorker {
    
    func parameters() -> Dictionary<String, Any>{
        return ["REQUEST" : [
                    "FUNCTION" : "GetDataFrom",
                    "OBJECT" : "User",
                    "UDID" : "UDID1"
                ],
                "CONTENT" : [:]]
    }
    
    func parseResponse(responseJson:Array<[String:String]>) -> Dictionary<String,Any>{
        var result = [String:MTUser]()
        for dictionary in responseJson {
            if let id = dictionary["Id"]{
                result[id] = MTUser(id:id,
                                    name:dictionary["Name"],
                                    surname:dictionary["Surname"],
                                    userPictureUrl:dictionary["UserPictureUrl"])
            }
        }
        return result
    }

}
