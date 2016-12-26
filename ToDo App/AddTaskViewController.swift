//
//  AddTaskViewController.swift
//  ToDo App
//
//  Created by Nitesh on 26/12/16.
//  Copyright © 2016 Nitesh. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet var addTaskField: UITextField!
    
    @IBOutlet var isImp: UISwitch!
    
    
    @IBAction func addBtn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let task = Task(context: context)
        
        task.name = addTaskField.text!
        task.isImportant = isImp.isOn
        
        // Save the data to Core Data
        
        appDelegate.saveContext()
        
        navigationController!.popViewController(animated: true)
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
    }
}
