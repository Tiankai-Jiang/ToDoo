struct K {
    static let loginSegue = "LoginToHome"
    static let registerSegue = "RegisterToHome"
    static let addHabitSegue = "HomeToAddHabit"
    static let selectDaySegue = "addHabitToSelectDay"
    static let habitDetailSegue = "HomeToHabitDetail"
    static let editHabitSegue = "HabitDetailToAddHabit"
    static let passwordResetSegue = "LoginToPasswordReset"
    
    static let homeTitle = "Home"
    static let calendarTitle = "Calendar"
    static let chatTitle = "Chat"
    static let settingsTitle = "Settings"
    
    static let selectDayCell = "selectDayCell"
    
    static let selectedDayKey = "selectedDays"
    static let selectedColorKey = "selectedColor"
    
    static let defaultColor = "92C9C4" //"9DF3C4"
    static let colors : [String : String] = ["92C9C4":"FBECCB","E3CFDD":"5E499D","#f6cf9d":"783F8C", "DBD786":"2B525F", "E2CD8D":"DF8585", "E9C4C0":"E16466", "FCD9B3":"B6A4A3", "D8F5C7":"87AB84", "C1A2B4":"5D409C", "E3D9D5":"8057A2"]
    struct Cells {
        static let habitCell = "habitCell"
        static let habitXib = "HabitCell"
        static let addHabitNameCell = "addHabitNameCell"
        static let addHabitNameXib = "AddHabitNameCell"
        static let addHabitColorCell = "addHabitColorCell"
        static let addHabitColorXib = "AddHabitColorCell"
        static let colorCell = "colorCell"
        static let colorXib = "ColorCell"
        static let addHabitRepeatCell = "addHabitRepeatCell"
        static let addHabitRepeatXib = "AddHabitRepeatCell"
        static let addHabitToggleCell = "addHabitToggleCell"
        static let addHabitToggleXib = "AddHabitToggleCell"
        static let habitDetailCell = "habitDetailCell"
        static let habitDetailXib = "HabitDetailCell"
        static let timelineCell = "timelineCell"
        static let timelineXib = "TimelineCell"
        static let inchatCell = "inChatCell"
        static let inchatXib = "InChatCell"
        static let outchatCell = "outChatCell"
        static let outchatXib = "OutChatCell"
        static let profileImageCell = "profileImageCell"
        static let profileImageXib = "ProfileImageCell"
        static let logoutCell = "logoutCell"
        static let logoutXib = "LogoutCell"
        static let setNameCell = "setNameCell"
        static let setNameXib = "SetNameCell"
    }
    
    struct FStore {
        static let userCollection = "users"
        static let habitCollection = "habits"
        static let habitNameField = "habitName"
        //        static let bodyField = "body"
        static let checkedField = "checked"
        static let addedDateField = "addedDate"
        static let remindField = "ifRemind"
        static let remindDaysField = "remindDays"
        static let notificationTimeField = "notificationTime"
        static let colorField = "cellColor"
        
        static let chatCollection = "chat"
        static let bodyField = "body"
        static let isIncomingField = "isIncoming"
        static let dateField = "date"
        
        static let usernameField = "username"
        static let botnameField = "botname"
    }
    
    static let conversation: [String] = ["You are so fxxking awesome!", "test2", "test3"]
    
}
