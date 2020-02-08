import UIKit

class SelectDayViewController: UITableViewController {
    
    let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
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
        cell.accessoryType = Shared.sharedInstance.selectedDays[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Shared.sharedInstance.selectedDays[indexPath.row] = !Shared.sharedInstance.selectedDays[indexPath.row]
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func daysSelected(){
        
    }

}
