//
//  DetailViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 12/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDelegate,
UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    // Code REFERENCE --------------- from Mobile Native Application Development Lectures week 11 and Master Detail
    
    @IBOutlet weak var tableView: UITableView!
    
    var manageObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    var finishedTasks = NSSet()
    var fetchRequest: NSFetchRequest<Tasks>!
    var task: [Tasks]!
    

    func configureView() {
        // Update the user interface for the detail item.
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "topView" {
            if let topViewController = segue.destination as? TopCourseworkViewController {
                
                if coursework != nil {
                
                let addedTasksNumber = coursework?.recordCoursework?.count
                finishedTasks = coursework?.recordCoursework?.value(forKey: "completed") as! NSSet
                let arrayOne = finishedTasks.allObjects
                let arrayTwo = arrayOne as NSArray
                
                //***************
                var totalTasks: Int = 0
                for allTasks in (arrayTwo as? [Int])!{
                    totalTasks += allTasks
                }
                //***************
                
                if addedTasksNumber != 0 {
                let calculatedPercetage = Double(totalTasks / addedTasksNumber!)
                topViewController.completeLbl = calculatedPercetage
                topViewController.progressBarCalculated = calculatedPercetage
                }
                
                // ?? 0 - Means default value
                topViewController.moduleNameLbl = coursework?.modulename
                topViewController.levelLbl = "\(coursework?.level ?? 0)"
                topViewController.markLbl = coursework?.markawarded
                topViewController.weightLbl = "\(coursework?.weight ?? 0)"
                topViewController.notesFieldLbl = coursework?.notes
                
                }
                
            }
        }
        
        if segue.identifier == "addTasks" {
            if let addTaskViewController = segue.destination as? AddTaskViewController {
                addTaskViewController.currentCoursework = coursework
            }
        }
        
        if segue.identifier == "editCoursework"{
            
            if let editCourse = segue.destination as? EditCourseworkViewController {
                editCourse.courseworkName = coursework?.courseworkname
                editCourse.moduleName = coursework?.modulename
                editCourse.courseworkLevel = coursework?.level
                editCourse.courseworkWeight = coursework?.weight
                editCourse.courseworkDueDate = coursework?.duedate
                editCourse.courseworkMark = coursework?.markawarded
                editCourse.courseworkNotes = coursework?.notes
                editCourse.coursework = self.coursework
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var coursework: Coursework? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    // MARK: - tableView delegate section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectioInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectioInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.delete(self.fetchedResultsController.object(at: indexPath))
            
            do{
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as! TasksCustomTableViewCell
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: TasksCustomTableViewCell, indexPath: IndexPath){
        
        let name = self.fetchedResultsController.fetchedObjects?[indexPath.row].taskname
        cell.taskNameLabel!.text = name
        
        if let taskNotes = self._fetchedResultsController?.fetchedObjects?[indexPath.row].notes {
            cell.taskNotesView?.text = taskNotes
        }else{
            cell.taskNotesView.text = "" // EMPTY NOTES
        }
        
        let complete = self.fetchedResultsController.fetchedObjects?[indexPath.row].completed
            cell.taskCompletedLabel.text = "\(complete!)% Completed"
            cell.customeProgressBar.progress = CGFloat(complete!)/100
        
        let startDay = self.fetchedResultsController.fetchedObjects?[indexPath.row].startday
        let endDay = self.fetchedResultsController.fetchedObjects?[indexPath.row].endday
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour]
        let daysLeftTillTheEnd = formatter.string(from: Date(), to: endDay!)
        if(daysLeftTillTheEnd != ""){
            cell.taskDaysLeftLabel.text = daysLeftTillTheEnd
        }
        
        //If condition is met, the time until will be changed
        if daysLeftTillTheEnd == "0 hours" && complete != 100 {
            cell.taskDaysLeftLabel.text = "Task not met"
            cell.taskDaysLeftLabel.textColor = UIColor.red
        }else if daysLeftTillTheEnd == "0 hours" && complete == 100 {
            cell.taskDaysLeftLabel.text = "Completed"
            cell.taskDaysLeftLabel.textColor = UIColor.green
        }else {
            cell.taskDaysLeftLabel.text = daysLeftTillTheEnd
        }

        //let days = self.fetchedResultsController.fetchedObjects?[indexPath.row].
    }
    
    //MARK = Fetch results controller
    
    var _fetchedResultsController: NSFetchedResultsController<Tasks>? = nil
    var fetchedResultsController: NSFetchedResultsController<Tasks> {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let currentTask = self.coursework
        let request:NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        request.fetchBatchSize = 20
        
        let taskNameSortDescriptor = NSSortDescriptor(key: "taskname", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        request.sortDescriptors = [taskNameSortDescriptor]
        
        if(self.coursework != nil){
            let predicate = NSPredicate(format: "recordTask = %@", currentTask!)
            request.predicate = predicate
        }
//Handle in case if nothing is selected
//            else{
//            let predicate = NSPredicate(format: "coursework = %@", "something")
//            request.predicate = predicate
//        }
        
        let frc = NSFetchedResultsController<Tasks>(
            fetchRequest: request,
            managedObjectContext: manageObjectContext,
            sectionNameKeyPath: #keyPath(Tasks.coursework),
            cacheName: nil)
        frc.delegate = self
        _fetchedResultsController = frc
        
        do {
            try _fetchedResultsController!.performFetch()
        }catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return frc as! NSFetchedResultsController<NSFetchRequestResult> as!
                    NSFetchedResultsController<Tasks>
        
    }  //<---- END
    
    //MARK: Fetch Result table view functions
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    //must have a NSFetchedResultsController to work
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case NSFetchedResultsChangeType(rawValue: 0)!:
            // iOS 8 bug - Do nothing if we get an invalid change type.
            break
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
           self.configureCell(tableView.cellForRow(at: indexPath!)! as! TasksCustomTableViewCell, indexPath: newIndexPath!)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            //    default: break
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    // ----------- CODE REFERENCE END
    
    

}

