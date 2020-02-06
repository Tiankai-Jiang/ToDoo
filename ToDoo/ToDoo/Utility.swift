import UIKit
import EventKit
import KDCalendar

// Get TableView reference from a TableViewCell
extension UITableViewCell {
    var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}


// Convert hex color string to UIColor
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


// Get UIViewController reference from its child UIView
func viewController(forView: UIView) -> UIViewController? {
    var nr = forView.next
    while nr != nil && !(nr! is UIViewController) {
        nr = nr!.next
    }
    return nr as? UIViewController
}


// Tap outside of a keyboard to dismiss
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

}

extension Date {

    func Noon() -> String {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        
        components.hour = 12
        components.minute = 0
        components.second = 1

        return String(calendar.date(from: components)!.timeIntervalSince1970)
    }

}

func loadCalendarStyle() -> CalendarView.Style{
    let style = CalendarView.Style()
    
    style.cellShape = .bevel(8.0)
    style.cellColorDefault = UIColor.clear
    style.cellColorToday = UIColor(red:1.00, green:0.84, blue:0.64, alpha:1.00)
    style.cellSelectedBorderColor = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
    style.cellEventColor = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
    style.headerTextColor = UIColor.gray
    style.cellTextColorDefault = UIColor(red: 249/255, green: 180/255, blue: 139/255, alpha: 1.0)
    style.cellTextColorToday = UIColor.orange
    style.cellTextColorWeekend = UIColor(red: 237/255, green: 103/255, blue: 73/255, alpha: 1.0)
    style.cellColorOutOfRange = UIColor(red: 249/255, green: 226/255, blue: 212/255, alpha: 1.0)
        
    style.headerBackgroundColor = UIColor.white
    style.weekdaysBackgroundColor = UIColor.white
    style.firstWeekday = .sunday
    
    style.locale = Locale(identifier: "en_US")

    style.cellFont = UIFont(name: "Helvetica", size: 22.0) ?? UIFont.systemFont(ofSize: 22.0)
    style.headerFont = UIFont(name: "Helvetica", size: 22.0) ?? UIFont.systemFont(ofSize: 22.0)
    style.weekdaysFont = UIFont(name: "Helvetica", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    return style
}
