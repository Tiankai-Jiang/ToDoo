import UIKit
import Toast_Swift
import Firebase
import UserNotifications

class AddHabitViewController: UIViewController {
    
    enum AddHabitCells{
        case name
        case color
        case frequency
        case toggle
    }
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var ifEdit = false
    var isNotificationOn = false
    var inputName = ""
    var previousName = ""
    var addedDate = 0
    var checkedInfo: [String: Int] = [:]
    //the key is the timeinterval of the day's noon, the purpose is to check
    //in which day the habit is checked. And the value is the actual time of
    //user's checking.
    var notificationTime = 0
    var inputColor = K.defaultColor
    
    var tableCells: [AddHabitCells] = [.name, .color, .frequency, .toggle]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        //      change back buttton to cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        
        self.hideKeyboardWhenTappedAround()
        
        tableView.register(UINib(nibName: K.Cells.addHabitNameXib, bundle: nil), forCellReuseIdentifier: K.Cells.addHabitNameCell)
        
        tableView.register(UINib(nibName: K.Cells.addHabitColorXib, bundle: nil), forCellReuseIdentifier: K.Cells.addHabitColorCell)
        
        tableView.register(UINib(nibName: K.Cells.addHabitRepeatXib, bundle: nil), forCellReuseIdentifier: K.Cells.addHabitRepeatCell)
        
        tableView.register(UINib(nibName: K.Cells.addHabitToggleXib, bundle: nil), forCellReuseIdentifier: K.Cells.addHabitToggleCell)
        
        timePicker.isHidden = !isNotificationOn
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: inputColor)
        navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: K.colors[inputColor] ?? "000000")
        
        if(ifEdit){
            timePicker.setDate(Date(timeIntervalSince1970: TimeInterval(notificationTime)), animated: false)
        }
    }
    
    //  return to home scene
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    //MARK: -  delete the habit cell
    func popViewControllerss(popViews: Int, animated: Bool = true) {
        if self.navigationController!.viewControllers.count > popViews
        {
            let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - popViews - 1]
            self.navigationController?.popToViewController(vc, animated: animated)
        }
    }
    //MARK: -  add a new habit
    func add(){
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            
            habitColRef.document(inputName).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.view.makeToast("A habit with this name already exists", duration: 2.0, position: .top)
                } else {
                    habitColRef.document(self.inputName).setData([K.FStore.habitNameField: self.inputName, K.FStore.addedDateField: Int(Date().timeIntervalSince1970), K.FStore.remindField: self.isNotificationOn, K.FStore.remindDaysField: Shared.sharedInstance.selectedDays, K.FStore.notificationTimeField: Int(self.timePicker.date.timeIntervalSince1970), K.FStore.colorField: self.inputColor, K.FStore.checkedField: []], completion: { (error) in
                        if let e = error{
                            self.view.makeToast(e.localizedDescription, duration: 2.0, position: .top)
                        }else{
                            self.back()
                        }
                    })
                }
            }
        }
    }
    //MARK: - edit cell
    func editNameUnchanged(){
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            habitColRef.document(self.inputName).setData([K.FStore.habitNameField: self.inputName, K.FStore.addedDateField: addedDate, K.FStore.remindField: self.isNotificationOn, K.FStore.remindDaysField: Shared.sharedInstance.selectedDays, K.FStore.notificationTimeField: Int(self.timePicker.date.timeIntervalSince1970), K.FStore.colorField: self.inputColor, K.FStore.checkedField: checkedInfo], completion: { (error) in
                if let e = error{
                    self.view.makeToast(e.localizedDescription, duration: 2.0, position: .top)
                }else{
                    self.popViewControllerss(popViews: 2)
                }
            })
        }
    }
    
    func editNameChanged(){
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            
            habitColRef.document(inputName).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.view.makeToast("A habit with this name already exists", duration: 2.0, position: .top)
                } else {
                    habitColRef.document(self.inputName).setData([K.FStore.habitNameField: self.inputName, K.FStore.addedDateField: self.addedDate, K.FStore.remindField: self.isNotificationOn, K.FStore.remindDaysField: Shared.sharedInstance.selectedDays, K.FStore.notificationTimeField: Int(self.timePicker.date.timeIntervalSince1970), K.FStore.colorField: self.inputColor, K.FStore.checkedField: self.checkedInfo], completion: { (error) in
                        if let e = error{
                            self.view.makeToast(e.localizedDescription, duration: 2.0, position: .top)
                        }else{
                            self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection).document(self.previousName).delete()
                            self.popViewControllerss(popViews: 2)
                        }
                    })
                }
            }
        }
    }
    // overall controller
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        if(!ifEdit){
            // to check from which sague
            add()
        }else{
            if(inputName == previousName){
                editNameUnchanged()
            }else{
                editNameChanged()
            }
        }
    }
}

extension AddHabitViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespaces)
        
        addButton.isEnabled = !text.isEmpty
        
        return true
    }
}

extension AddHabitViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableCells[indexPath.row] == .frequency){
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: K.selectDaySegue, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableCells[indexPath.row]{
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.addHabitNameCell, for: indexPath) as! AddHabitNameCell
            cell.habitNameTextField.text = inputName
            cell.habitNameTextField.delegate = self;
            if cell.habitNameTextField.text!.isEmpty{
                addButton.isEnabled = false
            }
            cell.habitNameTextField.borderStyle = .none
            return cell
        case .color:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.addHabitColorCell, for: indexPath) as! AddHabitColorCell
            return cell
        case .frequency:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.addHabitRepeatCell, for: indexPath) as! AddHabitRepeatCell
            return cell
        case .toggle:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.addHabitToggleCell, for: indexPath) as! AddHabitToggleCell
            cell.toggle.isOn = isNotificationOn
            return cell
        }
    }
}
extension AddHabitViewController: UITableViewDelegate{
    
}
