//
//  MTAppointmentTypeRequestWorker.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 6/11/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

struct MTAppointmentTypeRequestWorker: MTRequestWorker {
    
    func parameters() -> Dictionary<String, Any>{
        return [
            "REQUEST" : [
                "FUNCTION" : "GetDataFrom",
                "OBJECT" : "AppointmentType",
                "UDID" : "UDID1"
            ],
            "CONTENT" : [:]
        ]
    }
    
    func parseResponse(responseJson:Array<[String:String]>) -> Dictionary<String,Any>{
        var result = [String:MTAppointmentType]()
        for dictionary in responseJson {
            if let id = dictionary["Id"]{
                result[id] = MTAppointmentType(id:id,
                                               type:dictionary["Type"],
                                               description:dictionary["Description"])
            }
        }
        return result;
    }

}
