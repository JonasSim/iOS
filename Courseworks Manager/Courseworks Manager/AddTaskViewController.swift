//
//  AddTaskViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 15/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    // Code REFERENCE --------------- from Mobile Native Application Development Lectures week 11 and Master Detail
    
    @IBOutlet weak var labelTaskName: UITextField!
    @IBOutlet weak var labelTaskStartDate: UITextField!
    @IBOutlet weak var labelTaskDueDate: UITextField!
    @IBOutlet weak var labelTaskSliderCompleted: UILabel!
    @IBOutlet weak var labelTaskNotes: UITextView!
    
    var sliderValue: Int = 0
    var currentCoursework: Coursework?
    var startDate: Date?
    var endDate: Date?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func taskSlider(_ sender: UISlider) {
        
        sliderValue = Int(sender.value)
        labelTaskSliderCompleted.text = "\(sliderValue)% Completed"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //labelTaskName.text = currentCoursework?.courseworkname
    }
    
      //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @IBAction func startDate(_ sender: UITextField) {
        
        let dateChooser: UIDatePicker = UIDatePicker()
        dateChooser.datePickerMode = UIDatePickerMode.date
        sender.inputView = dateChooser
        dateChooser.addTarget(self, action: #selector(AddTaskViewController.startDateValueChanged), for: UIControlEvents.valueChanged)

    }
    
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @objc func startDateValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        labelTaskStartDate.text = dateFormatter.string(from: sender.date)
        startDate = sender.date
        self.view.endEditing(true)
        print(startDate!)
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @IBAction func endDate(_ sender: UITextField) {
        
        let dateChooser: UIDatePicker = UIDatePicker()
        dateChooser.datePickerMode = UIDatePickerMode.date
        sender.inputView = dateChooser
        dateChooser.addTarget(self, action: #selector(AddTaskViewController.endDateValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @objc func endDateValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        labelTaskDueDate.text = dateFormatter.string(from: sender.date)
        endDate = sender.date
        self.view.endEditing(true)
        print(endDate!)
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        
        if(currentCoursework != nil){
            
            //save task
            let newTask = Tasks(context: context)
            
            newTask.taskname = labelTaskName.text
            newTask.endday = endDate
            newTask.startday = startDate
            newTask.completed = Int16(sliderValue)
            newTask.notes = labelTaskNotes.text
            
            currentCoursework?.addToRecordCoursework(newTask)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func cancelTask(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
