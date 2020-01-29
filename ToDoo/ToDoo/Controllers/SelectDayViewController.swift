//
//  SelectDayViewController.swift
//  ToDoo
//
//  Created by tiankai on 2020-01-28.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit

class SelectDayViewController: UITableViewController {
    
    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var selectedDays: [Bool] = {
        UserDefaults.standard.register(defaults: [K.selectedDayKey : [true, true, true, true, true, true, true]])
        return UserDefaults.standard.object(forKey: K.selectedDayKey) as! [Bool]
    }(){
        didSet {
            UserDefaults.standard.set(selectedDays, forKey: K.selectedDayKey)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.selectDayCell, for: indexPath)
        cell.textLabel?.text = days[indexPath.row]
        cell.accessoryType = selectedDays[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedDays[indexPath.row] = !selectedDays[indexPath.row]
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        print(selectedDays)
    }
    
    @objc func daysSelected(){
        
    }

}
