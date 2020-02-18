import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    

    @IBOutlet weak var calendar: JTAppleCalendarView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayedHabits:[(String, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.scrollToDate(Date())
        calendar.scrollDirection = .horizontal
        calendar.scrollingMode   = .stopAtEachCalendarFrame
        calendar.showsHorizontalScrollIndicator = false
        calendar.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "dateCell")
        
        calendar.register(UINib(nibName: "DateHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "dateHeader")
        
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
        calendar.reloadData()
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

extension CalendarViewController: JTAppleCalendarViewDataSource {
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
        handleCellSelected(cell: cell, cellState: cellState)
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
    func handleCellColor(cell: DateCell, cellState: CellState) {
        if cellState.date <= Date(){
            let colorList=["ff8080","ffba92","1fab89"] // no complete, half, all
            cell.selectedView.backgroundColor = hexStringToUIColor(hex: colorList[checkIfDateCompleted(MidOfTheDate: cellState.date.Noon())])
            cell.dateLabel.textColor = .white
        }
    }
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius = cell.selectedView.bounds.width / 2
            cell.selectedView.backgroundColor = hexStringToUIColor(hex: "c6f1d6")
        } else {
            cell.selectedView.layer.cornerRadius = cell.selectedView.bounds.width / 2
            cell.selectedView.backgroundColor = .white
        }
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
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
func checkIfDateCompleted(MidOfTheDate: String) -> Int{
    // 0 means nothing, 1 means half ,2 means all
    var totalNum : Int = 0
    var completeNum : Int = 0
    Shared.sharedInstance.habits.forEach {
        if Date(timeIntervalSince1970: TimeInterval($0.addedDate)).Noon() <= MidOfTheDate {
            totalNum+=1
            if $0.checkedDays[MidOfTheDate] != nil{
                completeNum+=1
            }
        }
    }
    if completeNum == 0{
        return 0
    }
    else if totalNum > completeNum{
        return 1
    }
    else if totalNum == completeNum{
        return 2
    }
    else{
        return -1
    }
}
