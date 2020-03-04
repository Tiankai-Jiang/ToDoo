import UIKit
import SwipeCellKit

class HabitCell: SwipeTableViewCell {
    
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.layer.borderColor = UIColor.black.cgColor
//        self.contentView.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
