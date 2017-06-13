//
//  MTRequestWorker.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 6/11/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

protocol MTRequestWorker {
    
    func parameters() -> Dictionary<String, Any>
    
    func parseResponse(responseJson:Array<[String:String]>) -> Dictionary<String,Any>
    
}
