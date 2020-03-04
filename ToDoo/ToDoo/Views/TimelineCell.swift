import UIKit

class TimelineCell: UITableViewCell {

    @IBOutlet weak var timelineIcon: UIImageView!
    
    @IBOutlet weak var finishedTime: UILabel!
    
    
    @IBOutlet weak var habitName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
