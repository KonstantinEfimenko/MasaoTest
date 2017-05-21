//
//  MTAppointmentCell.swift
//  MasaoTest
//
//  Created by Konstantin Efimenko on 5/20/17.
//  Copyright © 2017 Konstantin Efimenko. All rights reserved.
//

import UIKit

class MTAppointmentCell: UICollectionViewCell {
    
    @IBOutlet weak var appointmentTypeLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var relatedUserLabel: UILabel!
    
    var appointment: MTAppointment? {
        didSet{
            self.fillValues()
        }
    }
    
    final func fillValues(){
        if let appointment = appointment {
            appointmentTypeLabel.text = appointment.type?.type
            subjectLabel.text = appointment.subject
            detailsLabel.text = appointment.details
            timePeriodLabel.text = appointment.timePeriod()
            relatedUserLabel.text = appointment.relatedUser?.fullName()
            self.contentView.backgroundColor = appointment.isConfirmed ? UIColor.lightGray : UIColor.white
        }
    }
}
