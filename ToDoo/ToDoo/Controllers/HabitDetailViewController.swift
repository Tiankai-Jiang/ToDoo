import UIKit
import JTAppleCalendar
import Firebase

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var calendar: JTAppleCalendarView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var habitInformation: [HabitInfo] = []
    var checkedDays: [Int] = []
    var rowNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.scrollToHeaderForDate(Date())
        calendar.scrollDirection = .horizontal
        calendar.scrollingMode   = .stopAtEachCalendarFrame
        calendar.showsHorizontalScrollIndicator = false
        
        calendar.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "dateCell")
        
        calendar.register(UINib(nibName: "DateHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "dateHeader")
        
        tableView.register(UINib(nibName: K.Cells.habitDetailXib, bundle: nil), forCellReuseIdentifier: K.Cells.habitDetailCell)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Shared.sharedInstance.habits[rowNumber].name
        navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: Shared.sharedInstance.habits[rowNumber].color)
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.editHabitSegue, sender: self)
    }
    
    
    @IBAction func deletePressed(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
            if let messageSender = Auth.auth().currentUser?.email{
                self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection).document(Shared.sharedInstance.habits[self.rowNumber].name).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AddHabitViewController
        let currentHabit = Shared.sharedInstance.habits[rowNumber]
        destinationVC.inputName = currentHabit.name
        destinationVC.previousName = currentHabit.name
        destinationVC.addedDate = currentHabit.addedDate
        destinationVC.inputColor = currentHabit.color
        destinationVC.isNotificationOn = currentHabit.ifRemind
        destinationVC.checkedInfo = currentHabit.checkedDays
        destinationVC.notificationTime = currentHabit.notificationTime
        destinationVC.ifEdit = true
        Shared.sharedInstance.selectedDays = currentHabit.remindDays
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

extension HabitDetailViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        let startDate = formatter.date(from: "2020 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellColor(cell: cell, cellState: cellState)
    }
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = hexStringToUIColor(hex: "194348")
            cell.dateLabel.isHidden = false
            cell.selectedView.isHidden = false
        } else {
            //cell.dateLabel.textColor = UIColor.gray
            cell.dateLabel.isHidden = true
            cell.selectedView.isHidden = true
        }
    }
    func handleCellColor(cell: DateCell,cellState: CellState) {
        let colorCompleted="a5d296"
        let allDateNoon=Shared.sharedInstance.habits[rowNumber].checkedDays.keys
        
        if allDateNoon.contains(cellState.date.Noon()) {
            cell.selectedView.layer.cornerRadius = cell.selectedView.bounds.width / 2
            cell.selectedView.backgroundColor = hexStringToUIColor(hex: colorCompleted)
            cell.dateLabel.textColor = .white
        }else{
            cell.selectedView.backgroundColor = .white
            cell.dateLabel.textColor = hexStringToUIColor(hex: "194348")
        }
            
        }
    }

extension HabitDetailViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMMM yyyy"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "dateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return true // Based on a criteria, return true or false
    }
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
}
