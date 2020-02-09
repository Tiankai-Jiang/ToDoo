import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayedHabits:[(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.Cells.timelineXib, bundle: nil), forCellReuseIdentifier: K.Cells.timelineCell)
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.calendarTitle
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
        getDisplayedHabits(date: Date())
        tableView.reloadData()
    }
    
    func getDisplayedHabits(date: Date){
        var res: [String: Int] = [:]
        Shared.sharedInstance.habits.forEach{
            if let checkedTime = $0.checkedDays[date.Noon()]{
                res[$0.name] = checkedTime
            }
        }
        self.displayedHabits = res.sorted { $0.1 < $1.1 }
    }
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedHabits.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.timelineCell, for: indexPath) as! TimelineCell
        if(indexPath.row == 0){
            cell.finishedTime.isHidden = true
            cell.habitName.text = "Today I did  |  " + epochTimeToString(Int(Date().timeIntervalSince1970), "MMM dd,yyyy")
            cell.habitName.font = UIFont.boldSystemFont(ofSize: 20.0)
            cell.timelineIcon.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(scale: .small))?.withTintColor(.black, renderingMode: .alwaysOriginal)

        }else{
            cell.finishedTime.text = epochTimeToString(displayedHabits[indexPath.row - 1].1, "HH:mm")
            cell.habitName.text = displayedHabits[indexPath.row-1].0
            cell.timelineIcon.image = UIImage(named: "timeline")
        }
        return cell
    }
    
    
}
