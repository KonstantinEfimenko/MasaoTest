//
//  MTAppointmentsListDataProvider.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/17/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

class MTAppointmentListDataProvider: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate{
    
    var showOnlyConfirmed = false {
        didSet {
            useFilters()
        }
    }
    
    var textFilter:String?
    
    var appointments: [MTAppointment]?
    
    weak var collectionView: UICollectionView?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appointments?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MTAppointmentCell
        cell.appointment = appointments?[indexPath.row]
        return cell;
    }
    
    final func reloadData(){
        MTContentLoader.sharedInstance.reloadData(onSuccess: {
            self.useFilters()
        })
    }
    
    final func useFilters(){
        
        var result = MTContentLoader.sharedInstance.appointments
        if showOnlyConfirmed {
            result = result?.filter({(appointment) -> Bool in
                                    appointment.isConfirmed
                            })
        }
        
        if let textFilter = textFilter{
            if textFilter.characters.count > 0 {
                result = result?.filter({(appointment) -> Bool in
                                    if let fullName = appointment.relatedUser?.fullName().lowercased(){
                                        return fullName.contains(textFilter)
                                    }
                                    return false
                                })
            }
        }
        
        self.appointments = result
        self.collectionView?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textFilter = searchText.lowercased()
        useFilters()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
