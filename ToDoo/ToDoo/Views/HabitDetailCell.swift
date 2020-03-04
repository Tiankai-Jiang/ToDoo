//
//  HabitDetailCell.swift
//  ToDoo
//
//  Created by tiankai on 2020-02-06.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit

class HabitDetailCell: UITableViewCell {
    
    @IBOutlet weak var infoName: UILabel!
    @IBOutlet weak var info: UILabel!
    
    var habitInfo: HabitInfo!{
        didSet{
            self.infoName?.text = habitInfo.infoName
            self.info?.text = habitInfo.info
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
