//
//  MTAppointmentsListViewController.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/17/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

class MTAppointmentsListViewController: UIViewController {
    
    let dataProvider = MTAppointmentListDataProvider()
    @IBOutlet weak var confirnedSwitcher: UISwitch!
    @IBOutlet weak var nameSeachBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.collectionView = collectionView
        collectionView.dataSource = dataProvider
        collectionView.delegate = dataProvider
        nameSeachBar.delegate = dataProvider
        dataProvider.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onConfirmedSwitcherValueChanged(_ sender: UISwitch) {
        dataProvider.showOnlyConfirmed = sender.isOn
    }

}

