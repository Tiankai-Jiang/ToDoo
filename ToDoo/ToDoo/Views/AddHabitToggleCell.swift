import UIKit

class AddHabitToggleCell: UITableViewCell {

    @IBAction func switchView(_ sender: UISwitch) {
        (viewController(forView: self.tableView!) as! AddHabitViewController).timePicker.isHidden = !sender.isOn
        (viewController(forView: self.tableView!) as! AddHabitViewController).isNotificationOn = sender.isOn
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
