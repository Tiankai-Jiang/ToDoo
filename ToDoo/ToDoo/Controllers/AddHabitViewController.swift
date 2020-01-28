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
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    let addButton = UIBarButtonItem(title: "Add",  style: .plain, target: self, action: #selector(addItem))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        
//      change back buttton to cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        
//      add right navigation button
        navigationItem.rightBarButtonItem = addButton
        
        self.hideKeyboardWhenTappedAround()
    }

//  return to home scene
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func addItem(){
        let habitName = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddHabitNameCell).habitNameTextField.text!.trimmingCharacters(in: .whitespaces);
        
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            
            habitColRef.document(habitName).getDocument { (document, error) in
                if let document = document, document.exists {
                    self.view.makeToast("A habit with this name already exists", duration: 2.0, position: .top)
                } else {
                    habitColRef.document(habitName).setData([K.FStore.habitNameField: habitName, K.FStore.dateField: Date().timeIntervalSince1970], completion: { (error) in
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
//            cell.collectionView.isUserInteractionEnabled = true
//            cell.collectionView.allowsSelection = true
//            cell.textLabel?.text = "select a color"
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
        
//        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){

          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
}

extension AddHabitViewController: UITableViewDelegate{
    
}
