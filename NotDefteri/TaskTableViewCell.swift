//
//  TaskTableViewCell.swift
//  NotDefteri
//
//  Created by ibrahim on 11.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var tastCellTextLabel: UILabel!
    
    @IBOutlet weak var taskContentTextLabel: UILabel!
    
    @IBOutlet weak var taskColorTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tastCellTextLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 27)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
