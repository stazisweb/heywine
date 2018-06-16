//
//  ViewController.swift
//  prim7_ CoreData_TableView
//
//  Created by HOME on 6/15/18.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        /////////SET USER INFORMATION
        /*
         let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
         
         newUser.setValue("Dima", forKey: "name")
         newUser.setValue(1999, forKey: "yearOfBirth")
         newUser.setValue("male", forKey: "sex")
         newUser.setValue(181, forKey: "height")
         newUser.setValue(70, forKey: "weight")
         
         do {
            try context.save()
         } catch {
            print("error")
         }
        */
        
        /////////GET USER INFORMATION

        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                let results = results as? [User]
                let result = results![0]
                if let userName = result.value(forKey: "name") as? String,
                    let userYear = result.value(forKey: "yearOfBirth") as? Int32,
                    let userSex = result.value(forKey: "sex") as? String,
                    let userHeight = result.value(forKey: "height") as? Int32,
                    let userWeight = result.value(forKey: "weight") as? Int32 {
                    name.text = userName
                    year.text = String(userYear)
                    sex.text = userSex
                    height.text = String(userHeight)
                    weight.text = String(userWeight)
                }
                
            }
        } catch {
            print("error")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

