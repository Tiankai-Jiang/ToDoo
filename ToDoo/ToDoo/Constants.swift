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
    static let colors : [String : String] = ["92C9C4":"FBECCB","E3CFDD":"5E499D","f6cf9d":"783F8C", "DBD786":"2B525F", "E2CD8D":"DF8585", "E9C4C0":"E16466", "FCD9B3":"B6A4A3", "D8F5C7":"87AB84", "C1A2B4":"5D409C", "E3D9D5":"8057A2"]
    static let welcomeText = "To do and achieve yourself"
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
    //need to be added
    //MARK: - conversation
    static let conversation: [String] = ["Little drops of the reservoir， integrated with a large warehouse！Keep doing it, and never ever give up, in the future, you will find that you make it!!!","Good job!!Never， never，never，never give up!!!","Whatever is worth doing is worth doing well.You can do it!!!","Great! You have unlimited potential, all you have to do is keep doing this, and nothing is impossible!!!","Dear, little drops of water finally can wear stone， not because it is strong，but due to circadian won't drop pendant.","I knew you can do it!!!!","A thousand-li journey is started by taking the first step!!!","Better late than never, you can realize all your dreams as long as you keep doing it!","Progress is the activity of today and the assurance of tomorrow!!!","Achievement provides the only real pleasure in life.","As long as you strongly unremittingly in pursuit， you will be able to achieve the purpose!!!","You're capable of achieving all your goals","Keep doing this, then you will find you can change the world!!!","All things are difficult before they are easy, all you have to do is keep doing this!!!","You can make a difference in this world.","Well done! Perseverance can sometimes equal genius in its results!!!","Good! Do you feel happy to do that? You should know that 'insist on not positive energy, adhere to in order to be with a smile', so never give it up.","Efforts and stick to it, is your best look.","Dear! You're so good! In addition to the persistent, there is no other secret to success.","If you insist on your dream, the world will make way for you.","Perseverance is not a long, but one by one the sprint. You should be proud of yourself!!!","Success is need to stick to, adhere to the people all the proud of yourself!","Dream is the most beautiful, the dream weavers. The most important thing is to stick to insist to do.","You made it!!! If you want to give up of that a moment, think about why at the beginning insist on here.","The most wonderful life is not a dream moment, but insists the dream.","Nice!!! Decided to do, then never give up!!!","Success requires our decades of accumulation, persistent belief and unremitting efforts, finally can help you constant dropping wears away a stone.",""]
    
}
