import JTAppleCalendar
import UIKit

class DateCell: JTAppleCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.isHidden = true
        // Initialization code
    }

}
