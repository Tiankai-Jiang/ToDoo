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
    
    static let conversation: [String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pulvinar pellentesque habitant morbi tristique senectus et. Potenti nullam ac tortor vitae purus faucibus ornare suspendisse.", "Eget velit aliquet sagittis id. Viverra nibh cras pulvinar mattis nunc sed blandit libero volutpat. Urna molestie at elementum eu facilisis sed. Suspendisse in est ante in nibh mauris. Libero nunc consequat interdum varius sit amet mattis vulputate enim.", "Nam at lectus urna duis convallis. Id consectetur purus ut faucibus pulvinar elementum integer enim neque. Adipiscing commodo elit at imperdiet dui accumsan sit amet nulla. Pellentesque sit amet porttitor eget dolor morbi non arcu risus.", "Pellentesque id nibh tortor id aliquet lectus proin nibh. A cras semper auctor neque vitae tempus. Dolor sit amet consectetur adipiscing elit duis. Amet facilisis magna etiam tempor orci eu. Pharetra vel turpis nunc eget lorem dolor.", "Tincidunt praesent semper feugiat nibh sed pulvinar proin gravida hendrerit. Arcu felis bibendum ut tristique et. Eget nunc lobortis mattis aliquam faucibus purus in massa tempor. Tristique senectus et netus et malesuada fames ac. Non arcu risus quis varius quam quisque. Sem viverra aliquet eget sit amet tellus cras adipiscing. Eget magna fermentum iaculis eu non.", "Odio eu feugiat pretium nibh. Lectus arcu bibendum at varius. A arcu cursus vitae congue mauris rhoncus aenean vel. In nibh mauris cursus mattis molestie a iaculis. Sapien nec sagittis aliquam malesuada bibendum. Sodales ut etiam sit amet nisl purus. Egestas quis ipsum suspendisse ultrices gravida dictum.", "Ac tortor vitae purus faucibus ornare suspendisse. Arcu dictum varius duis at. Mauris sit amet massa vitae. Consequat semper viverra nam libero justo laoreet sit amet. Odio pellentesque diam volutpat commodo sed egestas egestas fringilla. Pharetra et ultrices neque ornare aenean euismod. Sit amet porttitor eget dolor morbi non arcu risus quis.", "In nisl nisi scelerisque eu ultrices. In aliquam sem fringilla ut morbi tincidunt. Porta non pulvinar neque laoreet suspendisse interdum consectetur libero. Semper auctor neque vitae tempus quam pellentesque nec nam. Adipiscing elit pellentesque habitant morbi tristique senectus.", "Dictum non consectetur a erat nam at lectus urna duis. Amet nisl suscipit adipiscing bibendum est ultricies integer quis auctor. Morbi quis commodo odio aenean sed. Ante metus dictum at tempor commodo ullamcorper a lacus vestibulum. Blandit turpis cursus in hac habitasse platea dictumst quisque.", "Diam in arcu cursus euismod quis viverra nibh cras. Leo a diam sollicitudin tempor id eu nisl. Consequat nisl vel pretium lectus quam id leo in. Lectus magna fringilla urna porttitor rhoncus dolor purus non enim. Tincidunt ornare massa eget egestas. Sit amet facilisis magna etiam tempor orci eu lobortis.", "Tempor nec feugiat nisl pretium fusce id velit. Integer vitae justo eget magna fermentum iaculis eu non diam. Nunc mi ipsum faucibus vitae aliquet nec. Aliquam vestibulum morbi blandit cursus risus. Proin sed libero enim sed faucibus turpis. Neque sodales ut etiam sit. Mi proin sed libero enim sed faucibus turpis in.", "In cursus turpis massa tincidunt. Id diam maecenas ultricies mi eget mauris. Pharetra vel turpis nunc eget lorem dolor sed viverra ipsum. Diam sollicitudin tempor id eu nisl nunc. Varius sit amet mattis vulputate enim nulla. Fringilla phasellus faucibus scelerisque eleifend donec pretium.", "Viverra maecenas accumsan lacus vel. Etiam erat velit scelerisque in dictum non consectetur a. Sagittis aliquam malesuada bibendum arcu vitae elementum curabitur vitae nunc. Faucibus purus in massa tempor nec feugiat. Viverra aliquet eget sit amet. Pellentesque id nibh tortor id aliquet lectus proin nibh.", "Ac odio tempor orci dapibus ultrices in iaculis nunc. Ultrices eros in cursus turpis. Malesuada proin libero nunc consequat interdum varius sit amet mattis. Id volutpat lacus laoreet non curabitur. Quam nulla porttitor massa id.", "Massa enim nec dui nunc mattis enim ut tellus. Aenean pharetra magna ac placerat vestibulum lectus mauris ultrices eros. Leo a diam sollicitudin tempor id eu nisl nunc. Amet luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor.", "Sit amet dictum sit amet justo donec enim diam vulputate. Id aliquet lectus proin nibh nisl condimentum id venenatis a. Ridiculus mus mauris vitae ultricies leo integer malesuada nunc. Senectus et netus et malesuada fames."]
    
}
