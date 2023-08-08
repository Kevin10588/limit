# Limit

## Overview
### Description

Developed a time management iOS application using SwiftUI, UIKit, Firebase and UserNotifications.
Users are able to set a productivity timer and create task in the TO-DO list while receiving notifications.
There is a cool down section for users that can be utilized by playing two mini games.

## Product Spec

### Screen Archetypes
* Login View
   * Users can register new account prompting required field if the fields are not satisfied they will be prompted the error
   * Existing users can log in with their email and password that is stored on Firebase and they can reset their password
* Timer View
   * Users can start a productivity timer when starting a study session
   * Once the timer is up the user will receive a local notification (UserNotifications)
   * The disable feature will not add points to your productivity score
* Score View
   * Displays the current productivty score based off the timer functionality and To-Do list (Bronze,Siler,Gold)
* Home View
   * Users are initialy shown their current To-Do list with the title
   * User can click the title and see the descrition of the task and can edit the selected task with rescheduling the reminder or deleting task
   * When adding a new Task, the user adds the title and description along with scheduling a reminder with date and time
   * The To-Do list also displays a local notification once the due date is reached (UserNotification). The User in alerted with title and description of task
* Break Time View
   * Displays 2 mini games for the user to take a break from productivity tasks serves as a cool down segment
* Profile View
   * Displays users name and occupation the user can upload an image via URL currently
   * If the user is having trouble using the app they can use the tutorial button
   * Lastly the user can log out of their account

### Mockup
<img src="https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%207.png" width ="100"/> <img src="https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%200.png" width ="100"/> 

<img src= "https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%201.png" width="100"/> <img src="https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%202.png" width ="100"/> <img src= "https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%203.png" width="100"/>

<img src="https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%204.png" width ="100"/> <img src= "https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%206.png" width="100"/> <img src= "https://github.com/lxAnxietyxl/limit/blob/main/LimitMock/Apple%20iPhone%2011%20Pro%20Max%20Screenshot%208.png" width="100"/> 


### Interactive Prototype
![]()

### Data Base
- Firebase
