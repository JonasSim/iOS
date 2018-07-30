//
//  AddToCalendarViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 20/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit
import EventKit

class AddToCalendarViewController: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var eventNameTextField: UITextField!
    
    var begginingDate: Date?
    var endingDate: Date?
    var eventName: String?
    let calendarStorage = EKEventStore()
    
    
    override func viewDidLoad() {
        
        begginingDate = Date()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @IBAction func datePicker(_ sender: UITextField) {
        
        let dateChooser: UIDatePicker = UIDatePicker()
        dateChooser.datePickerMode = UIDatePickerMode.date
        sender.inputView = dateChooser
        dateChooser.addTarget(self, action: #selector(AddToCalendarViewController.endDateValueChanged),for: UIControlEvents.valueChanged)
        
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @objc func endDateValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
        endingDate = sender.date
        self.view.endEditing(true)
        
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveToCalendar(_ sender: UIBarButtonItem) {
        
        eventName = eventNameTextField.text
        createEventinTheCalendar(with: eventName!, forDate: (begginingDate ?? nil)!, toDate: (endingDate ?? nil)!)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    //  ------- CODE REFERENCE: http://www.iostutorialjunction.com/2017/09/add-event-to-device-calendar-ios-swift.html
    
    func createEventinTheCalendar(with title:String, forDate eventStartDate:Date, toDate eventEndDate:Date) {
        
        calendarStorage.requestAccess(to: .event) { (success, error) in
            if  error == nil {
                let event = EKEvent.init(eventStore: self.calendarStorage)
                event.title = title
                event.calendar = self.calendarStorage.defaultCalendarForNewEvents // this will return deafult calendar from device calendars
                event.startDate = eventStartDate
                event.endDate = eventEndDate
                
                let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -3600, since: event.startDate))
                event.addAlarm(alarm)
                
                do {
                    try self.calendarStorage.save(event, span: .thisEvent)
                    //event created successfullt to default calendar
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                
            } else {
                //we have error in getting access to device calnedar
                print("error = \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    // -------- END OF CODE REFERENCE

}
