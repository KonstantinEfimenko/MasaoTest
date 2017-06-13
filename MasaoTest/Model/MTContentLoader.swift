//
//  MTContentLoader.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/17/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import Foundation

final class MTContentLoader {
    
    var appointmentTypes:[String:MTAppointmentType]?
    var appointments:[MTAppointment]?
    var users:Dictionary<String,MTUser>?
    let serviceUrl = "http://178.32.4.84:7080/TestCRM/FANetworkService.svc"
    let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    final func reloadData(onSuccess: @escaping ()->Void){
        
        fetchAppointmentTypes(onSuccess: onSuccess)
    }
    
    final func fetchAppointmentTypes(onSuccess: @escaping ()->Void){
        let requestWorker = MTAppointmentTypeRequestWorker()
        
        fetchDataFromServer(parameters: requestWorker.parameters(), success: {array in
            if let array = array as? [[String:String]]{
                self.appointmentTypes = requestWorker.parseResponse(responseJson: array) as? [String : MTAppointmentType]
                self.fetchUsers(onSuccess: onSuccess)
            }
        })
    }
    
    final func fetchUsers(onSuccess: @escaping ()->Void){
        let requestWorker = MTUserRequestWorker()
        
        fetchDataFromServer(parameters: requestWorker.parameters(), success: {array in
            if let array = array as? [[String:String]]{
                self.users = requestWorker.parseResponse(responseJson: array) as? Dictionary<String, MTUser>
            self.fetchAppointments(onSuccess: onSuccess)
            }
        })
    }
    
    final func fetchAppointments(onSuccess: @escaping ()->Void){
        let parameters = [
            "REQUEST" : [
                "FUNCTION" : "GetDataFrom",
                "OBJECT" : "Appointment",
                "UDID" : "UDID1"
            ],
            "CONTENT" : [:]
        ]
        
        fetchDataFromServer(parameters: parameters, success: {array in
            if let array = array as? [[String:String]]{
                var result = [MTAppointment]()
                for dictionary in array {
                    if let id = dictionary["Id"]{
                        let startDate = dictionary["StartDate"] ?? ""
                        let endDate = dictionary["EndDate"] ?? ""
                        result.append(MTAppointment(id:id,
                                        type:self.appointmentTypes?[dictionary["TypeId"]!],
                                        subject:dictionary["Subject"],
                                        details:dictionary["Details"],
                                        startDate:self.dateFormatter.date(from:startDate),
                                        endDate:self.dateFormatter.date(from:endDate),
                                        relatedUser:self.users?[dictionary["RelatedUserId"] ?? ""],
                                        isConfirmed:(dictionary["IsConfirmed"] == "True")))
                    }
                }
                self.appointments = result
            }
            self.appointmentTypes = nil
            self.users = nil
            DispatchQueue.main.sync {
                onSuccess()
            }
        })
    }
    
    func fetchDataFromServer(parameters: Dictionary<String,Any>, success:@escaping ([[String:Any]])->()){
        
        let url = URL(string: String(format: "%@%@", serviceUrl, "/GetDataFrom"))!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: [String:Any]] {
                    guard let content = json["CONTENT"]?["TABLE_DATA"] as? [[String:Any]] else {
                        print("Can't cast JSON")
                        return
                    }
                    success(content)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()

    }
    
}

