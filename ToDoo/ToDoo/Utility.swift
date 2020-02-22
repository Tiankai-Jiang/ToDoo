import UIKit
import Firebase

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
    func Noon() -> String {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        
        components.hour = 12
        components.minute = 0
        components.second = 1

        return String(Int(calendar.date(from: components)!.timeIntervalSince1970))
    }

}

func epochTimeToString(_ epoch: Int, _ format: String) -> String{
    let date = Date(timeIntervalSince1970: TimeInterval(epoch))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func epochTimeDaysInterval(_ epochEarlier: Int, _ epochLater: Int) -> Int{
    let calendar = Calendar.current
    let dateEarlier = calendar.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(epochEarlier)))
    let dateLater = calendar.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(epochLater)))
    let components = calendar.dateComponents([.day], from: dateEarlier, to: dateLater)
    return components.day!
}

func loadImages(){
    let storage = Storage.storage()
    if let currentUser = Auth.auth().currentUser?.email{
        let img0 = storage.reference(forURL: "gs://todoo-a1fcd.appspot.com").child(currentUser + "/0.jpg")
        img0.getData(maxSize: 1 * 2048 * 2048) { (data, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                Shared.sharedInstance.profileImage = UIImage(data: data!)!
            }
        }
        
        let img1 = storage.reference(forURL: "gs://todoo-a1fcd.appspot.com").child(currentUser + "/1.jpg")
        img1.getData(maxSize: 1 * 2048 * 2048) { (data, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                Shared.sharedInstance.botImage = UIImage(data: data!)!
            }
        }
    }
}
