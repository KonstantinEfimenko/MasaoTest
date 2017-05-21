//
//  MTUser.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/17/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import Foundation

struct MTUser {
    let id:String
    let name:String?
    let surname:String?
    let userPictureUrl:String?
    
    func fullName() -> String {
        return String(format: "%@ %@", name ?? "", surname ?? "")
    }
}
