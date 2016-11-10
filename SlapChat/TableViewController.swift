//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance

    override func viewDidLoad() {
      super.viewDidLoad()
        
        store.fetchData()
        print("1. we are bringing the data")
        
        if store.messages.isEmpty {
            print("2. ey! this was empty so we are putting crap inside")
            generateTestData()
            print("we just finished all the crap")
        }
        
        self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        store.fetchData()
        self.tableView.reloadData()
    }
    
    func generateTestData() {
        print("3. we started printing crap")
        store.generateTestData()
        store.saveContext()
        store.fetchData()
        print("we finished printing crap")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        
        cell.textLabel?.text = store.messages[indexPath.row].content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" { return }
        
        
    }
    
}

class addMessageViewController: UIViewController {
    
    let context = DataStore.sharedInstance.persistentContainer.viewContext
    
    
    @IBOutlet weak var text: UITextField!
    
    @IBAction func saveButton(_ sender: UIButton) {
   
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.content = text.text
        message.createdAt = NSDate()
        
        DataStore.sharedInstance.messages.append(message)
        
        navigationController?.popViewController(animated: true)
        }
    
    
    
    
}
