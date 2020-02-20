//
//  OutChatCell.swift
//  ToDoo
//
//  Created by tiankai on 2020-02-20.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit

class OutChatCell: UITableViewCell {

    @IBOutlet weak var textBubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        textBubble.layer.cornerRadius = 6
    }
    
}
