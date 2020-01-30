//
//  AddHabitViewController.swift
//  ToDoo
//
//  Created by tiankai on 2020-01-15.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit
import Toast_Swift
import Firebase

class AddHabitViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var isNotificationOn = false
    var selectedDays: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
//      change back buttton to cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        
        self.hideKeyboardWhenTappedAround()
        
        timePicker.isHidden = true
        
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: K.defaultColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(UserDefaults.standard.object(forKey: K.selectedDayKey) == nil){
            UserDefaults.standard.set(Array(repeating: true, count: 7), forKey : K.selectedDayKey)
        }
        selectedDays = UserDefaults.standard.object(forKey: K.selectedDayKey) as! [Bool]
        
        print()
    }

    
    @IBAction func timePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: timePicker.date)
        print(strDate)
    }
    
    
    //  return to home scene
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let habitName = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddHabitNameCell).habitNameTextField.text!.trimmingCharacters(in: .whitespaces);
        
        let selectedColor = (tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddHabitColorCell).selectedColor
        
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            
            habitColRef.document(habitName).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.view.makeToast("A habit with this name already exists", duration: 2.0, position: .top)
                } else {
                    habitColRef.document(habitName).setData([K.FStore.habitNameField: habitName, K.FStore.dateField: Date().timeIntervalSince1970, K.FStore.remindField: self.isNotificationOn, K.FStore.remindDaysField: self.selectedDays, K.FStore.notificationTimeField: self.timePicker.date.timeIntervalSince1970, K.FStore.colorField: selectedColor], completion: { (error) in
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
        return 4;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 2){
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: K.selectDaySegue, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: K.addHabitNameCell, for: indexPath) as! AddHabitNameCell
            cell.habitNameTextField.delegate = self;
            if cell.habitNameTextField.text!.isEmpty{
                addButton.isEnabled = false
            }
            cell.habitNameTextField.borderStyle = .none
            cell.habitNameTextField.frame.size.height = 80.0
            cell.habitNameTextField.font = .systemFont(ofSize: 20)
            return cell
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: K.addHabitColorCell, for: indexPath) as! AddHabitColorCell
            return cell
        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: K.addHabitRepeatCell, for: indexPath) as! AddHabitRepeatCell
            cell.textLabel?.text = "select repeat frequency"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: K.addHabitToggleCell, for: indexPath) as! AddHabitToggleCell
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            cell.textLabel?.text = "Notification"
            return cell
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        timePicker.isHidden = !sender.isOn
        isNotificationOn = sender.isOn
    }
}

extension AddHabitViewController: UITableViewDelegate{
    
}
