//
//  MTAppointmentsListDataProvider.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/17/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

class MTAppointmentListDataProvider: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    var textFilter:String?
    var appointments: [MTAppointment]?
    weak var collectionView: UICollectionView?
    let contentLoader = MTContentLoader()
    
    var showOnlyConfirmed = false {
        didSet {
            useFilters()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appointments?.count ?? 0;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MTAppointmentCell
        if let appointment = appointments?[indexPath.row]{
            cell.configure(appointment: appointment)
        }
        return cell;
    }
    
    
    final func reloadData(){
        contentLoader.reloadData(onSuccess: {
            self.useFilters()
        })
    }
    
    
    final func useFilters(){
        
        var result = contentLoader.appointments
        if showOnlyConfirmed {
             result = result?.filter({(appointment) -> Bool in
                                    appointment.isConfirmed
                            })
        }
        
        if let textFilter = textFilter {
            if textFilter.characters.count > 0 {
                 result = result?.filter{
                    $0.relatedUser?.fullName().lowercased().contains(textFilter) ?? false
                }
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
