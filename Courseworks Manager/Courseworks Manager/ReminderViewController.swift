//
//  ReminderViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 20/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit
import UserNotifications
import EventKit

class ReminderViewController: UIViewController {
    // CODE REFERENCE - https://www.techotopia.com/index.php/Using_iOS_8_Event_Kit_and_Swift_to_Create_Date_and_Location_Based_Reminders
    // CODE UPDATED FOR THIS PROJECT
    
    @IBOutlet weak var reminderName: UITextField!
    @IBOutlet weak var reminderDate: UITextField!
    var reminderStore = EKEventStore()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var startDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendars =
            reminderStore.calendars(for: EKEntityType.reminder)
        
        for calendar in calendars as [EKCalendar] {
            print("Calendar = \(calendar.title)")
        }

        // Do any additional setup after loading the view.
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @IBAction func datePicker(_ sender: UITextField) {
        let dateChooser: UIDatePicker = UIDatePicker()
        dateChooser.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = dateChooser
        dateChooser.addTarget(self, action: #selector(ReminderViewController.startDateValueChanged), for: UIControlEvents.valueChanged)
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @objc func startDateValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        reminderDate.text = dateFormatter.string(from: sender.date)
        startDate = sender.date
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelReminder(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveReminder(_ sender: UIBarButtonItem) {
        
        if appDelegate.reminderStore == nil {
            appDelegate.reminderStore = EKEventStore()
            
            appDelegate.reminderStore?.requestAccess(
                to: EKEntityType.reminder, completion: {(granted, error) in
                    if !granted {
                        print("Access to store not granted")
                        print(error?.localizedDescription)
                    } else {
                        print("Access granted")
                    }
            })
        }
        
        if (appDelegate.reminderStore != nil) {
            self.createReminder()
        }
        
    }
    
    func createReminder() {
        
        let reminder = EKReminder(eventStore: appDelegate.reminderStore!)
        
        reminder.title = reminderName.text!
        reminder.calendar =
            appDelegate.reminderStore!.defaultCalendarForNewReminders()
        let date = startDate
        let alarm = EKAlarm(absoluteDate: date!)
        
        reminder.addAlarm(alarm)
        
        do {
            try appDelegate.reminderStore?.save(reminder,
                                             commit: true)
            dismiss(animated: true, completion: nil)
        } catch let error {
            print("Reminder failed with error \(error.localizedDescription)")
        }
    }
    
}
