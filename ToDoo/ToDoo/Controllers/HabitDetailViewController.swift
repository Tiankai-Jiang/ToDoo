import UIKit
import JTAppleCalendar

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var calendar: JTAppleCalendarView!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        cell.dateLabel.textColor = hexStringToUIColor(hex: Calendar.current.isDateInWeekend(cellState.date) ? "f15c5c" : "194348")
    }
    func handleCellColor(cell: DateCell,cellState: CellState) {
        let colorCompleted="1fab89"
        let allDateNoon=Shared.sharedInstance.habits[rowNumber].checkedDays.keys
        
        if allDateNoon.contains(cellState.date.Noon()) {
            cell.selectedView.layer.cornerRadius = cell.selectedView.bounds.width / 2
            cell.selectedView.backgroundColor = hexStringToUIColor(hex: colorCompleted)
            cell.dateLabel.textColor = .white
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
