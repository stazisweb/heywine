//
//  AddWorkoutViewController.swift
//  prim7_ CoreData_TableView
//
//  Created by HOME on 6/15/18.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import CoreData

class AddWorkoutViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        // for keyboard hiding
        self.distanceField.delegate = self
        self.durationField.delegate = self
        self.typeField.delegate = self
    }
    
    // hide keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hide keyboard on Done button click
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        distanceField.resignFirstResponder()
        durationField.resignFirstResponder()
        typeField.resignFirstResponder()
        return true
    }
    
    @IBAction func addWorkoutClick(_ sender: Any) {
        context = appDelegate.persistentContainer.viewContext
        
        let newWorkout = NSEntityDescription.insertNewObject(forEntityName: "Workcouts", into: context)
        
        newWorkout.setValue(datePicker.date, forKey: "date")
        newWorkout.setValue(Int(distanceField.text!), forKey: "distance")
        newWorkout.setValue(Int(durationField.text!), forKey: "duration")
        newWorkout.setValue(typeField.text, forKey: "type")
        
        do {
            try context.save()
        } catch {
            print("error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
