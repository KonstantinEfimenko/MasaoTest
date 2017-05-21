//
//  MTAppointment.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/17/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import Foundation

struct MTAppointment {
    
    let id:String
    let type:MTAppointmentType?
    let subject:String?
    let details:String?
    let startDate:Date?
    let endDate:Date?
    let relatedUser:MTUser?
    let isConfirmed:Bool
    
    func timePeriod() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return String(format:"from %@ to %@" ,dateFormatter.string(from: startDate!), dateFormatter.string(from: endDate!))
    }
}
