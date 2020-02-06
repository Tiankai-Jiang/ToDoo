import UIKit
import SwipeCellKit

class HabitCell: SwipeTableViewCell {
    
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
