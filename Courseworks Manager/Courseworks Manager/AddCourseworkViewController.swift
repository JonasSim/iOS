//
//  AddCourseworkViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 13/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit
import CoreData


class AddCourseworkViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    var sliderInt: String?
    var DUEDATE: Date?
    
    @IBOutlet weak var courseworkName: UITextField!
    @IBOutlet weak var moduleName: UITextField!
    @IBOutlet weak var courseworkLevel: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var courseWeight: UITextField!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var courseworkNotes: UITextView!
    
    
    @IBAction func courseworkSlider(_ sender: UISlider) {
        
        sliderLabel.text = String (Int(sender.value))
        sliderInt = (sliderLabel.text!)
    
    }
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseWeight.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view.
    }
    
   //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @IBAction func datePicker(_ sender: UITextField) {
    
        let dateChooser: UIDatePicker = UIDatePicker()
        dateChooser.datePickerMode = UIDatePickerMode.date
        sender.inputView = dateChooser
        dateChooser.addTarget(self, action: #selector(AddCourseworkViewController.dueDateValueChanged), for: UIControlEvents.valueChanged)
    }
    
    //The code was taken from https://blog.apoorvmote.com/change-textfield-input-to-datepicker/
    @objc func dueDateValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        dueDate.text = dateFormatter.string(from: sender.date)
        DUEDATE = sender.date
        self.view.endEditing(true)
        print(DUEDATE!)
    }
    
    //Cancels view 
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    //Save coursework
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        
       
    let newCoursework = Coursework(context: context)
        
        if courseworkName.text != "" || moduleName.text != "" || courseworkLevel.text != nil || dueDate != nil || courseWeight != nil {
           
            newCoursework.courseworkname = courseworkName.text
            newCoursework.modulename = moduleName.text
            newCoursework.duedate = DUEDATE
            newCoursework.weight = Int16 (courseWeight.text!)!
            newCoursework.level = Int16 (courseworkLevel.text!)!
            newCoursework.markawarded = sliderInt
            newCoursework.notes = courseworkNotes.text
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            dismiss(animated: true, completion: nil)
            
        }else{
            
            //Alert
            let alert = UIAlertController(title: "Missing coursework name",message: "Please enter a coursework name",preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}
