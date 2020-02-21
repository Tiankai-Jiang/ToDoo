import UIKit
import Toast_Swift
import Firebase
import SwipeCellKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.Cells.habitXib, bundle: nil), forCellReuseIdentifier: K.Cells.habitCell)
        
        tableView.separatorStyle = .none
        loadHabits()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.homeTitle
        self.tabBarController?.navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: "58C9B9")
            self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addClicked))
        self.navigationController?.navigationBar.barTintColor = nil
        loadBadge()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == K.habitDetailSegue){
            let destinationVC = segue.destination as! HabitDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.rowNumber = indexPath.row
                destinationVC.habitInformation = calculateHabitInfo(at: indexPath.row)
                Shared.sharedInstance.habits[indexPath.row].checkedDays.forEach{
                    destinationVC.checkedDays.append($1)
                }
            }
        }else if(segue.identifier == K.addHabitSegue){
            Shared.sharedInstance.selectedDays = Array(repeating: true, count: 7)
        }
    }
    
    @objc func addClicked(){
        self.performSegue(withIdentifier: K.addHabitSegue, sender: self)
    }
    
    func setReminder(habit: Habit){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "ToDoo! " + habit.name + "!"
        content.body = "It is time to finish your goal!"
        content.sound = .default
        for i in 0...6{
            if(habit.remindDays[i]){
                var dateInfo = DateComponents()
                let components = Calendar.current.dateComponents([.hour, .minute], from: Date(timeIntervalSince1970: TimeInterval(habit.notificationTime)))
                dateInfo.hour = components.hour!
                dateInfo.minute = components.minute!
                dateInfo.weekday = i + 1
                dateInfo.timeZone = .current
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                let request = UNNotificationRequest(identifier: habit.name + String(i + 1), content: content, trigger: trigger)
                center.add(request) { (error : Error?) in
                    if let e = error {
                        print(e.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getIfCheckedArray(_ checked: [String: Int], _ start: Int) -> [Bool]{
        let interval = 1 + epochTimeDaysInterval(start, Int(Date().timeIntervalSince1970))
        var ifChecked: Array<Bool> = Array(repeating: false, count: interval)
        checked.forEach{
            ifChecked[epochTimeDaysInterval(start, $1)] = true
        }
        return ifChecked
    }
    
    func getLongestStreak(_ ifChecked: [Bool]) -> Int{
        var cur = 0
        var max = 0
        for v in ifChecked{
            cur = v ? cur + 1 : 0
            max = cur > max ? cur : max
        }
        return max
    }
    
    func getCurrentStreak(_ ifChecked: [Bool]) -> Int{
        if(ifChecked.count == 1){
            return ifChecked[0] ? 1 : 0
        }else{
            var res = 0
            for v in (0 ... ifChecked.count - 2).reversed(){
                if(ifChecked[v]){
                    res += 1
                }else{
                    break
                }
            }
            if(ifChecked.last!){
                res += 1
            }
            return res
        }
    }
    
    func calculateHabitInfo(at row: Int) -> [HabitInfo]{
        let total = Shared.sharedInstance.habits[row].checkedDays.count
        let ifChecked: [Bool] = getIfCheckedArray(Shared.sharedInstance.habits[row].checkedDays, Shared.sharedInstance.habits[row].addedDate)
        let longest = getLongestStreak(ifChecked)
        let current = getCurrentStreak(ifChecked)
        let established = epochTimeToString(Shared.sharedInstance.habits[row].addedDate, "yyyy-MM-dd")
        let missed = ifChecked.count - total
        return [HabitInfo(infoName: "Total persisted days", info: String(total) + "d"), HabitInfo(infoName: "Current sequential days", info: String(current) + "d"), HabitInfo(infoName: "Longest record", info: String(longest) + "d"), HabitInfo(infoName: "Missed days", info: String(missed) + "d"),  HabitInfo(infoName: "Established date", info: established)]
    }
    
    func loadHabits(){
        if let messageSender = Auth.auth().currentUser?.email{
            let habitColRef = db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection)
            
            habitColRef.order(by: K.FStore.addedDateField).addSnapshotListener { (querySnapshot, error) in
                Shared.sharedInstance.habits = []
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    if let snapshotDocument = querySnapshot?.documents{
                        for doc in snapshotDocument {
                            let data = doc.data()
                            
                            var todayStatus: Bool = false
                            if let checkedDict = data[K.FStore.checkedField] as? Dictionary<String, Int> {
                                todayStatus = checkedDict[Date().Noon()] != nil
                            }
                            
                            if let habitName = data[K.FStore.habitNameField] as? String, let addedDate = data[K.FStore.addedDateField] as? Int, let isNotificationOn = data[K.FStore.remindField] as? Bool, let selectedDays = data[K.FStore.remindDaysField] as? [Bool], let notificationTime = data[K.FStore.notificationTimeField] as? Int, let cellColor = data[K.FStore.colorField] as? String {
                                Shared.sharedInstance.habits.append(Habit(name: habitName, addedDate: addedDate, ifRemind: isNotificationOn, remindDays: selectedDays, notificationTime: notificationTime, color: cellColor, todayStatus: todayStatus))
                                
                                if let checkedDict = data[K.FStore.checkedField] as? Dictionary<String, Int> {
                                    Shared.sharedInstance.habits[Shared.sharedInstance.habits.count - 1].checkedDays = checkedDict
                                }
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        self.tableView.reloadData()
                        Shared.sharedInstance.habits.forEach{
                            if($0.ifRemind){
                                self.setReminder(habit: $0)
                            }
                        }
                    }
                }
            }
        }
    }
    func loadBadge(){
        if((UserDefaults.standard.object(forKey: "badgeStatus")) != nil){
            self.tabBarController?.tabBar.items?[2].badgeValue = "●"
                self.tabBarController?.tabBar.items?[2].badgeColor = .clear
            self.tabBarController?.tabBar.items?[2].setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red] as [NSAttributedString.Key: Any], for: .normal)
        }
    }
    func sendDoneMessage(habitName: String, messageSender: String){
        let chatColRef = db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.chatCollection)
        chatColRef.addDocument(data: [K.FStore.bodyField: "I have done " + habitName + "!", K.FStore.isIncomingField: false, K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                chatColRef.addDocument(data: [K.FStore.bodyField: K.conversation.randomElement()!, K.FStore.isIncomingField: true, K.FStore.dateField: Date().timeIntervalSince1970]){(error) in
                    if let e = error{
                        print(e.localizedDescription)
                    }else{
                        UserDefaults.standard.set(true, forKey: "badgeStatus")
                        self.loadBadge()
                    }
                }
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shared.sharedInstance.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.habitCell, for: indexPath) as! HabitCell
        
        cell.habitNameLabel.text = Shared.sharedInstance.habits[indexPath.row].name
        cell.contentView.backgroundColor = hexStringToUIColor(hex: Shared.sharedInstance.habits[indexPath.row].color)
        cell.habitNameLabel.textColor = hexStringToUIColor(hex:K.colors[Shared.sharedInstance.habits[indexPath.row].color] ?? "000000") 
        cell.checkmark.image = Shared.sharedInstance.habits[indexPath.row].todayStatus ? UIImage(systemName: "checkmark") : nil
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.habitDetailSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension HomeViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        switch orientation{
        case .right:
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                
                let deleteAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
                
                deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction) in
                    if let messageSender = Auth.auth().currentUser?.email{
                        self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection).document(Shared.sharedInstance.habits[indexPath.row].name).delete() { err in
                            if let err = err {
                                print("Error removing document: \(err)")
                            } else {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }))
                
                deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(deleteAlert, animated: true, completion: nil)
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = hexStringToUIColor(hex: "FD5E53")
            return [deleteAction]
            
            
        case .left:
            if(!Shared.sharedInstance.habits[indexPath.row].todayStatus){
                let doneAction = SwipeAction(style: .destructive, title: "Done") { (action, indexPath) in
                    if let messageSender = Auth.auth().currentUser?.email{
                        self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection).document(Shared.sharedInstance.habits[indexPath.row].name).setData(["checked" : [Date().Noon(): Int(Date().timeIntervalSince1970)]], merge: true) { (error) in
                            if let e = error{
                                self.view.makeToast(e.localizedDescription, duration: 2.0, position: .top)
                            }else{
                                self.sendDoneMessage(habitName: Shared.sharedInstance.habits[indexPath.row].name, messageSender: messageSender)
                            }
                        }
                    }
                }
                doneAction.backgroundColor = hexStringToUIColor(hex: "21BF73")
                doneAction.image = UIImage(systemName: "checkmark.circle")
                return [doneAction]
            }else{
                let undoAction = SwipeAction(style: .destructive, title: "Undo") { (action, indexPath) in
                    if let messageSender = Auth.auth().currentUser?.email{
                        self.db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.habitCollection).document(Shared.sharedInstance.habits[indexPath.row].name).updateData([K.FStore.checkedField + "." + Date().Noon(): FieldValue.delete()])
                    }
                }
                
                undoAction.image = UIImage(systemName: "xmark.circle")
                undoAction.backgroundColor = hexStringToUIColor(hex: "FDD365")
                return [undoAction]
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        switch orientation {
        case .right:
            options.expansionStyle = .none
        case .left:
            options.expansionStyle = .selection
        }
        options.transitionStyle = .border
        return options
    }
}
