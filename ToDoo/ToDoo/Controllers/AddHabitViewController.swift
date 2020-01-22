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
        
        habitNameTextField.delegate = self
        
        if habitNameTextField.text!.isEmpty{
            addButton.isEnabled = false
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(back))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc func back(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func addItem(){
        
        let habitName = habitNameTextField.text!.trimmingCharacters(in: .whitespaces);
        
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            habitColRef.document(habitName).setData([K.FStore.habitNameField: habitName, K.FStore.dateField: Date().timeIntervalSince1970], completion: { (error) in
                if let e = error{
                    print(e)
                }else{
                    self.back()
                }
            })
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
