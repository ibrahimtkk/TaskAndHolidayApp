//
//  HolidayTableViewCell.swift
//  NotDefteri
//
//  Created by ibrahim on 13.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {

    @IBOutlet weak var holidayName: UILabel!
    @IBOutlet weak var holidayDetail: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        holidayName.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
