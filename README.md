# Todoo

An iOS habit tracker using swift 5 and Google firebase. In addition to adding/modifying/removing habits and checking the detailed information about each habit, a virtual chat function was added. Users can personalize the robot's profile image and name, and whenever a habit is checked, the robot will encourage the user in the chat tab. Currently, all the encouragement messages are hardcoded but it can be easily modified to using some AI interface.

# Usage

Replace GoogleService-Info.plist in ./Todoo/Todoo with your own file (you can follow [this link](https://firebase.google.com/docs/ios/setup), then build with XCode.

# Requirements

- XCode 11.0+

- iOS 13.0+

# Demo

The login and register page uses Login Critter and you can find it [here](https://github.com/cgoldsby/LoginCritter).

Register

[<img src="demo/register.gif" width="250"/>](register)

Add a new habit

[<img src="demo/addhabit.gif" width="250"/>](add)

Mark a habit done✅

[<img src="demo/finish.gif" width="250"/>](done)

Check habit detail

<p float="left">
  <img src="demo/habitdetail1.gif" width="250" />
  <img src="demo/habitdetail2.gif" width="250" /> 
</p>

Undo and delete a habit

[<img src="demo/undodelete.gif" width="250"/>](undodelete)

Change profile image and username

<p float="left">
  <img src="demo/changeprofileimage.gif" width="250" />
  <img src="demo/changename.gif" width="250" /> 
</p>