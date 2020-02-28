import UIKit

class AddHabitNameCell: UITableViewCell {


    @IBOutlet weak var habitNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        habitNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        (viewController(forView: self) as! AddHabitViewController).inputName = textField.text ?? "".trimmingCharacters(in: .whitespaces)
    }
    
}
