import UIKit

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var habitInformation: [HabitInfo] = []
    var checkedDays: [Int] = []
    var rowNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: K.Cells.habitDetailXib, bundle: nil), forCellReuseIdentifier: K.Cells.habitDetailCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Shared.sharedInstance.habits[rowNumber].name

    }
}

extension HabitDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.habitDetailCell, for: indexPath) as! HabitDetailCell
        cell.habitInfo = habitInformation[indexPath.row]
        return cell
    }
    
    
}

extension HabitDetailViewController: UITableViewDelegate{
    
}

