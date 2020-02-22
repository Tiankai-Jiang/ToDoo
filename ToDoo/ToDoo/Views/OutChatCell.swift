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
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var message: Message? {
      didSet {
        guard let message = message else {
          return
        }
        
        contentLabel.text = message.body
      }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        textBubble.layer.cornerRadius = 6
    }
    
}
