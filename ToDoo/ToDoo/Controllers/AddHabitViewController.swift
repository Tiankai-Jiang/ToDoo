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
    
    
    @IBOutlet weak var habitNameTextField: UITextField!
    let db = Firestore.firestore()
    
    let addButton = UIBarButtonItem(title: "Add",  style: .plain, target: self, action: #selector(addItem))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      set delegate to check if textField is empty or white spaces only
        habitNameTextField.delegate = self
        
        if habitNameTextField.text!.isEmpty{
            addButton.isEnabled = false
        }
        
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
        
        let habitName = habitNameTextField.text!.trimmingCharacters(in: .whitespaces);
        
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
