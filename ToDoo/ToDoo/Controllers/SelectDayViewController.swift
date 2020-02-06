import UIKit

class SelectDayViewController: UITableViewController {
    
    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var selectedDays: [Bool] = UserDefaults.standard.object(forKey: K.selectedDayKey) as! [Bool]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(selectedDays, forKey : K.selectedDayKey)
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
    }
    
    @objc func daysSelected(){
        
    }

}
