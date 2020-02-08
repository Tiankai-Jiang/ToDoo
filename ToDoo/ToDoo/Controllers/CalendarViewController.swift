import UIKit
import EventKit
import KDCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: CalendarView!
    
    @IBOutlet weak var tableView: UITableView!
    
//    var habits: [Habit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.Cells.timelineXib, bundle: nil), forCellReuseIdentifier: K.Cells.timelineCell)
        tableView.separatorStyle = .none
        
        calendarView.style = loadCalendarStyle()
        calendarView.dataSource = self
        calendarView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.calendarTitle
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
//        self.habits = Shared.sharedInstance.habits
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let today = Date().toLocalTime()
        self.calendarView.selectDate(Calendar.current.date(byAdding: .day, value: 1, to: today)!)
        
        self.calendarView.setDisplayDate(today)
    }
}

extension CalendarViewController: CalendarViewDataSource {
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

extension CalendarViewController: CalendarViewDelegate {
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

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.timelineCell, for: indexPath) as! TimelineCell
        cell.finishedTime.text = "2020-02-27"
        cell.habitName.text = "really really really long string"
        cell.timelineIcon.image = UIImage(named: "timeline")
        return cell
    }
    
    
}
