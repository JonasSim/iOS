//
//  EditCourseworkViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 20/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit
import CoreData

class EditCourseworkViewController: UIViewController {
    
    // CODE REFERENCE: IDEA WAS TAKEN FROM https://www.youtube.com/watch?v=bmAYYVYzeXk&t=624s
    
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext

    @IBOutlet weak var editCourseworkName: UITextField!
    @IBOutlet weak var editModuleName: UITextField!
    @IBOutlet weak var editLevel: UITextField!
    @IBOutlet weak var editWeight: UITextField!
    @IBOutlet weak var editDuedate: UITextField!
    @IBOutlet weak var editSliderValueLabel: UILabel!
    @IBOutlet weak var editNotes: UITextView!
    
    var sliderInt: String?
    var DUEDATE: Date?
    
    var courseworkName: String?
    var moduleName: String?
    var courseworkLevel: Int16?
    var courseworkWeight: Int16?
    var courseworkDueDate: Date?
    var courseworkMark: String?
    var courseworkNotes: String?
    
    var coursework: Coursework?{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .long
        dateFormatter2.timeStyle = .medium
        
        
        editCourseworkName.text = courseworkName
        editModuleName.text = moduleName
        editLevel.text = String(courseworkLevel!)
        editWeight.text = String(courseworkWeight!)
        editDuedate.text = dateFormatter2.string(from: (coursework?.duedate)!)
        editSliderValueLabel.text = courseworkMark
        editNotes.text = courseworkNotes


        // Do any additional setup after loading the view.
    }
    
    @IBAction func editSliderValue(_ sender: UISlider) {
        
        //get slider value
        editSliderValueLabel.text = String (Int(sender.value))
        sliderInt = (editSliderValueLabel.text)
        
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
        editDuedate.text = dateFormatter.string(from: sender.date)
        DUEDATE = sender.date
        self.view.endEditing(true)
        print(DUEDATE!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let details = self.coursework
        
        let editedCourse = editCourseworkName.text
        let editedModule = editModuleName.text
        let editedLevels = editLevel.text
        let editedWeights = editWeight.text
       // let editedDueDates = editDuedate.text
        let sliderValue = editSliderValueLabel.text
        let editedNote = editNotes.text
        
        
        let editCourse = details
        
        editCourse?.setValue(editedCourse, forKey: "courseworkname")
        editCourse?.setValue(editedModule, forKey: "modulename")
        editCourse?.setValue(Int16(editedLevels!), forKey: "level")
        editCourse?.setValue(Int16(editedWeights!), forKey: "weight")
        editCourse?.setValue(DUEDATE, forKey: "duedate")
        editCourse?.setValue(sliderValue, forKey: "markawarded")
        editCourse?.setValue(editedNote, forKey: "notes")
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        dismiss(animated: true, completion: nil)
  
    }

}
