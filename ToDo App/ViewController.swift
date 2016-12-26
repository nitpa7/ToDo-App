//
//  ViewController.swift
//  ToDo App
//
//  Created by Nitesh on 22/12/16.
//  Copyright © 2016 Nitesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tasks : [Task] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Getting the Data from Core Data
        getData()
        
        // Reloading the Table View
        tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        if task.isImportant{
        
            cell.textLabel?.text = "☀️ \(task.name)"
            
        }else{
            
            cell.textLabel?.text = task.name
            
        }
        
        return cell
    }
    
    //Data Fetch from Core Data

    func getData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            tasks = try context.fetch(Task.fetchRequest())
        }catch{
            print("Fetching Failed")
        }

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            
            let task = tasks[indexPath.row]
            context.delete(task)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // Once the Task is deleted fetch the data again in the View Load
            do{
                tasks = try context.fetch(Task.fetchRequest())
            }catch{
                print("Fetching Failed")
            }
            
        }
        
        //Relaod the table once deleted
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

