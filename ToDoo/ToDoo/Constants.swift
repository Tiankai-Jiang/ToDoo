struct K {
    static let loginSegue = "LoginToHome"
    static let registerSegue = "RegisterToHome"
    static let addHabitSegue = "HomeToAddHabit"
    static let selectDaySegue = "addHabitToSelectDay"
    
    static let homeTitle = "Home"
    static let calendarTitle = "Calendar"
    static let chatTitle = "Chat"
    static let settingsTitle = "Settings"
    
    static let habitTableViewCell = "habitTableViewCell"
    static let addHabitNameCell = "addHabitNameCell"
    static let addHabitRepeatCell = "addHabitRepeatCell"
    static let addHabitToggleCell = "addHabitToggleCell"
    static let addHabitColorCell = "addHabitColorCell"
    static let selectDayCell = "selectDayCell"
    static let colorCell = "ColorCell"
    
    static let selectedDayKey = "selectedDays"
    static let selectedColorKey = "selectedColor"
    
    static let defaultColor = "9DF3C4"
    
    struct FStore {
        static let userCollection = "users"
        static let habitCollection = "habits"
        static let habitNameField = "habitName"
        //        static let bodyField = "body"
        static let dateField = "addedDate"
        static let remindField = "ifRemind"
        static let remindDaysField = "remindDays"
        static let notificationTimeField = "notificationTime"
        static let colorField = "cellColor"
    }
    
}
