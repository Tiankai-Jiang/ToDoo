//
//  ProfileImageCell.swift
//  ToDoo
//
//  Created by tiankai on 2020-02-21.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit

class ProfileImageCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
