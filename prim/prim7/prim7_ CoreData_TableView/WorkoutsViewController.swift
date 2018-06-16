//
//  WorkoutsViewController.swift
//  prim7_ CoreData_TableView
//
//  Created by HOME on 6/15/18.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import CoreData

class WorkoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workcouts")
        do {
            let results = try context.fetch(request)
            return results.count
        } catch {
            print("error")
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let dateString = "2018-06-15T10:44:00+0000"
        let dateFormatter = ISO8601DateFormatter()
        let dateStart = dateFormatter.date(from:dateString)!
        let dateString2 = "2018-06-16T10:44:00+0000"
        let dateEnd = dateFormatter.date(from:dateString2)!
        let startDate:NSDate = dateStart as NSDate
        let endDate:NSDate = dateEnd as NSDate
        */
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutTableViewCell
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workcouts")
        
        request.returnsObjectsAsFaults = false
        //request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate, endDate)
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                print(results.count)
                print(indexPath.row)
                let results = results as? [Workcouts]
                let result = results![indexPath.row]
                if let date = result.value(forKey: "date") as? Date,
                    let distance = result.value(forKey: "distance") as? Int32,
                    let duration = result.value(forKey: "duration") as? Int32,
                    let type = result.value(forKey: "type") as? String {
                    cell.distanceLabel.text = String(distance)
                    cell.dateLabel.text = "\(date)"
                    cell.durationLabel.text = String(duration)
                    cell.typeLabel.text = type
                }
            }
        } catch {
            print("error")
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
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
