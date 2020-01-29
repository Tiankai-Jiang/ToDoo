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
import SwipeCellKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var habits: [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        //        habitTableView.separatorStyle = .none
        loadHabits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.homeTitle
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addClicked))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.object(forKey: K.selectedDayKey) != nil){
            UserDefaults.standard.removeObject(forKey: K.selectedDayKey)
        }
    }
    
    @objc func addClicked(){
        self.performSegue(withIdentifier: K.addHabitSegue, sender: self)
    }
// MARK: - Load Habbits
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
                            if let habitName = data[K.FStore.habitNameField] as? String, let isNotificationOn = data[K.FStore.remindField] as? Bool, let selectedDays = data[K.FStore.remindDaysField] as? [Bool] {
                                self.habits.append(Habit(name: habitName, ifRemind: isNotificationOn, remindDays: selectedDays))
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        if self.habits.count > 1{
                            let indexPath = IndexPath(row: self.habits.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.habitTableViewCell, for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = habits[indexPath.row].name
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension HomeViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        
        //      define the delete button & action
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            let deleteAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
                if let messageSender = Auth.auth().currentUser?.email{
                    self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection).document(self.habits[indexPath.row].name).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            self.tableView.reloadData()
                        }
                    }
                }
            }))
            
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        
        //      define the done button & action
        let doneAction = SwipeAction(style: .destructive, title: "Done") { (action, indexPath) in
            //
        }
        doneAction.backgroundColor = .green
        doneAction.image = UIImage(systemName: "checkmark.circle")
        return [deleteAction, doneAction]
    }
}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
