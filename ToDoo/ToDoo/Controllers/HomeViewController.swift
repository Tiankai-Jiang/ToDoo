//
//  FirstViewController.swift
//  ToDoo
//
//  Created by tiankai on 2020-01-14.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit
import Toast_Swift
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var habitTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var testArray = [String?]()
    var habits: [Habit] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.homeTitle
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addItem))
        
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHabits()
    }
    
    func loadHabits(){
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            
            habitColRef.order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
                self.habits = []
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    if let snapshotDocument = querySnapshot?.documents{
                        for doc in snapshotDocument {
                            let data = doc.data()
                            if let habitName = data[K.FStore.habitNameField] as? String {
                                self.habits.append(Habit(name: habitName))
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.habitTableView.reloadData()
                        if self.habits.count > 1{
                            let indexPath = IndexPath(row: self.habits.count - 1, section: 0)
                            self.habitTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    @objc func addItem(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new habit", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if !textField.text!.trimmingCharacters(in: .whitespaces).isEmpty{
//                self.testArray.append(textField.text!)
                self.habitTableView.reloadData()
                
                if let messageSender = Auth.auth().currentUser?.email{
                    let habitColRef = self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
                    habitColRef.document(textField.text!).setData([K.FStore.habitNameField: textField.text!, K.FStore.dateField: Date().timeIntervalSince1970], completion: { (error) in
                        if let e = error{
                            print(e)
                        }
                    })
                }
            }else{
                self.view.makeToast("Habit name cannot be empty", duration: 2.0, position: .bottom)
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create a new habit"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = habitTableView.dequeueReusableCell(withIdentifier: K.habitTableViewCell, for: indexPath) as! HabitTableViewCell
        
        cell.habitName.text = habits[indexPath.row].name
//        if let habitItem = habits[indexPath.row]?.name{
//            cell.habitName.text = habitItem
//        }else{
//            cell.habitName.text = "No habit added yet"
//        } // useless?
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
