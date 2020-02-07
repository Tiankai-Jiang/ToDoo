import UIKit
import EventKit
import KDCalendar

class HabitDetailViewController: UIViewController {

    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var tableView: UITableView!
    
    var habitInformation: [HabitInfo] = []
    var checkedDays: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.style = loadCalendarStyle()
        calendarView.dataSource = self
        calendarView.delegate = self
        tableView.register(UINib(nibName: K.Cells.habitDetailXib, bundle: nil), forCellReuseIdentifier: K.Cells.habitDetailCell)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkedDays.forEach{
            self.calendarView.selectDate(Date(timeIntervalSince1970: TimeInterval($0)).toLocalTime())
        }
        self.calendarView.selectDate(Date(timeIntervalSince1970: 1580918339.0).toLocalTime())
        self.calendarView.selectDate(Date(timeIntervalSince1970: 1580831939.0).toLocalTime())
//        self.calendarView.setDisplayDate(Date().toLocalTime())
//        self.calendarView.selectDate(Calendar.current.date(byAdding: .day, value: 1, to: today)!)
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

extension HabitDetailViewController: CalendarViewDataSource {
    func headerString(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: date)!)
    }
    
    
      func startDate() -> Date {
          
          var dateComponents = DateComponents()
          dateComponents.month = -1
          
        let today = Date().toLocalTime()
          let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
          
          return threeMonthsAgo
      }
      
      func endDate() -> Date {
          
          var dateComponents = DateComponents()
        
          dateComponents.month = 12
        let today = Date().toLocalTime()
          
          let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
          
          return twoYearsFromNow
    
      }
    
}

extension HabitDetailViewController: CalendarViewDelegate {
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        print("Did Select: \(date)")
    }
    
    
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
           
           print("Did Select: \(date) with \(events.count) events")
           for event in events {
               print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
           }
           
       }
       
       
       func calendar(_ calendar: CalendarView, didLongPressDate date : Date, withEvents events: [CalendarEvent]?) {
           
           if let events = events {
               for event in events {
                   print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
               }
           }
           
           let alert = UIAlertController(title: "Create New Event", message: "Message", preferredStyle: .alert)
           
           alert.addTextField { (textField: UITextField) in
               textField.placeholder = "Event Title"
           }
           
           let addEventAction = UIAlertAction(title: "Create", style: .default, handler: { (action) -> Void in
               let title = alert.textFields?.first?.text
               self.calendarView.addEvent(title!, date: date)
           })
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
           
           alert.addAction(addEventAction)
           alert.addAction(cancelAction)
           
           self.present(alert, animated: true, completion: nil)
           
       }
    
}
